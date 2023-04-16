import 'package:dictionary/app/navigation/app_route_factory.dart';
import 'package:dictionary/domain/bloc/dictionary_bloc.dart';
import 'package:dictionary/domain/bloc/online_dictionary_bloc.dart';
import 'package:dictionary/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DictionaryBloc>(
          create: (_) => DictionaryBloc(),
        ),
        BlocProvider<OnlineDictionaryBloc>(
          create: (_) => OnlineDictionaryBloc(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Dictionary',
        routerConfig: appRouter,
        theme: DictionaryTheme.theme(),
      ),
    );
  }
}
