import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/api_service.dart';

class NoteDetailScreen extends StatelessWidget {
    final String noteId;

    const NoteDetailScreen({super.key, required this.noteId});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text("Note Detail")),
            body: FutureBuilder<Note>(
                future: ApiService.fetchNoteById(noteId),
                builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator()
                        );
                    }

                    if (snapshot.hasError) {
                        return Center(
                            child: Text("Error: ${snapshot.error}")
                        );
                    }
                    
                    final note = snapshot.data!;
                    
                    return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                    note.title,
                                    style: Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(height: 12),
                                Text(note.content),
                            ],
                        ),
                    );
                },
            ),
        );
    }
}