import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/notes_controller.dart';
import 'screens/home_screen.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      // set NotesController globally --> fetchNotes() run automatically
      create: (_) => NotesController()..fetchNotes(), 
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}