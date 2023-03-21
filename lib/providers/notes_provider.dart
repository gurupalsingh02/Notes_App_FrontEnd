import 'package:flutter/widgets.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/services/api_services.dart';

class NotesProvider with ChangeNotifier {
  List<Note> notes = [];
  NotesProvider(BuildContext context) {
    getNotes('gurupalsingh83', context);
  }
  void sortNotes() {
    notes.sort((a, b) => a.dateAdded.compareTo(b.dateAdded));
  }

  void addNote(Note note, BuildContext context) {
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiServices.addNote(note, context);
  }

  void updateNote(Note note, BuildContext context) {
    notes.removeWhere((element) => element.id == note.id);
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiServices.updateNote(note, context);
  }

  void deleteNote(String id, BuildContext context) {
    notes.removeWhere((element) => element.id == id);
    sortNotes();
    notifyListeners();
    ApiServices.deleteNote(id, context);
  }

  Future<void> getNotes(String userId, BuildContext context) async {
    notes = await ApiServices.getNotes(userId, context);
    sortNotes();
    notifyListeners();
  }
}
