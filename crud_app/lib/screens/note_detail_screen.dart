import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../services/api_service.dart';
import '../screens/edit_note_screen.dart';
import '../screens/home_screen.dart';
import '../controllers/notes_controller.dart';

class NoteDetailScreen extends StatelessWidget {
    final String noteId;

    const NoteDetailScreen({super.key, required this.noteId});

    // @override
    // Widget build(BuildContext context) {
    //     return FutureBuilder<Note>(
    //         future: ApiService.fetchNoteById(noteId),
    //         builder: (context, snapshot) {
    //             if (snapshot.connectionState == ConnectionState.waiting) {
    //                 return const Center(
    //                     child: CircularProgressIndicator()
    //                 );
    //             }

    //             if (snapshot.hasError) {
    //                 return Center(
    //                     child: Text("Error: ${snapshot.error}")
    //                 );
    //             }

    //             final note = snapshot.data!;

    //             return Scaffold(
    //                 appBar: AppBar(title: const Text("Note Detail")),
    //                 body: Padding(
    //                     padding: const EdgeInsets.all(16),
    //                     child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                             Text(
    //                                 note.title,
    //                                 style: Theme.of(context).textTheme.headlineSmall,
    //                             ),
    //                             const SizedBox(height: 12),
    //                             Text(note.content),
    //                         ],
    //                     ),
    //                 ), 

    //                 // floatingActionButton: FloatingActionButton.extended(
    //                 //     icon: const Icon(Icons.edit),
    //                 //     label : const Text('Edit'),
    //                 //     onPressed: () async {
    //                 //         final updated = await Navigator.push(
    //                 //             context,
    //                 //             MaterialPageRoute(
    //                 //                 builder: (_) => EditNoteScreen(note: note),
    //                 //             ),
    //                 //         );

    //                 //         if (updated == true) {
    //                 //             // re-fetch detail after edit
    //                 //             Navigator.pop(context);
    //                 //         }
    //                 //     },
    //                 // ),

    //                 floatingActionButton : Padding(
    //                     // padding: const EdgeInsets.all(16),
    //                     padding: const EdgeInsets.only(left: 30),
    //                     child: Row(
    //                         // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                         crossAxisAlignment: CrossAxisAlignment.end,
    //                         children: [
    //                             FloatingActionButton.extended(
    //                                 heroTag: "deleteButton",
    //                                 icon: const Icon(Icons.delete),
    //                                 foregroundColor: Colors.white,
    //                                 backgroundColor: Colors.red,
    //                                 label : const Text('Delete'),
    //                                 onPressed: () async {
    //                                     final confirmed = await showDialog<bool>(
    //                                         context: context,
    //                                         builder: (_) => AlertDialog(
    //                                             title: const Text("Delete Note"),
    //                                             content: const Text("Kau confirm ke nak delete bro?"),
    //                                             actions: [
    //                                                 TextButton(
    //                                                     onPressed: () => Navigator.pop(context, true),
    //                                                     child: const Text("Yes"),
    //                                                 ),
    //                                                 TextButton(
    //                                                     onPressed: () => Navigator.pop(context, false),
    //                                                     child: const Text("No"),
    //                                                 ),
    //                                             ],
    //                                         ),
    //                                     );

    //                                     if (confirmed == true) {
    //                                         // await ApiService.deleteNote(note.id);

    //                                         await context.read<NotesController>().deleteNote(note.id);

    //                                         // re-fetch detail after edit
    //                                         Navigator.pop(context);
    //                                     }
    //                                 },
    //                             ),

    //                             Expanded(child: Container()),

    //                             FloatingActionButton.extended(
    //                                 heroTag: "editButton",
    //                                 icon: const Icon(Icons.edit),
    //                                 label : const Text('Edit'),
    //                                 onPressed: () async {
    //                                     final updated = await Navigator.push(
    //                                         context,
    //                                         MaterialPageRoute(
    //                                             builder: (_) => EditNoteScreen(note: note),
    //                                         ),
    //                                     );

    //                                     if (updated == true) {
    //                                         // re-fetch detail after edit
    //                                         Navigator.pop(context);
    //                                     }
    //                                 },
    //                             )
    //                         ],
    //                     ), 
    //                 ),
    //             );
    //         },
    //     );
    // }

    @override
    Widget build(BuildContext, context) {
        final controller = context.watch<NotesController>();

        // firtsWhere method --> to find first element in Iterable that satisfies a given condition
        final note = controller.notes.firstWhere(
            (n) => n.id == noteId, // this return the first match
            orElse: () => throw Exception("Note not found"),
        );

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

            // --- FAB ---
            floatingActionButton: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                        // --- DELETE BUTTON ---
                        FloatingActionButton.extended(
                            heroTag: "deleteButton",
                            icon: const Icon(Icons.delete),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red,
                            label: const Text('Delete')
                            onPressed: () async {
                                final confirmed = await showDialog<bool>(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                        title: const Text("Delete Note"),
                                        content: const Text("Are you sure you want to delete?"),
                                        action: [
                                            // --- Yes Button ---
                                            TextButton(
                                                child: const Text("Yes"),
                                                onPressed: () => Navigator.pop(context, true),
                                            ),

                                            // --- No Button ---
                                            TextButton(
                                                child: const Text("No"),
                                                onPressed: () => Navigator.pop(context, false),
                                            ),
                                        ],
                                    ),
                                );

                                if (confirmed == true) {
                                    await context.read<NotesController>().deleteNote(note.id);
                                    Navigator.pop(context);
                                }
                            }
                        ),

                        // --- SPACEHOLDER ---
                        Expanded(child: Container()),

                        // --- EDIT BUTTON ---
                        FloatingActionButton.extended(
                            heroTag: "editButton",
                            icon: const Icon(Icons.edit),
                            label: const Text('Edit')
                            onPressed: () async {
                                final updated = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => EditNoteScreen(note: note),
                                    ),
                                );

                                if (updated == true) {
                                    Navigator.pop(context);
                                }
                            }
                        ),
                    ],
                ),
            ),
        );
    }
}