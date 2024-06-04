import 'package:hive/hive.dart';

class AppStorage {
  Map<String, Box> boxes = {};
  Future init(dynamic tableNames) async {
    String? path;
    // if(!kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux)) {
    //   path = (await getApplicationSupportDirectory()).path;
    // }
    if (tableNames is String) {
      boxes[tableNames] = await Hive.openBox(tableNames, path: path);
    } else {
      for (var i = 0; i < tableNames.length; i++) {
        boxes[tableNames[i]] = await Hive.openBox(tableNames[i], path: path);
      }
    }
  }

  Box? getBox(String boxName) {
    if (boxes.containsKey(boxName)) {
      return boxes[boxName];
    }
    return null;
  }

  bool containsKey(String tableName, dynamic key) {
    return getBox(tableName)!.containsKey(key);
  }



  Future put(String tableName, String id, dynamic data) async {
    return await getBox(tableName)?.put(id, data);
  }

  Future putAll(String tableName, Map entries) async {
    return await getBox(tableName)!.putAll(entries);
  }

  Future push(String tableName, dynamic data) async {
    return await getBox(tableName)!.add(data);
  }

  Future pushAll(String tableName, Iterable<dynamic> entries) async {
    return await getBox(tableName)!.addAll(entries);
  }

  dynamic getAt(String tableName, int index) {
    return getBox(tableName)?.getAt(index);
  }

  dynamic get(String tableName, dynamic key) {
    return getBox(tableName)?.get(key);
  }

  Future delete(String tableName, String id) async {
    return await getBox(tableName)?.delete(id);
  }

  Stream<BoxEvent>? watch(String tableName, String id){
    return getBox(tableName)?.watch(key: id);
  }

  Future deleteAtIndex(String tableName, int index) async {
    return await getBox(tableName)?.deleteAt(index);
  }

  Future clear(String tableName) async {
    return await getBox(tableName)?.clear();
  }

  // ValueListenable<Box> listenable(tableName) {
  //   return getBox(tableName)!.listenable();
  // }
  //
  // List getValues(tableName){
  //   return getBox(tableName)!.listenable().value.values.toList();
  // }
  //
  // List getKeys(tableName){
  //   return getBox(tableName)!.listenable().value.keys.toList();
  // }

  bool isNotEmpty(tableName) {
    if(getBox(tableName) != null) {
      return getBox(tableName)!.isNotEmpty;
    }
    return false;
  }

  bool isEmpty(tableName) {
    if(getBox(tableName) != null) {
      return getBox(tableName)!.isEmpty;
    }
    return true;
  }

  bool isOpen(tableName) {
    if(getBox(tableName) != null) {
      return getBox(tableName)!.isOpen;
    }
    return false;
  }
}

class Setting {
  String tableName;
  static late AppStorage appStorage;
  Setting([this.tableName = 'Config']);
  static Future init(dynamic tableNames) async {
    return appStorage.init(tableNames);
  }

  bool containsKey(dynamic key) {
    return appStorage.containsKey(tableName, key);
  }

  Future put(String id, dynamic data) async {
    return appStorage.put(tableName, id, data);
  }

  Future putAll(String tableName, Map entries) async {
    return appStorage.putAll(tableName, entries);
  }

  Future push(dynamic data) async {
    return appStorage.push(tableName, data);
  }

  Future pushAll(String tableName, Iterable<dynamic> entries) async {
    return appStorage.pushAll(tableName, entries);
  }

  dynamic getAt(int index) {
    return appStorage.getAt(tableName, index);
  }

  // List getKeys() {
  //   return appStorage.getKeys(tableName);
  // }

  // List getValues() {
  //   return appStorage.getValues(tableName);
  // }

  dynamic get(dynamic key) {
    return appStorage.get(tableName, key);
  }

  Future delete(String id) async {
    return appStorage.delete(tableName, id);
  }

  Future deleteAtIndex(int index) async {
    return appStorage.deleteAtIndex(tableName, index);
  }

  Stream<BoxEvent>? watch(String id){
    return appStorage.watch(tableName, id);
  }

  Future clear() async {
    return appStorage.clear(tableName);
  }

  dynamic operator [](String key) {
    return appStorage.get(tableName, key);
  }

  // ValueListenable<Box> listenable() {
  //   return appStorage.listenable(tableName);
  // }

  bool get isNotEmpty => appStorage.isNotEmpty(tableName);
  bool get isEmpty => appStorage.isEmpty(tableName);
  bool get isOpen => appStorage.isOpen(tableName);
}
