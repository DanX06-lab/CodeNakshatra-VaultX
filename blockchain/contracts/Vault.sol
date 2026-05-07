// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Vault {
    address public owner;
    uint256 public lastActivity;
    uint256 public inactivityPeriod;
    uint256 public gracePeriod;
    uint256 public gracePeriodStart;
    bool public releaseTriggered;

    // USP #1: Percentage Splits
    struct Beneficiary {
        address payable wallet;
        uint256 percentage; // Must sum to exactly 100
    }
    Beneficiary[] public beneficiaries;

    // USP #2: Guardian Approvals
    mapping(address => bool) public isGuardian;
    uint256 public requiredApprovals;
    uint256 public currentApprovals;
    
    // Security: Tracks which cycle we are on so old approvals don't carry over
    uint256 public releaseCycle; 
    mapping(uint256 => mapping(address => bool)) public hasApproved;

    // Events for our Node.js Backend to listen to
    event ActivityLogged(uint256 timestamp);
    event ReleaseTriggered(uint256 graceEndTimestamp, uint256 cycle);
    event GuardianApproved(address guardian, uint256 cycle);
    event FundsReleased(uint256 totalAmount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    modifier onlyGuardian() {
        require(isGuardian[msg.sender], "Not a guardian");
        _;
    }

    constructor(
        uint256 _inactivityPeriod, 
        uint256 _gracePeriod,
        address[] memory _guardians,
        uint256 _requiredApprovals
    ) payable {
        owner = msg.sender;
        lastActivity = block.timestamp;
        inactivityPeriod = _inactivityPeriod;
        gracePeriod = _gracePeriod;
        
        require(_requiredApprovals <= _guardians.length, "Invalid approval requirement");
        for(uint i = 0; i < _guardians.length; i++) {
            isGuardian[_guardians[i]] = true;
        }
        requiredApprovals = _requiredApprovals;
    }

    // USP #3: Manual Check-in (Resets the timer without moving money)
    function ping() external onlyOwner {
        lastActivity = block.timestamp;
        releaseTriggered = false; 
        currentApprovals = 0; 
        emit ActivityLogged(block.timestamp);
    }

    // Define who gets what percentage
    function setBeneficiaries(address payable[] memory _wallets, uint256[] memory _percentages) external onlyOwner {
        require(_wallets.length == _percentages.length, "Mismatched arrays");
        uint256 total = 0;
        for(uint i = 0; i < _percentages.length; i++) {
            total += _percentages[i];
        }
        require(total == 100, "Percentages must equal 100");

        delete beneficiaries; // Clear old list
        for(uint i = 0; i < _wallets.length; i++) {
            beneficiaries.push(Beneficiary(_wallets[i], _percentages[i]));
        }
    }

    // Beneficiary hits this if owner goes missing
    function triggerRelease() external {
        require(block.timestamp > lastActivity + inactivityPeriod, "Owner is still active");
        require(!releaseTriggered, "Already triggered");

        releaseTriggered = true;
        gracePeriodStart = block.timestamp;
        releaseCycle++; // Start a new security cycle
        
        emit ReleaseTriggered(gracePeriodStart + gracePeriod, releaseCycle);
    }

    // Guardian must call this during the grace period
    function approveRelease() external onlyGuardian {
        require(releaseTriggered, "Release not triggered");
        require(!hasApproved[releaseCycle][msg.sender], "Already approved this cycle");
        
        hasApproved[releaseCycle][msg.sender] = true;
        currentApprovals++;
        emit GuardianApproved(msg.sender, releaseCycle);
    }

    // The final step: distributes the money
    function executeRelease() external {
        require(releaseTriggered, "Not triggered");
        require(block.timestamp > gracePeriodStart + gracePeriod, "Grace period active");
        require(currentApprovals >= requiredApprovals, "Not enough guardian approvals");

        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to release");

        for(uint i = 0; i < beneficiaries.length; i++) {
            uint256 amount = (balance * beneficiaries[i].percentage) / 100;
            beneficiaries[i].wallet.transfer(amount);
        }

        emit FundsReleased(balance);
    }

    // Allow contract to receive ETH deposits
    receive() external payable {}
}