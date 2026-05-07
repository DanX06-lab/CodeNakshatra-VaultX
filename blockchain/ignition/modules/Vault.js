const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

const THIRTY_DAYS = 2592000;
const SEVEN_DAYS = 604800;

// For the hackathon demo, we will make your own wallet act as a Guardian, 
// plus a dummy address so the code runs perfectly.
const GUARDIANS = [
  process.env.PUBLIC_WALLET_ADDRESS || "0xea4AF4A9903E1874091e8C90585DB18FdEa429Fb", 
  "0x0000000000000000000000000000000000000000"
]; 
const REQUIRED_APPROVALS = 1; // Only 1 guardian needs to approve for the demo

module.exports = buildModule("VaultModuleV2", (m) => {
  const vault = m.contract("Vault", [THIRTY_DAYS, SEVEN_DAYS, GUARDIANS, REQUIRED_APPROVALS]);
  return { vault };
});