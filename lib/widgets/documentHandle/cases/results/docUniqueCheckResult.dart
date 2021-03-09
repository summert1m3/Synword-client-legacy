import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:synword/widgets/documentHandle/documentData.dart';
import 'package:synword/widgets/uniqueCheckLinks.dart';
import 'package:synword/widgets/waveBar.dart';

class UniqueCheckResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Center(
      child: SingleChildScrollView(
        child: Column(
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
                    WaveBar(docData.uniqueCheckData.percent / 100),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 0, top: 16.0, right: 0, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  UniqueCheckLinks(
                    docData.uniqueCheckData,
                    screenSize.height - (screenSize.height / 1.3),
                    textColor: Colors.white,
                    axis: Axis.horizontal,
                    scheme: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
