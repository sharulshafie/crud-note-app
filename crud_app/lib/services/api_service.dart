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
            throw Exception("Failed to load notes");
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
            throw Exception("Failed to create note!");
        }
    }
}