import 'package:flutter/material.dart';
import 'package:synword/widgets/documentHandle/documentHandlerData.dart';
import '../../../uniqueCheckLinks.dart';
import '../../../waveBar.dart';

class DocUniqueCheckResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: WaveBar(DocumentHandlerData.uniqueCheckData.percent / 100),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: UniqueCheckLinks(
                DocumentHandlerData.uniqueCheckData,
                screenSize.height - (screenSize.height / 1.8),
                textColor: Colors.black,
                scheme: false,
              ),
            ),
          ],
        );
  }
}
