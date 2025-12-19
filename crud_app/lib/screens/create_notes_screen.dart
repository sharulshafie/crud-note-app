import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../services/api_service.dart';
import '../controllers/notes_controller.dart';

class CreateNoteScreen extends StatefulWidget {
    const CreateNoteScreen({super.key});

    @override
    State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    bool isSaving = false;

    Future<void> saveNote() async {
        if (titleController.text.isEmpty || contentController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Title and content required")),
            );
            return;
        }

        setState(() => isSaving = true);

        try {
            // await ApiService.createNote(
            //     titleController.text,
            //     contentController.text
            // );

            await context.read<NotesController>().createNote(
                titleController.text,
                contentController.text
            );

            Navigator.pop(context); // back to list
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
            appBar: AppBar(title: const Text("Create Note")),
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
                            maxLines: 2,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                            onPressed: isSaving ? null : saveNote,
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