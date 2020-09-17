import 'package:flutter/material.dart';
import 'package:synword/Widgets/body.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'synword',
          style: TextStyle(fontFamily: 'Waxe', fontSize: 30),
        ),
        centerTitle: true,
        leading: IconButton(
          tooltip: 'Menu',
          icon: Icon(Icons.menu, color: Colors.red),
          onPressed: null,
        ),
        actions: [
          IconButton(
            tooltip: 'Insert file',
            icon: Icon(Icons.insert_drive_file, color: Colors.red),
            onPressed: null,
          )
        ],
        backgroundColor: Colors.black,
      ),
      body: Body(),
      backgroundColor: Colors.black,
    );
  }
}