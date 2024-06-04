import 'package:hive/hive.dart';

class HiveConfig {
  // Constructor private
  HiveConfig._internal();

  // Phương thức static để truy cập instance
  static final HiveConfig _instance = HiveConfig._internal();
  static HiveConfig get instance => _instance;

  Future<Box<E>> openBox<E>(String boxName) async {
    try {
      if (!Hive.isBoxOpen(boxName)) {
        return await Hive.openBox<E>(boxName);
      } else {
        return Hive.box<E>(boxName);
      }
    } catch (e) {
      print('Failed to open box: $e');
      rethrow;
    }
  }

  Future<void> saveValue<E>(String boxName, String key, E value) async {
    try {
      var box = await openBox<E>(boxName);
      await box.put(key, value);
    } catch (e) {
      print('Failed to save value: $e');
      rethrow;
    }
  }

  Future<E?> getValue<E>(String boxName, String key) async {
    try {
      var box = await openBox<E>(boxName);
      return box.get(key);
    } catch (e) {
      print('Failed to get value: $e');
      rethrow;
    }
  }

  Future<void> deleteValue<E>(String boxName, String key) async {
    try {
      var box = await openBox<E>(boxName);
      await box.delete(key);
    } catch (e) {
      print('Failed to delete value: $e');
      rethrow;
    }
  }

  Future<void> closeBox<E>(String boxName) async {
    try {
      var box = await openBox<E>(boxName);
      await box.close();
    } catch (e) {
      print('Failed to close box: $e');
      rethrow;
    }
  }
}
