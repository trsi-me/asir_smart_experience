import 'dart:convert';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';

/// نسخة المتصفح — بدون SQLite (sqflite لا يعمل على الويب)
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  DatabaseHelper._init();

  bool _ready = false;

  final List<Map<String, dynamic>> _users = [];
  final List<Map<String, dynamic>> _stamps = [];
  final List<Map<String, dynamic>> _trips = [];
  final List<Map<String, dynamic>> _badges = [];
  final List<Map<String, dynamic>> _userPoints = [];
  final List<Map<String, dynamic>> _bookings = [];
  final List<Map<String, dynamic>> _userPhotos = [];
  final List<Map<String, dynamic>> _providerApplications = [];

  int _nextUserId = 1;
  int _nextStampId = 1;
  int _nextTripId = 1;
  int _nextPointsRowId = 1;
  int _nextBookingId = 1;
  int _nextPhotoId = 1;
  int _nextProviderId = 1;

  Future<void> get database async {
    await _ensure();
  }

  Future<void> _ensure() async {
    if (_ready) return;
    _seed();
    _ready = true;
  }

  String _hash(String s) {
    final bytes = utf8.encode(s);
    return sha256.convert(bytes).toString();
  }

  void _seed() {
    final hashAdmin = _hash('admin123');
    final now = DateTime.now().toIso8601String();

    // الزائر = مستخدم غير مسجّل (تصفح فقط). لا نُنشئ "حساب زائر".
    _users.add({
      'id': 1,
      'email': 'admin@asir.sa',
      'password_hash': hashAdmin,
      'name': 'مسؤول النظام',
      'phone': '0500000000',
      'city': 'أبها',
      'created_at': now,
    });
    _nextUserId = 2;

    _userPoints.add(
      {'id': _nextPointsRowId++, 'user_id': 1, 'points': 0},
    );
  }

  /// متوافق مع نسخة الموبايل/الديسكتوب — لا حاجة لتنظيف على الويب لأن البذور هنا في الذاكرة.
  Future<void> purgeLegacyGuestUser() async {
    await _ensure();
  }

  Map<String, dynamic> _copyRow(Map<String, dynamic> m) =>
      Map<String, dynamic>.from(m);

  Future<int?> createUser({
    required String email,
    required String passwordHash,
    required String name,
    String? phone,
    String? city,
  }) async {
    await _ensure();
    if (_users.any((u) => u['email'] == email)) return null;
    final id = _nextUserId++;
    _users.add({
      'id': id,
      'email': email,
      'password_hash': passwordHash,
      'name': name,
      'phone': phone ?? '',
      'city': city ?? '',
      'created_at': DateTime.now().toIso8601String(),
    });
    _userPoints.add({'id': _nextPointsRowId++, 'user_id': id, 'points': 0});
    return id;
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    await _ensure();
    try {
      final u = _users.firstWhere((e) => e['email'] == email);
      return _copyRow(u);
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserById(int id) async {
    await _ensure();
    try {
      final u = _users.firstWhere((e) => e['id'] == id);
      return _copyRow(u);
    } catch (_) {
      return null;
    }
  }

  Future<int> getPoints(int? userId) async {
    if (userId == null) return 0;
    await _ensure();
    try {
      final r = _userPoints.firstWhere((e) => e['user_id'] == userId);
      return r['points'] as int? ?? 0;
    } catch (_) {
      return 0;
    }
  }

  Future<List<Map<String, dynamic>>> getStamps(int? userId) async {
    if (userId == null) return [];
    await _ensure();
    final list = _stamps.where((s) => s['user_id'] == userId).toList();
    list.sort(
      (a, b) =>
          (b['acquired_at'] as String).compareTo(a['acquired_at'] as String),
    );
    return list.map(_copyRow).toList();
  }

  Future<bool> hasStampForPlace(int? userId, String placeId) async {
    if (userId == null) return false;
    await _ensure();
    return _stamps.any(
      (s) => s['user_id'] == userId && s['place_id'] == placeId,
    );
  }

  Future<List<Map<String, dynamic>>> getTrips(int? userId) async {
    if (userId == null) return [];
    await _ensure();
    final list = _trips.where((t) => t['user_id'] == userId).toList();
    list.sort((a, b) => (b['date'] as String).compareTo(a['date'] as String));
    return list.map(_copyRow).toList();
  }

  Future<List<Map<String, dynamic>>> getBadges(int? userId) async {
    if (userId == null) return [];
    await _ensure();
    return _badges.where((b) => b['user_id'] == userId).map(_copyRow).toList();
  }

  Future<bool> removeStamp(int? userId, int stampId) async {
    if (userId == null) return false;
    await _ensure();
    final ix = _stamps.indexWhere(
      (s) => s['id'] == stampId && s['user_id'] == userId,
    );
    if (ix < 0) return false;
    _stamps.removeAt(ix);
    try {
      final pr = _userPoints.firstWhere((e) => e['user_id'] == userId);
      final p = (pr['points'] as int? ?? 0) - 10;
      pr['points'] = math.max(0, p);
    } catch (_) {}
    return true;
  }

  Future<bool> addStamp(
    int? userId,
    String placeId,
    String placeName,
    String category,
  ) async {
    if (userId == null) return false;
    final uid = userId;
    final has = await hasStampForPlace(uid, placeId);
    if (has) return false;
    await _ensure();
    _stamps.add({
      'id': _nextStampId++,
      'user_id': uid,
      'place_id': placeId,
      'place_name': placeName,
      'category': category,
      'acquired_at': DateTime.now().toIso8601String(),
    });
    try {
      final pr = _userPoints.firstWhere((e) => e['user_id'] == uid);
      pr['points'] = (pr['points'] as int? ?? 0) + 10;
    } catch (_) {
      _userPoints.add({'id': _nextPointsRowId++, 'user_id': uid, 'points': 10});
    }
    return true;
  }

  Future<int> addBooking(
    int? userId,
    String experienceName,
    String accommodation,
    String transport,
  ) async {
    if (userId == null) return -1;
    final uid = userId;
    await _ensure();
    final id = _nextBookingId++;
    _bookings.add({
      'id': id,
      'user_id': uid,
      'experience_name': experienceName,
      'accommodation': accommodation,
      'transport': transport,
      'created_at': DateTime.now().toIso8601String(),
    });
    return id;
  }

  Future<List<Map<String, dynamic>>> getBookings(int? userId) async {
    if (userId == null) return [];
    await _ensure();
    final list = _bookings.where((b) => b['user_id'] == userId).toList();
    list.sort(
      (a, b) =>
          (b['created_at'] as String).compareTo(a['created_at'] as String),
    );
    return list.map(_copyRow).toList();
  }

  Future<int> addTrip(
    int? userId,
    String destination,
    String date, [
    String? notes,
  ]) async {
    if (userId == null) return -1;
    final uid = userId;
    await _ensure();
    final id = _nextTripId++;
    _trips.add({
      'id': id,
      'user_id': uid,
      'destination': destination,
      'date': date,
      'notes': notes ?? '',
    });
    return id;
  }

  Future<void> addPoints(int? userId, int points) async {
    if (userId == null) return;
    await _ensure();
    try {
      final pr = _userPoints.firstWhere((e) => e['user_id'] == userId);
      pr['points'] = (pr['points'] as int? ?? 0) + points;
    } catch (_) {
      _userPoints.add({
        'id': _nextPointsRowId++,
        'user_id': userId,
        'points': points,
      });
    }
  }

  Future<int> addUserPhoto(int? userId, String placeId, String filePath) async {
    if (userId == null) return -1;
    final uid = userId;
    await _ensure();
    final id = _nextPhotoId++;
    _userPhotos.add({
      'id': id,
      'user_id': uid,
      'place_id': placeId,
      'file_path': filePath,
      'created_at': DateTime.now().toIso8601String(),
    });
    return id;
  }

  Future<List<Map<String, dynamic>>> getUserPhotosForPlace(
    int? userId,
    String placeId,
  ) async {
    if (userId == null) return [];
    await _ensure();
    final list = _userPhotos
        .where((p) => p['user_id'] == userId && p['place_id'] == placeId)
        .toList();
    list.sort(
      (a, b) =>
          (b['created_at'] as String).compareTo(a['created_at'] as String),
    );
    return list.map(_copyRow).toList();
  }

  Future<Map<String, dynamic>> getStats(int? userId) async {
    if (userId == null) return {'visits': 0, 'trips': 0, 'badges': 0};
    final stamps = await getStamps(userId);
    final trips = await getTrips(userId);
    final badges = await getBadges(userId);
    return {
      'visits': stamps.length,
      'trips': trips.length,
      'badges': badges.length,
    };
  }

  Future<int> insertProviderApplication(Map<String, dynamic> row) async {
    await _ensure();
    final id = _nextProviderId++;
    final copy = Map<String, dynamic>.from(row);
    copy['id'] = id;
    _providerApplications.add(copy);
    return id;
  }

  Future<List<Map<String, dynamic>>> getProviderApplicationsByEmail(
    String email,
  ) async {
    await _ensure();
    final list = _providerApplications
        .where((e) => e['email'] == email)
        .toList();
    list.sort(
      (a, b) =>
          (b['created_at'] as String).compareTo(a['created_at'] as String),
    );
    return list.map(_copyRow).toList();
  }

  Future<List<Map<String, dynamic>>> getProviderApplicationsPending() async {
    await _ensure();
    final list = _providerApplications
        .where(
          (e) =>
              e['status'] == 'pending' || e['status'] == 'needs_revision',
        )
        .toList();
    list.sort(
      (a, b) =>
          (b['created_at'] as String).compareTo(a['created_at'] as String),
    );
    return list.map(_copyRow).toList();
  }

  Future<void> updateProviderApplicationStatus(int id, String status) async {
    await _ensure();
    final ix = _providerApplications.indexWhere((e) => e['id'] == id);
    if (ix >= 0) _providerApplications[ix]['status'] = status;
  }

  Future<List<Map<String, dynamic>>> getProviderApplicationsAccepted() async {
    await _ensure();
    final list = _providerApplications
        .where((e) => e['status'] == 'accepted')
        .toList();
    list.sort(
      (a, b) =>
          (b['created_at'] as String).compareTo(a['created_at'] as String),
    );
    return list.map(_copyRow).toList();
  }

  Future<Map<String, dynamic>?> getLatestProviderApplicationByEmail(
    String email,
  ) async {
    final list = await getProviderApplicationsByEmail(email);
    return list.isNotEmpty ? list.first : null;
  }

  Future<void> updateProviderApplicationOffers(int id, String offers) async {
    await _ensure();
    final ix = _providerApplications.indexWhere((e) => e['id'] == id);
    if (ix >= 0) _providerApplications[ix]['offers'] = offers;
  }
}
