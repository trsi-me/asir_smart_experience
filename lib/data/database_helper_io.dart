import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/// قاعدة بيانات محلية - مستخدمين وجواز عسير (SQLite — موبايل/ديسكتوب)
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get _db async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  /// يُنتظر من شاشة البداية حتى تجهيز قاعدة البيانات.
  Future<void> get database async {
    await _db;
  }

  Future<Database> _initDb() async {
    final docsPath = await getApplicationDocumentsDirectory();
    final path = join(docsPath.path, 'asir_passport.db');

    return await openDatabase(
      path,
      version: 4,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE NOT NULL,
        password_hash TEXT NOT NULL,
        name TEXT NOT NULL,
        phone TEXT,
        created_at TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE stamps (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL DEFAULT 1,
        place_id TEXT NOT NULL,
        place_name TEXT NOT NULL,
        category TEXT NOT NULL,
        acquired_at TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id)
      )
    ''');
    await db.execute('''
      CREATE TABLE trips (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL DEFAULT 1,
        destination TEXT NOT NULL,
        date TEXT NOT NULL,
        notes TEXT,
        FOREIGN KEY (user_id) REFERENCES users(id)
      )
    ''');
    await db.execute('''
      CREATE TABLE badges (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL DEFAULT 1,
        badge_id TEXT NOT NULL,
        badge_name TEXT NOT NULL,
        acquired_at TEXT,
        FOREIGN KEY (user_id) REFERENCES users(id)
      )
    ''');
    await db.execute('''
      CREATE TABLE user_points (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER UNIQUE NOT NULL,
        points INTEGER DEFAULT 0,
        FOREIGN KEY (user_id) REFERENCES users(id)
      )
    ''');
    await db.execute('''
      CREATE TABLE bookings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL DEFAULT 1,
        experience_name TEXT NOT NULL,
        accommodation TEXT NOT NULL,
        transport TEXT NOT NULL,
        created_at TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id)
      )
    ''');
    await db.execute('''
      CREATE TABLE user_photos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL DEFAULT 1,
        place_id TEXT NOT NULL,
        file_path TEXT NOT NULL,
        created_at TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id)
      )
    ''');
    await _seedDefaultUsers(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 4) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS user_photos (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER NOT NULL DEFAULT 1,
          place_id TEXT NOT NULL,
          file_path TEXT NOT NULL,
          created_at TEXT NOT NULL,
          FOREIGN KEY (user_id) REFERENCES users(id)
        )
      ''');
    }
    if (oldVersion < 3) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS bookings (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER NOT NULL DEFAULT 1,
          experience_name TEXT NOT NULL,
          accommodation TEXT NOT NULL,
          transport TEXT NOT NULL,
          created_at TEXT NOT NULL,
          FOREIGN KEY (user_id) REFERENCES users(id)
        )
      ''');
    }
    if (oldVersion < 2) {
      try { await db.execute('ALTER TABLE stamps ADD COLUMN user_id INTEGER DEFAULT 1'); } catch (_) {}
      try { await db.execute('ALTER TABLE trips ADD COLUMN user_id INTEGER DEFAULT 1'); } catch (_) {}
      try { await db.execute('ALTER TABLE badges ADD COLUMN user_id INTEGER DEFAULT 1'); } catch (_) {}
      await db.execute('CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT UNIQUE NOT NULL, password_hash TEXT NOT NULL, name TEXT NOT NULL, phone TEXT, created_at TEXT NOT NULL)');
      try {
        final hasOld = await db.rawQuery('SELECT name FROM sqlite_master WHERE type=\'table\' AND name=\'user_points\'');
        if (hasOld.isNotEmpty) {
          await db.execute('CREATE TABLE user_points_new (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id INTEGER UNIQUE NOT NULL, points INTEGER DEFAULT 0)');
          final old = await db.query('user_points');
          if (old.isNotEmpty) {
            await db.insert('user_points_new', {'user_id': 1, 'points': old.first['points'] ?? 0});
          }
          await db.execute('DROP TABLE user_points');
          await db.execute('ALTER TABLE user_points_new RENAME TO user_points');
        } else {
          await db.execute('CREATE TABLE IF NOT EXISTS user_points (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id INTEGER UNIQUE NOT NULL, points INTEGER DEFAULT 0)');
        }
      } catch (_) {
        await db.execute('CREATE TABLE IF NOT EXISTS user_points (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id INTEGER UNIQUE NOT NULL, points INTEGER DEFAULT 0)');
      }
      await _seedDefaultUsers(db);
    }
  }

  String _hash(String s) {
    final bytes = utf8.encode(s);
    return sha256.convert(bytes).toString();
  }

  Future<void> _seedDefaultUsers(Database db) async {
    final hashGuest = _hash('123456');
    final hashAdmin = _hash('admin123');
    final now = DateTime.now().toIso8601String();

    try {
      await db.insert('users', {
        'email': 'guest@asir.sa',
        'password_hash': hashGuest,
        'name': 'زائر',
        'phone': '',
        'created_at': now,
      });
      await db.insert('users', {
        'email': 'admin@asir.sa',
        'password_hash': hashAdmin,
        'name': 'مستخدم تجريبي',
        'phone': '0500000000',
        'created_at': now,
      });
    } catch (_) {}

    await db.insert('user_points', {'user_id': 1, 'points': 45}, conflictAlgorithm: ConflictAlgorithm.replace);
    await db.insert('user_points', {'user_id': 2, 'points': 120}, conflictAlgorithm: ConflictAlgorithm.replace);

    try {
      await db.insert('stamps', {'user_id': 1, 'place_id': 'fog', 'place_name': 'موسم الضباب', 'category': 'ضباب', 'acquired_at': now});
      await db.insert('stamps', {'user_id': 1, 'place_id': 'coffee', 'place_name': 'مزرعة البن', 'category': 'بن', 'acquired_at': now});
      await db.insert('trips', {'user_id': 1, 'destination': 'أبها', 'date': '2025-01-15', 'notes': 'رحلة عائلية'});
      await db.insert('trips', {'user_id': 1, 'destination': 'السودة', 'date': '2025-02-01', 'notes': ''});
      await db.insert('stamps', {'user_id': 2, 'place_id': 'heritage', 'place_name': 'رجال ألمع', 'category': 'تراث', 'acquired_at': now});
      await db.insert('stamps', {'user_id': 2, 'place_id': 'hiking', 'place_name': 'مسار السودة', 'category': 'طبيعة', 'acquired_at': now});
      await db.insert('stamps', {'user_id': 2, 'place_id': 'coffee', 'place_name': 'قهوة رجال ألمع', 'category': 'بن', 'acquired_at': now});
      await db.insert('trips', {'user_id': 2, 'destination': 'رجال ألمع', 'date': '2025-02-10', 'notes': 'زيارة تراثية'});
    } catch (_) {}
  }

  Future<int?> createUser({required String email, required String passwordHash, required String name, String? phone}) async {
    final db = await _db;
    try {
      final id = await db.insert('users', {
        'email': email,
        'password_hash': passwordHash,
        'name': name,
        'phone': phone ?? '',
        'created_at': DateTime.now().toIso8601String(),
      });
      await db.insert('user_points', {'user_id': id, 'points': 0});
      return id;
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await _db;
    final r = await db.query('users', where: 'email = ?', whereArgs: [email]);
    return r.isNotEmpty ? Map<String, dynamic>.from(r.first) : null;
  }

  Future<Map<String, dynamic>?> getUserById(int id) async {
    final db = await _db;
    final r = await db.query('users', where: 'id = ?', whereArgs: [id]);
    return r.isNotEmpty ? Map<String, dynamic>.from(r.first) : null;
  }

  Future<int> getPoints(int? userId) async {
    if (userId == null) return 0;
    final db = await _db;
    final r = await db.query('user_points', where: 'user_id = ?', whereArgs: [userId]);
    return r.isNotEmpty ? (r.first['points'] as int? ?? 0) : 0;
  }

  Future<List<Map<String, dynamic>>> getStamps(int? userId) async {
    if (userId == null) return [];
    final db = await _db;
    final list = await db.query('stamps', where: 'user_id = ?', whereArgs: [userId], orderBy: 'acquired_at DESC');
    return list.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Future<bool> hasStampForPlace(int? userId, String placeId) async {
    if (userId == null) return false;
    final db = await _db;
    final r = await db.query('stamps', where: 'user_id = ? AND place_id = ?', whereArgs: [userId, placeId]);
    return r.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> getTrips(int? userId) async {
    if (userId == null) return [];
    final db = await _db;
    final list = await db.query('trips', where: 'user_id = ?', whereArgs: [userId], orderBy: 'date DESC');
    return list.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Future<List<Map<String, dynamic>>> getBadges(int? userId) async {
    if (userId == null) return [];
    final db = await _db;
    final list = await db.query('badges', where: 'user_id = ?', whereArgs: [userId]);
    return list.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Future<bool> removeStamp(int? userId, int stampId) async {
    if (userId == null) return false;
    final db = await _db;
    final stamp = await db.query('stamps', where: 'id = ? AND user_id = ?', whereArgs: [stampId, userId]);
    if (stamp.isEmpty) return false;
    await db.delete('stamps', where: 'id = ? AND user_id = ?', whereArgs: [stampId, userId]);
    await db.rawUpdate('UPDATE user_points SET points = MAX(0, points - 10) WHERE user_id = ?', [userId]);
    return true;
  }

  Future<bool> addStamp(int? userId, String placeId, String placeName, String category) async {
    final uid = userId ?? 1;
    final has = await hasStampForPlace(uid, placeId);
    if (has) return false;
    final db = await _db;
    await db.insert('stamps', {
      'user_id': uid,
      'place_id': placeId,
      'place_name': placeName,
      'category': category,
      'acquired_at': DateTime.now().toIso8601String(),
    });
    await db.rawUpdate('UPDATE user_points SET points = points + ? WHERE user_id = ?', [10, uid]);
    return true;
  }

  Future<int> addBooking(int? userId, String experienceName, String accommodation, String transport) async {
    final uid = userId ?? 1;
    final db = await _db;
    return await db.insert('bookings', {
      'user_id': uid,
      'experience_name': experienceName,
      'accommodation': accommodation,
      'transport': transport,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getBookings(int? userId) async {
    if (userId == null) return [];
    final db = await _db;
    final list = await db.query('bookings', where: 'user_id = ?', whereArgs: [userId], orderBy: 'created_at DESC');
    return list.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Future<int> addTrip(int? userId, String destination, String date, [String? notes]) async {
    final uid = userId ?? 1;
    final db = await _db;
    return await db.insert('trips', {
      'user_id': uid,
      'destination': destination,
      'date': date,
      'notes': notes ?? '',
    });
  }

  Future<void> addPoints(int? userId, int points) async {
    if (userId == null) return;
    final db = await _db;
    await db.rawUpdate('UPDATE user_points SET points = points + ? WHERE user_id = ?', [points, userId]);
  }

  Future<int> addUserPhoto(int? userId, String placeId, String filePath) async {
    final uid = userId ?? 1;
    final db = await _db;
    return await db.insert('user_photos', {
      'user_id': uid,
      'place_id': placeId,
      'file_path': filePath,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getUserPhotosForPlace(int? userId, String placeId) async {
    if (userId == null) return [];
    final db = await _db;
    final list = await db.query(
      'user_photos',
      where: 'user_id = ? AND place_id = ?',
      whereArgs: [userId, placeId],
      orderBy: 'created_at DESC',
    );
    return list.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Future<Map<String, dynamic>> getStats(int? userId) async {
    if (userId == null) return {'visits': 0, 'trips': 0, 'badges': 0};
    final stamps = await getStamps(userId);
    final trips = await getTrips(userId);
    final badges = await getBadges(userId);
    return {'visits': stamps.length, 'trips': trips.length, 'badges': badges.length};
  }
}
