import 'package:flutter/material.dart';
import 'package:synword/widgets/waveBar.dart';
import 'package:synword/widgets/uniqueCheckLinks.dart';

class TextUniqueCheck extends StatelessWidget {
  final double _progress;

  TextUniqueCheck(
    this._progress
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          WaveBar(
              _progress
          ),
          Divider(
            color: Colors.grey,
            height: 30,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          UniqueCheckLinks()
        ],
      ),
    );
  }
}
