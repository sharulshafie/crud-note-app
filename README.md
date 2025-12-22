# 📝 CRUD Note App (Flutter + Firebase)

A full-stack CRUD (Create, Read, Update, Delete) note-taking application built with **Flutter** for the frontend and **Firebase Cloud Functions + Firestore** for the backend.

This project was built **end-to-end** to for me deeply understand:
- backend API design
- frontend–backend integration
- async state management
- proper application architecture (MVCS)

---

## 🚀 Features

- 📄 View all notes
- ➕ Create new notes
- 🔍 View note details
- ✏️ Edit existing notes
- 🗑️ Delete notes (with confirmation)
- 🔄 Real-time UI updates via state management

---

## 🧱 Tech Stack

### 📱 Frontend
- **Flutter** – Cross-platform mobile framework
- **Dart** – Programming language
- **Provider** – State management
- **MVCS architecture**
  - Model → `Note`
  - View → Flutter screens
  - Controller → `NotesController`
  - Service → `ApiService`

---

### 🌐 Backend
- **JavaScript** (Node.js runtime)
- **Express.js** – REST API framework
- **Firebase Cloud Functions** – Serverless backend
- **Firebase Firestore** – NoSQL database

---

### 🧪 Development & Tooling
- Firebase Emulator Suite
- Flutter SDK
- Android SDK
- VS Code
- Git & GitHub

---

## 🧠 Architecture Overview
Flutter UI
↓
NotesController (Provider / ChangeNotifier)
↓
ApiService (HTTP requests)
↓
Express.js (Firebase Cloud Function)
↓
Firestore

---

### Key Principles
- UI does **not** talk to the backend directly
- UI is reactive and “dumb”
- Controllers manage state and refresh logic
- Single source of truth for notes
- No `FutureBuilder`-driven state in screens

---

## 📂 Project Structure (Frontend)
lib/
├── controllers/
│ └── notes_controller.dart
├── models/
│ └── note.dart
├── services/
│ └── api_service.dart
├── screens/
│ ├── home_screen.dart
│ ├── note_detail_screen.dart
│ ├── create_note_screen.dart
│ └── edit_note_screen.dart
└── main.dart

---

## 🔧 Backend Structure
functions/
├── index.js
├── app.js
├── routes/
│ └── notes.js
├── controllers/
│ └── notesController.js
├── services/
│ └── notesService.js


---

## 🧩 Application Phases

### Phase 1–4: Backend
- Firebase project setup
- Express API
- Firestore integration
- Cloud Functions deployment

### Phase 5–6: Flutter CRUD
- List, create, read, update, delete notes
- Full frontend–backend integration

### Phase 7: Architecture Refactor (Key Learning)
- Introduced Provider
- Centralized state with `NotesController`
- Removed `FutureBuilder` from UI
- Eliminated UI → ApiService coupling
- Fully reactive UI

---

## 🧪 State Management Flow

- All create / update / delete actions go through `NotesController`
- Controller calls backend and refetches notes
- `notifyListeners()` updates all screens automatically
- No manual refresh or navigation hacks

---

## 📌 Future Improvements

- Firebase Authentication
- Firestore security rules
- Offline caching
- Search & filtering
- UI/UX polish
- Migration to TypeScript (backend)
- Advanced state management (Riverpod)
