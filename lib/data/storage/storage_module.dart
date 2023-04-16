import 'package:hive_flutter/hive_flutter.dart';

class StorageModule {
  Future<Box> createHive() async {
    return await Hive.openBox('app_storage');
  }
}
