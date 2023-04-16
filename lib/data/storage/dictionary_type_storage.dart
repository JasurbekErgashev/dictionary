import 'package:hive_flutter/hive_flutter.dart';

const _dictTypeKey = 'dictTypeKey';

class DictionaryTypeStorage {
  final Box _localStorage = Hive.box("app_storage");

  int? get dictTypeKey => _localStorage.get(_dictTypeKey);

  Future<void> saveDictTypeKey(int dictIndex) async {
    await _localStorage.put(_dictTypeKey, dictIndex);
  }

  void clearStorage() {
    _localStorage.clear();
  }
}
