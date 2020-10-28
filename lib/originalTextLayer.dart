import 'package:flutter/material.dart';
import 'package:synword/widgets/layers/originalTextWidget.dart';
import 'layer.dart';

class OriginalTextLayer extends Layer {
  TextEditingController _textEditingController;
  bool _isTitleVisible;

  OriginalTextLayer.zero() {
    _textEditingController = null;
    _isTitleVisible = false;
    build();
  }

  OriginalTextLayer(this._textEditingController, this._isTitleVisible) {
    build();
  }

  void build() {
    setWidget(OriginalTextWidget(
        _textEditingController,
        _isTitleVisible
    ));
  }

  void setTextEditingController(TextEditingController value) {
    _textEditingController = value;
    build();
  }

  void setTitleVisible(bool value) {
    _isTitleVisible = value;
    build();
  }
}
