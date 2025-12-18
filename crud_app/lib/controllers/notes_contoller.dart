import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/api_service.dart';

class NoteController extends ChangeNotifier {
    List<Note> _notes = [];
}