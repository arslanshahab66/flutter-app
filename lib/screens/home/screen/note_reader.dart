import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_prefernces/screens/home/screen/note_editor.dart';
import 'package:shared_prefernces/style/app_style.dart';

class NoteReaderScreen extends StatefulWidget {
  const NoteReaderScreen({required this.doc, super.key});
  final QueryDocumentSnapshot doc;

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.doc['note_title'],
                  style: AppStyle.mainTitle,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.doc['creation_date'],
                  style: AppStyle.dateTitle,
                ),
                const SizedBox(height: 28),
                Text(
                  widget.doc['note_content'],
                  style: AppStyle.mainContent,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
