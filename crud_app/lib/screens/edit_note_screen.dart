import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../controllers/notes_controller.dart';
// import '../services/api_service.dart';


class EditNoteScreen extends StatefulWidget {
    final Note note;

    const EditNoteScreen({super.key, required this.note});

    @override
    State<EditNoteScreen> createState() => _EditNotesScreenState();
}

class _EditNotesScreenState extends State<EditNoteScreen> {
    late TextEditingController titleController;
    late TextEditingController contentController;
    bool isSaving = false;

    @override
    void initState() {
        super.initState();
        titleController = TextEditingController(text: widget.note.title);
        contentController = TextEditingController(text: widget.note.content);
    }

    Future<void> saveChanges() async {
        setState(() => isSaving = true);

        try {
            // await ApiService.updateNote(
            //     widget.note.id,
            //     titleController.text,
            //     contentController.text
            // );

            await context.read<NotesController>().updateNote(
                widget.note.id,
                titleController.text,
                contentController.text
            );

            Navigator.pop(context, true); // indicate success
        } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error: $e")),
            );
        } finally {
            setState(() => isSaving = false);
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text("Edit Note")),
            body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    children: [
                        TextField(
                            controller: titleController, 
                            decoration: const InputDecoration(labelText: "Title"),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                            controller: contentController,
                            decoration: const InputDecoration(labelText: "Content"),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                            onPressed: isSaving ? null : saveChanges,
                            child: isSaving
                                ? const CircularProgressIndicator()
                                : const Text("Save"),
                        ),
                    ],
                ),
            ),
        );
    }
}