import 'package:dictionary/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  /// Splash oynasi ekranni 3 sekund davomida ushlab turish uchun
  /// await Future.delayed(const Duration(seconds: 3));
  /// dan foydalinish mumkin. Lekin pastda foydalinilgan usul orqali
  /// foydalanuvchining ortiqcha vaqtini olishdan saqlanish mumkin
  /// agar app 3 sekund dan oldin tayyor bo'lsa
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}
