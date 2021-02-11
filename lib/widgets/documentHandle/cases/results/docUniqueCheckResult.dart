import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:synword/widgets/documentHandle/documentData.dart';
import 'package:synword/widgets/uniqueCheckLinks.dart';
import 'package:synword/widgets/waveBar.dart';

class UniqueCheckResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        Card(
          color: HexColor('#505050'),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                WaveBar(docData.uniqueCheckData.percent/100),
              ],
            ),
          ),
        ),
        Card(
          color: HexColor('#5C5C5C'),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16, top: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                UniqueCheckLinks(docData.uniqueCheckData, 155),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
