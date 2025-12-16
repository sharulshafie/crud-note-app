import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/api_service.dart';
import '../screens/edit_note_screen.dart';
import '../screens/home_screen.dart';

class NoteDetailScreen extends StatelessWidget {
    final String noteId;

    const NoteDetailScreen({super.key, required this.noteId});

    @override
    Widget build(BuildContext context) {
        return FutureBuilder<Note>(
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

                return Scaffold(
                    appBar: AppBar(title: const Text("Note Detail")),
                    body: Padding(
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
                    ), 

                    floatingActionButton: FloatingActionButton.extended(
                        icon: const Icon(Icons.edit),
                        label : const Text('Edit'),
                        onPressed: () async {
                            final updated = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => EditNoteScreen(note: note),
                                ),
                            );

                            if (updated == true) {
                                // re-fetch detail after edit
                                Navigator.pop(context);
                            }
                        },
                    ),
                );
            },
        );
    }
}