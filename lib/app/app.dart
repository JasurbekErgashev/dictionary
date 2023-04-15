import 'package:dictionary/app/navigation/app_route_factory.dart';
import 'package:dictionary/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Dictionary',
      routerConfig: appRouter,
      theme: DictionaryTheme.theme(),
    );
  }
}
