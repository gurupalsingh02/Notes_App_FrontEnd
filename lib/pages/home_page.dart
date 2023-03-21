import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/pages/add_new_note_page.dart';
import 'package:notes_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<NotesProvider>(context, listen: true).notes;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes App',
        ),
        centerTitle: true,
      ),
      body: ListView(children: [
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: notes.length,
          itemBuilder: (context, index) {
            Note currentNote = notes[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) {
                          return AddNewNotePage(
                              title: currentNote.title,
                              content: currentNote.content,
                              update: true,
                              id: currentNote.id);
                        }));
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentNote.title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          currentNote.content,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          DateFormat().format(currentNote.dateAdded),
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) {
                    return const AddNewNotePage(
                      id: '',
                      content: '',
                      title: '',
                      update: false,
                    );
                  }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
