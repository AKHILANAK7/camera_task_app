import 'dart:io';

import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Document')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Constrain the displayed image inside a box
          Container(
            width: 300,
            height: 400,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blueAccent,
                width: 3,
              ),
            ),
            child: Image.file(
              File(imagePath),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Add document editing feature here
                },
              ),
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  // Add submission feature here
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
