import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/providers/notes_provider.dart';
import 'package:notes_app/pages/home_page.dart';
import 'package:notes_app/show_snak_bar.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewNotePage extends StatefulWidget {
  final String id;
  final bool update;
  final String title;
  final String content;
  const AddNewNotePage(
      {required this.title,
      required this.content,
      super.key,
      required this.update,
      required this.id});

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  FocusNode focusNode = FocusNode();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  void addNewNote() {
    try {
      String id = const Uuid().v1();
      final note = Note(
          dateAdded: DateTime.now(),
          id: id,
          userId: 'gurupalsingh83',
          title: titleController.text,
          content: contentController.text);
      Provider.of<NotesProvider>(context, listen: false).addNote(note, context);
      Navigator.pop(
        context,
        CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (context) {
              return const HomePage();
            }),
      );
    } catch (e) {
      showSnakBar(context, e.toString());
    }
  }

  void updateNote() {
    try {
      final note = Note(
          dateAdded: DateTime.now(),
          id: widget.id,
          userId: 'gurupalsingh83',
          title: titleController.text.trimLeft().trimRight(),
          content: contentController.text.trimLeft().trimRight());
      Provider.of<NotesProvider>(context, listen: false)
          .updateNote(note, context);
      Navigator.pop(
        context,
        CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (context) {
              return const HomePage();
            }),
      );
    } catch (e) {
      showSnakBar(context, e.toString());
    }
  }

  void deleteNote() {
    try {
      Provider.of<NotesProvider>(context, listen: false)
          .deleteNote(widget.id, context);
      Navigator.pop(
        context,
        CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (context) {
              return const HomePage();
            }),
      );
    } catch (e) {
      showSnakBar(context, e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.update) {
      titleController.text = widget.title;
      contentController.text = widget.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [
          if (widget.update)
            IconButton(
                onPressed: () {
                  deleteNote();
                },
                icon: const Icon(Icons.delete)),
          IconButton(
              onPressed: () {
                widget.update ? updateNote() : addNewNote();
              },
              icon: const Icon(Icons.check))
        ],
        title: Text(widget.update ? 'update Note' : 'Add a new Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
                controller: titleController,
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    focusNode.requestFocus();
                  }
                },
                autofocus: true,
                style: const TextStyle(fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'enter a title',
                    label: Text('title'))),
            TextField(
                controller: contentController,
                focusNode: focusNode,
                autofocus: true,
                maxLines: null,
                decoration: const InputDecoration(
                    hintText: 'enter a note',
                    label: Text('Note'),
                    border: InputBorder.none)),
          ],
        ),
      ),
    ));
  }
}
