import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sketchy_sounds_intern_app/api_menu.dart';
import 'api_service.dart';
import 'main_view.dart';

// void main() => runApp(const MyApp());

Future<void> main() async {
  runApp(const MyApp());

  // Load settings
  final prefs = await SharedPreferences.getInstance();

  String? apiLink = await prefs.getString('apiLink');
  if (apiLink != null) {
    // Force unwrapping should be safe here
    APIService.apiUrl = apiLink!;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'SketchySounds';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: const MainView(),
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        fontFamily: 'Compagnon',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: Colors.black),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      routes: {
        '/api_menu': (context) => const ApiMenu(),
      },
    );
  }
}

