import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/database_helper.dart';

/// خدمة المصادقة — تسجيل دخول وإنشاء حساب فقط.
class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  static const String _keyUserId = 'current_user_id';
  static const String _keyUserName = 'current_user_name';
  static const String _keyUserEmail = 'current_user_email';

  int? _currentUserId;
  String? _currentUserName;
  String? _currentUserEmail;

  int? get currentUserId => _currentUserId;
  String? get currentUserName => _currentUserName;
  String? get currentUserEmail => _currentUserEmail;
  bool get isLoggedIn => _currentUserId != null;

  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _currentUserId = prefs.getInt(_keyUserId);
      _currentUserName = prefs.getString(_keyUserName);
      _currentUserEmail = prefs.getString(_keyUserEmail);
    } on PlatformException catch (_) {
      _currentUserId = null;
      _currentUserName = null;
      _currentUserEmail = null;
    }
    // إزالة جلسة "حساب الزائر" القديمة (guest@asir.sa) — الزائر الآن غير مسجّل.
    if (_currentUserEmail == 'guest@asir.sa') {
      await logout();
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('guest_browsing');
    } on PlatformException catch (_) {}
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<bool> login(String email, String password) async {
    final user = await DatabaseHelper.instance.getUserByEmail(email);
    if (user == null) return false;
    final hash = _hashPassword(password);
    if (user['password_hash'] != hash) return false;

    _currentUserId = user['id'] as int;
    _currentUserName = user['name'] as String? ?? email;
    _currentUserEmail = user['email'] as String? ?? email;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_keyUserId, _currentUserId!);
      await prefs.setString(_keyUserName, _currentUserName!);
      await prefs.setString(_keyUserEmail, _currentUserEmail!);
    } on PlatformException catch (_) {}
    return true;
  }

  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String name,
    String? phone,
    String? city,
  }) async {
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      return {'success': false, 'message': 'جميع الحقول مطلوبة'};
    }
    if (password.length < 6) {
      return {'success': false, 'message': 'كلمة المرور ٦ أحرف على الأقل'};
    }

    final exists = await DatabaseHelper.instance.getUserByEmail(email);
    if (exists != null) {
      return {'success': false, 'message': 'البريد مستخدم مسبقاً'};
    }

    final userId = await DatabaseHelper.instance.createUser(
      email: email,
      passwordHash: _hashPassword(password),
      name: name,
      phone: phone,
      city: city,
    );
    if (userId == null)
      return {'success': false, 'message': 'فشل إنشاء الحساب'};

    _currentUserId = userId;
    _currentUserName = name;
    _currentUserEmail = email;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_keyUserId, userId);
      await prefs.setString(_keyUserName, name);
      await prefs.setString(_keyUserEmail, email);
    } on PlatformException catch (_) {}
    return {'success': true};
  }

  Future<void> logout() async {
    _currentUserId = null;
    _currentUserName = null;
    _currentUserEmail = null;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyUserId);
      await prefs.remove(_keyUserName);
      await prefs.remove(_keyUserEmail);
    } on PlatformException catch (_) {}
  }
}
