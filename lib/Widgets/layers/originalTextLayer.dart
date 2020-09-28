import 'package:flutter/material.dart';
import 'package:synword/widgets/bodyLayer.dart';
import 'package:synword/widgets/layerTextForm.dart';
import 'package:synword/widgets/layerTitle.dart';

class OriginalTextLayer extends StatelessWidget {
  final TextEditingController _textEditingController;
  final bool _isTitleVisible;

  OriginalTextLayer(
    this._textEditingController,
    this._isTitleVisible
  );

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: BodyLayer(
            Expanded(child: LayerTextForm(_textEditingController)),
            LayerTitle(
                Text('Original text', style: TextStyle(fontSize: 25, fontFamily: 'Audrey', fontWeight: FontWeight.bold, color: Colors.white)),
                Colors.red,
                Colors.black.withOpacity(0.0),
                false,
                null
            ),
            _isTitleVisible,
            false,
            null
        )
    );
  }
}
