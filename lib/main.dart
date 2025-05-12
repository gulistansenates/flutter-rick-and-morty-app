import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/app/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: Scaffold(
        appBar: AppBar(title: const Text('Material App Bar')),
        body: const Center(child: Text('Hello World')),
      ),
    );
  }
}
