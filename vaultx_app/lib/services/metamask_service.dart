import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class MetaMaskService {
  static final MetaMaskService _instance = MetaMaskService._internal();
  factory MetaMaskService() => _instance;
  MetaMaskService._internal();

  bool _isInstalled = false;
  String? _currentAccount;
  String? _currentChainId;
  
  bool get isInstalled => _isInstalled;
  String? get currentAccount => _currentAccount;
  String? get currentChainId => _currentChainId;

  Future<void> initialize() async {
    try {
      if (kIsWeb) {
        // For web, we'll use a JavaScript channel approach
        _isInstalled = await _checkMetaMaskWeb();
        
        if (_isInstalled) {
          await _checkConnection();
        }
      } else {
        debugPrint('MetaMask is only supported on web platform');
      }
    } catch (e) {
      debugPrint('MetaMask initialization error: $e');
    }
  }

  Future<bool> _checkMetaMaskWeb() async {
    // This would be implemented with JavaScript channel for web
    // For now, return false to avoid JS issues on mobile
    return false;
  }

  Future<void> _checkConnection() async {
    try {
      // Mock implementation for now
      debugPrint('Checking MetaMask connection...');
    } catch (e) {
      debugPrint('Error checking connection: $e');
    }
  }

  Future<String?> connectWallet() async {
    try {
      if (!kIsWeb) {
        throw Exception('MetaMask is only available on web browsers. Please use WalletConnect for mobile.');
      }

      if (!_isInstalled) {
        throw Exception('MetaMask is not installed');
      }

      // Mock implementation for now
      await Future.delayed(const Duration(seconds: 2));
      _currentAccount = '0x1234567890123456789012345678901234567890';
      _currentChainId = '0x1';
      
      return _currentAccount;
    } catch (e) {
      throw Exception('Failed to connect wallet: $e');
    }
  }

  Future<void> switchNetwork(String chainId) async {
    try {
      if (!kIsWeb) {
        throw Exception('MetaMask is only available on web');
      }

      if (!_isInstalled) {
        throw Exception('MetaMask is not installed');
      }

      // Mock implementation
      _currentChainId = chainId;
      debugPrint('Switched to network: $chainId');
    } catch (e) {
      throw Exception('Failed to switch network: $e');
    }
  }

  Future<String> signMessage(String message) async {
    try {
      if (_currentAccount == null) {
        throw Exception('No wallet connected');
      }

      if (!kIsWeb) {
        throw Exception('MetaMask is only available on web');
      }

      // Mock implementation
      await Future.delayed(const Duration(seconds: 1));
      final mockSignature = '0x${List.generate(65, (_) => '0').join()}';
      
      debugPrint('Mock signed message: $message');
      return mockSignature;
    } catch (e) {
      throw Exception('Failed to sign message: $e');
    }
  }

  Future<void> disconnect() async {
    _currentAccount = null;
    _currentChainId = null;
    debugPrint('MetaMask disconnected');
  }

  Map<String, dynamic> getNetworkConfig(String chainId) {
    switch (chainId) {
      case '0x1': // Ethereum Mainnet
        return {
          'chainId': '0x1',
          'chainName': 'Ethereum Mainnet',
          'nativeCurrency': {'name': 'ETH', 'symbol': 'ETH', 'decimals': 18},
          'rpcUrls': ['https://mainnet.infura.io/v3/'],
          'blockExplorerUrls': ['https://etherscan.io'],
        };
      case '0x89': // Polygon Mainnet
        return {
          'chainId': '0x89',
          'chainName': 'Polygon Mainnet',
          'nativeCurrency': {'name': 'MATIC', 'symbol': 'MATIC', 'decimals': 18},
          'rpcUrls': ['https://polygon-rpc.com/'],
          'blockExplorerUrls': ['https://polygonscan.com'],
        };
      case '0xa4b1': // Arbitrum One
        return {
          'chainId': '0xa4b1',
          'chainName': 'Arbitrum One',
          'nativeCurrency': {'name': 'ETH', 'symbol': 'ETH', 'decimals': 18},
          'rpcUrls': ['https://arb1.arbitrum.io/rpc'],
          'blockExplorerUrls': ['https://arbiscan.io'],
        };
      default:
        throw Exception('Unsupported network: $chainId');
    }
  }

  bool get isWebOnly => true;
}
