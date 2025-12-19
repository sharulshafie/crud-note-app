import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/api_service.dart';

class NotesController extends ChangeNotifier {
    // public state variables
    List<Note> _notes = [];
    bool _isLoading  = false;
    String? _error;

    // public getters: prevents --> accidentally data changes, impossible-to-debug bugs
    List<Note> get notes => _notes;
    bool get isLoading => _isLoading;
    String? get error => _error;

    // function to fetch all notes
    Future<void> fetchNotes() async {
        _isLoading = true;  // marks loading state
        _error = null;      // clear previous errors
        notifyListeners();  // tells UI --> to rebuild now

        try {
            _notes = await ApiService.fetchAllNotes();
        } catch (e) {
            _error = e.toString();
        } finally {
            _isLoading = false;
            notifyListeners();
        }
    }

    // when createNote() run, fetchNotes runs after it succeeds
    Future<void> createNote(String title, String content) async {
        await ApiService.createNote(title, content);
        await fetchNotes();
    }

    Future<void> updateNote(String id, String title, String content) async {
        await ApiService.updateNote(id, title, content);
        await fetchNotes();
    }

    Future<void> deleteNote(String id) async {
        await ApiService.deleteNote(id);
        await fetchNotes();
    }
}