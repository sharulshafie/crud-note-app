const admin = require('firebase-admin');

if (!admin.apps.length) {
    admin.initializeApp();
}

const db = admin.firestore();
const notesCollection = db.collection('notes');

exports.getAllNotes = async () => {
    const snapshot = await notesCollection.get();
    const notes = snapshot.docs.map(doc => ({
        id: doc.id,
        ...doc.data(),
    }));
    return notes;
};

exports.getNoteById = async (id) => {
    const doc = await notesCollection.doc(id).get();
    if (!doc.exists) return null;
    return { id: doc.id, ...doc.data() };
};

exports.createNote = async (data) => {
    const note = {
        title: data.title,
        content: data.content,
        createdAt: new Date()
    };

    const docRef = await notesCollection.add(note);
    const newDoc = await docRef.get();
    return { id: docRef.id, ...newDoc.data() };
};

exports.updateNote = async (id, data) => {
    await notesCollection.doc(id).update(data);
    const updateDoc = await notesCollection.doc(id).get();
    return { id, ...updateDoc.data() };
};

exports.deleteNote = async (id) => {
    await notesCollection.doc(id).delete();
    return { success: true };
};