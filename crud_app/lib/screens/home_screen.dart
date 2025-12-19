import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../services/api_service.dart';
import '../screens/create_notes_screen.dart';
import '../screens/note_detail_screen.dart';
import '../controllers/notes_controller.dart';

class HomeScreen extends StatelessWidget {
    const HomeScreen({super.key});

//     @override
//     State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
    
    // late Future<List<Note>> notesFuture;

    // @override
    // void initState() {
    //     super.initState();
    //     notesFuture = ApiService.fetchAllNotes();
    // }

    // @override
    // Widget build(BuildContext context) {
    //     return Scaffold(
    //         appBar: AppBar(title: const Text('Notes')),
    //         body: FutureBuilder<List<Note>>(
    //             future: notesFuture,
    //             builder: (context, snapshot) {
    //                 if (snapshot.connectionState == ConnectionState.waiting) {
    //                     return const Center(child: CircularProgressIndicator());
    //                 }

    //                 if (snapshot.hasError) {
    //                     return Center(child: Text("Error: ${snapshot.error}"));
    //                 }

    //                 final notes = snapshot.data ?? [];

    //                 if (notes.isEmpty) {
    //                     return const Center(child: Text("No notes yet"));
    //                 }

    //                 return ListView.builder(
    //                     itemCount: notes.length,
    //                     itemBuilder: (context, index) {
    //                         final note = notes[index];
    //                         return ListTile(
    //                             title: Text(note.title),
    //                             subtitle: Text(note.content),
    //                             onTap: () {
    //                                 Navigator.push(
    //                                     context,
    //                                     MaterialPageRoute(
    //                                         builder: (_) => NoteDetailScreen(noteId: note.id),
    //                                     ),
    //                                 );
    //                             },
    //                         );
    //                     },
    //                 );
    //             },
    //         ),
    //         floatingActionButton: FloatingActionButton.extended(
    //             icon: const Icon(Icons.add),
    //             label: const Text('Add'),
    //             onPressed: () async {
    //                 await Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (_) => const CreateNoteScreen(),
    //                     ),
    //                 );

    //                 // refresh list AFTER returning
    //                 setState(() {
    //                     notesFuture = ApiService.fetchAllNotes();
    //                 });
    //             },
    //         ),
    //     );
    // }

    @override
    Widget build(BuildContext context) {
        final controller = context.watch<NotesController>();

        return Scaffold(
            appBar: Appbar(title: const Text('Notes')),
            
            // --- BODY ---
            body: controller.isLoading
                // loading state
                ? const Center(child: CircularProgressIndicator())
                // error state
                : controller.error != null          
                    ? Center(child: Text(controller.error!))
                    // empty state
                    : controller.notes.isEmpty                      
                        ? const Center(child: Text('No notes yet'))
                        // list state
                        : ListView.builder(
                            itemCount: controller.notes.length,
                            itemBuilder: (context. index) {
                                final note = controller.notes[index];

                                return ListTile(
                                    title: Text(note.title),
                                    subtitle: Text(note.content),
                                    onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => NoteDetailScreen(noteId: note.id),
                                            ),
                                        );
                                    },
                                );
                            },

                        ),
            
            // --- FAB ---
            floatingActionButton: FloatingActionButton.extended(
                icon: const Icon(Icons.add),
                label: const Text('Add'),
                onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CreateNoteScreen();
                        ),
                    );
                },
            ),
        );
    }
}