import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  static const String _adminUsername = 'admin';
  static const String _adminPassword = 'admin123';

  bool _isAuthenticated = false;
  String? _currentAdmin;

  bool get isAuthenticated => _isAuthenticated;
  String? get currentAdmin => _currentAdmin;

  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (username == _adminUsername && password == _adminPassword) {
      _isAuthenticated = true;
      _currentAdmin = username;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _isAuthenticated = false;
    _currentAdmin = null;
    notifyListeners();
  }

  bool validateSession() {
    return _isAuthenticated;
  }
}
