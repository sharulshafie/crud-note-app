import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/api_service.dart';
import '../screens/create_notes_screen.dart';

class HomeScreen extends StatefulWidget {
    const HomeScreen({super.key});

    @override
    State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    late Future<List<Note>> notesFuture;

    @override
    void initState() {
        super.initState();
        notesFuture = ApiService.fetchAllNotes();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('Notes')),
            body: FutureBuilder<List<Note>>(
                future: notesFuture,
                builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                    }

                    final notes = snapshot.data ?? [];

                    if (notes.isEmpty) {
                        return const Center(child: Text("No notes yet"));
                    }

                    return ListView.builder(
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                            final note = notes[index];
                            return ListTile(
                                title: Text(note.title),
                                subtitle: Text(note.content),
                            );
                        },
                    );
                },
            ),
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CreateNoteScreen(),
                        ),
                    );

                    // refresh list AFTER returning
                    setState(() {
                        notesFuture = ApiService.fetchAllNotes();
                    });
                },
            ),
        );
    }
}