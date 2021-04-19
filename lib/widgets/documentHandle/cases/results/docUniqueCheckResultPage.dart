import 'package:flutter/material.dart';
import 'package:synword/widgets/documentHandle/documentHandlerData.dart';
import '../../../uniqueCheckLinks.dart';
import '../../../waveBar.dart';
import 'package:provider/provider.dart';

class DocUniqueCheckResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    var docData = context.read<DocumentHandlerData>();
    return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: WaveBar(docData.uniqueCheckData.percent / 100),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: UniqueCheckLinks(
                docData.uniqueCheckData,
                screenSize.height - (screenSize.height / 1.8),
                textColor: Colors.black,
                scheme: false,
              ),
            ),
          ],
        );
  }
}
