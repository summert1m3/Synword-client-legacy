import 'package:flutter/material.dart';
import 'package:synword/layers/layer.dart';
import 'package:synword/widgets/layers/originalTextWidget.dart';

class OriginalTextLayer extends Layer {
  TextEditingController _textEditingController;
  bool _isTitleVisible;
  bool _isReadOnly;

  OriginalTextLayer.zero() {
    _textEditingController = null;
    _isTitleVisible = false;
    _isReadOnly = false;
    build();
  }

  OriginalTextLayer(this._textEditingController, this._isTitleVisible, this._isReadOnly) {
    build();
  }

  void build() {
    setWidget(OriginalTextWidget(
      _textEditingController,
      _isTitleVisible,
      _isReadOnly
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

  void setIsReadOnly(bool value) {
    _isReadOnly = value;
    build();
  }
}
