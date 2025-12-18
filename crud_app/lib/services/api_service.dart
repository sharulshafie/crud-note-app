import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/note.dart';

class ApiService {
    static const String baseUrl = "https://api-zhvfb6fciq-uc.a.run.app";

    static Future<List<Note>> fetchAllNotes() async {
        final response = await http.get(Uri.parse("$baseUrl/notes"));

        if (response.statusCode == 200) {
            final List data = json.decode(response.body);
            return data.map((item) => Note.fromJson(item)).toList();
        } else {
            throw Exception("Failed to FETCH ALL notes");
        }
    }

    static Future<void> createNote(String title, String content) async {
        final response = await http.post(
            Uri.parse("$baseUrl/notes"),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
                "title": title,
                "content": content,
            }),
        );

        if (response.statusCode != 201) {
            throw Exception("Failed to CREATE note!");
        }
    }

    static Future<Note> fetchNoteById(String Id) async {
        final response = await http.get(
            Uri.parse("$baseUrl/notes/$Id"),
        );

        if (response.statusCode == 200) {
            return Note.fromJson(json.decode(response.body));
        } else {
            throw Exception("Failed to FETCH note");
        }
    }

    static Future<void> updateNote(
        String id,
        String title, 
        String content
    ) async {
        final response = await http.put(
            Uri.parse("$baseUrl/notes/$id"),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
                "title": title,
                "content": content,
            }),
        );

        if (response.statusCode != 200) {
            throw Exception("Failed to UPDATE note!");
        }
    }

    static Future<void> deleteNote(String Id) async {
        final response = await http.delete(
            Uri.parse("$baseUrl/notes/$Id"),
        );

        if (response.statusCode != 200) {
            throw Exception("Failed to DELETE note");
        }
    }
}