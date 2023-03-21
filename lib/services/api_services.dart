import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:http/http.dart' as http;
import 'package:notes_app/show_snak_bar.dart';

class ApiServices {
  static String baseUrl = 'https://notes-app-backend-6ffa.onrender.com/notes';
  static void addNote(Note note, BuildContext context) async {
    try {
      Uri requestUri = Uri.parse('$baseUrl/add');
      await http.post(requestUri, body: note.toMap());
    } catch (e) {
      showSnakBar(context, e.toString());
    }
  }

  static Future<List<Note>> getNotes(
      String userId, BuildContext context) async {
    Uri requestUri = Uri.parse('$baseUrl/list');
    var responce = await http.post(requestUri, body: {'userId': userId});
    var decoded = jsonDecode(responce.body);
    List<Note> notes = [];
    for (var doc in decoded) {
      var note = Note.fromMap(doc);
      notes.add(note);
    }
    return notes;
  }

  static void updateNote(Note note, BuildContext context) async {
    try {
      Uri requestUri = Uri.parse('$baseUrl/update');
      await http.post(requestUri, body: note.toMap());
    } catch (e) {
      showSnakBar(context, e.toString());
    }
  }

  static void deleteNote(String id, BuildContext context) async {
    try {
      Uri requestUri = Uri.parse('$baseUrl/delete');
      await http.post(requestUri, body: {'id': id});
    } catch (e) {
      showSnakBar(context, e.toString());
    }
  }
}
