import 'package:flutter/material.dart';
import 'package:synword/Widgets/bodyLayer.dart';
import 'package:synword/Widgets/layerTextForm.dart';
import 'package:synword/Widgets/layerTitle.dart';

class OriginalTextLayer extends StatelessWidget {
  final TextEditingController _textEditingController;

  OriginalTextLayer(this._textEditingController);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: BodyLayer(
            Expanded(child: LayerTextForm(_textEditingController)),
            LayerTitle(
                Text('Original text', style: TextStyle(fontSize: 25, fontFamily: 'Audrey', fontWeight: FontWeight.bold, color: Colors.white)),
                Colors.red,
                true,
                false,
                false,
                null,
                null
            )
        )
    );
  }
}
