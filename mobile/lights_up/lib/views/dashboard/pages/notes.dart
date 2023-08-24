import 'package:flutter/material.dart';
import 'dart:math';

class NotesPage extends StatelessWidget {
  List<Note> notes = [
    Note(title: "Daily Checkup", content: "Checkup the sensors"),
    Note(title: "Clean the setup", content: "Do this weekly"),
    Note(title: "Lettuce Pray", content: "Amen"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return NoteCard(note: notes[index]);
        },
      ),
    );
  }
}

class Note {
  final String title;
  final String content;

  Note({required this.title, required this.content});
}

class NoteCard extends StatelessWidget {
  final Note note;

  NoteCard({required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Adds shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Adds rounded edges
      ),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(
          note.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          note.content,
          style: TextStyle(fontSize: 14),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                // Add your check button logic here
              },
            ),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                // Add your remove button logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}
