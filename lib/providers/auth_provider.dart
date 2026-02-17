import 'package:flutter/material.dart';
import 'package:my_tiny_journal/services/auth_service.dart';

class FirebaseAuthProvider extends ChangeNotifier {
  final AuthService _authService;
  FirebaseAuthProvider({AuthService? service})
    : _authService = service ?? AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _authService.signIn(email, password);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut()async{
    await _authService.signOut();
  }
}
