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
}