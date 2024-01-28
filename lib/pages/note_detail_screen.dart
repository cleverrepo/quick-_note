import 'package:flutter/material.dart';

class NoteDetails extends StatelessWidget {
  const NoteDetails({super.key, this.noteTile, this.noteContent, this.noteCreatioDate});
final noteTile;
final noteContent;
final noteCreatioDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:   Text(noteTile),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center ,
          children: [

            Text(noteContent),
            Text(noteCreatioDate),
          ],
        ),
      ),
    );
  }
}
