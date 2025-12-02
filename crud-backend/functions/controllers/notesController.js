const notesService = require('../services/notesService');

exports.getAllNotes = async (req, res) => {
    try {
        const notes = await notesService.getAllNotes();
        res.json(notes);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.getNoteById = async (req, res) => {
    try {
        const note = await notesService.getNoteById(req.params.id, req.body);
        if(!note) return res.status(404).json({erorr: "Note not found!"});
        res.json(note);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.createNote = async (req, res) => {
    try {
        const newNote = await notesService.createNote(req.body);
        res.status(201).json(newNote);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.updateNote = async (req, res) => {
    try {
        const updated = await notesService.updateNote(req.params.id, req.body);
        res.json(updated);

    } catch (error) {
        res.status(500).json({ error: error.message });      
    }
};

exports.deleteNote = async (req, res) => {
    try {
        await notesService.deleteNote(req.params.id);
        res.json({ success: true });

    } catch (error) {
        res.status(500).json({ error:error.message });      
    }
};