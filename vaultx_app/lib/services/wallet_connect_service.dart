import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class WalletConnectService {
  static final WalletConnectService _instance = WalletConnectService._internal();
  factory WalletConnectService() => _instance;
  WalletConnectService._internal();

  String? _connectedAccount;
  String? _connectedChainId;
  bool _isConnected = false;

  bool get isConnected => _isConnected;
  String? get connectedAccount => _connectedAccount;
  String? get connectedChainId => _connectedChainId;

  Future<void> initialize() async {
    try {
      debugPrint('WalletConnect service initialized (mock implementation)');
      // Check for existing sessions (mock)
      await _checkExistingSessions();
    } catch (e) {
      debugPrint('WalletConnect initialization error: $e');
    }
  }

  Future<void> _checkExistingSessions() async {
    try {
      // Mock checking existing sessions
      // In production, this would check WalletConnect storage
      debugPrint('Checking for existing sessions...');
    } catch (e) {
      debugPrint('Error checking existing sessions: $e');
    }
  }

  Future<String> connectWallet() async {
    try {
      if (_isConnected) {
        return _connectedAccount!;
      }

      // Mock connection for testing
      return await _mockConnect();
    } catch (e) {
      debugPrint('WalletConnect connection error: $e');
      throw Exception('Failed to connect wallet: $e');
    }
  }

  Future<String> _mockConnect() async {
    // Simulate connection delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Mock wallet address
    _connectedAccount = '0x1234567890123456789012345678901234567890';
    _connectedChainId = '1'; // Ethereum mainnet
    _isConnected = true;
    
    debugPrint('Mock wallet connected: $_connectedAccount');
    return _connectedAccount!;
  }

  Future<void> _openMetaMaskMobile(String uri) async {
    try {
      final metamaskUrl = 'metamask://wc?uri=$uri';
      final universalUrl = 'https://metamask.app.link/wc?uri=$uri';

      if (await canLaunchUrl(Uri.parse(metamaskUrl))) {
        await launchUrl(Uri.parse(metamaskUrl), mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(Uri.parse(universalUrl))) {
        await launchUrl(Uri.parse(universalUrl), mode: LaunchMode.externalApplication);
      } else {
        debugPrint('MetaMask app not found, please install MetaMask');
      }
    } catch (e) {
      debugPrint('Error opening MetaMask: $e');
    }
  }

  Future<void> disconnect() async {
    try {
      _connectedAccount = null;
      _connectedChainId = null;
      _isConnected = false;
      debugPrint('Wallet disconnected');
    } catch (e) {
      debugPrint('Disconnect error: $e');
    }
  }

  Future<String> signMessage(String message) async {
    try {
      if (!_isConnected || _connectedAccount == null) {
        throw Exception('No wallet connected');
      }

      // Mock signature for testing
      await Future.delayed(const Duration(seconds: 1));
      final mockSignature = '0x${List.generate(65, (_) => '0').join()}';
      
      debugPrint('Mock signed message: $message');
      return mockSignature;
    } catch (e) {
      debugPrint('Failed to sign message: $e');
      throw Exception('Failed to sign message: $e');
    }
  }

  String generateQRCodeUri() {
    // Generate mock WalletConnect URI for QR code display
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'wc:8a5e5bdc-0e0f-4c3a-8b5c-6d7e8f9a0b1c@2?relayUrl=wss://relay.reown.com&symKey=$timestamp';
  }

  Map<String, dynamic> getSupportedNetworks() {
    return {
      '1': {'name': 'Ethereum Mainnet', 'symbol': 'ETH'},
      '137': {'name': 'Polygon Mainnet', 'symbol': 'MATIC'},
      '42161': {'name': 'Arbitrum One', 'symbol': 'ETH'},
    };
  }

  bool get isUsingMockImplementation => true;

  // For future real WalletConnect implementation
  Future<void> initializeRealWalletConnect(String projectId) async {
    try {
      debugPrint('Initializing real WalletConnect with project: $projectId');
      // TODO: Implement real WalletConnect when projectId is provided
      // This would use the reown_walletkit package
    } catch (e) {
      debugPrint('Real WalletConnect initialization failed: $e');
    }
  }
}
