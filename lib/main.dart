import 'package:dictionary/app/app.dart';
import 'package:dictionary/data/storage/storage_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  await Hive.initFlutter();
  await StorageModule().createHive();
  runApp(const MyApp());
}
