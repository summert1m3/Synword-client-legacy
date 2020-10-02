import 'package:flutter/material.dart';
import 'package:synword/widgets/layers/buttonBarWidget.dart';
import 'layer.dart';
import 'types.dart';


class ButtonBarLayer extends Layer {
  bool _isFirstButtonVisible;
  bool _isSecondButtonVisible;
  FloatingActionButtonCallback _firstButtonCallback;
  FloatingActionButtonCallback _secondButtonCallback;
  Widget _widget;

  ButtonBarLayer.zero() {
    _isFirstButtonVisible = true;
    _isSecondButtonVisible = true;
    _firstButtonCallback = null;
    _secondButtonCallback = null;
    build();
  }

  ButtonBarLayer(this._isFirstButtonVisible, this._isSecondButtonVisible, this._firstButtonCallback, this._secondButtonCallback) {
    build();
  }

  void build() {
    _widget = ButtonBarWidget(
        _isFirstButtonVisible,
        _isSecondButtonVisible,
        _firstButtonCallback,
        _secondButtonCallback
    );
  }

  void setFirstButtonVisible(bool value) {
    _isFirstButtonVisible = value;
    build();
  }

  void setSecondButtonVisible(bool value) {
    _isSecondButtonVisible = value;
    build();
  }

  void setFirstButtonCallback(FloatingActionButtonCallback value) {
    _firstButtonCallback = value;
    build();
  }

  void setSecondButtonCallback(FloatingActionButtonCallback value) {
    _secondButtonCallback = value;
    build();
  }

  bool getFirstButtonVisible() {
    return _isFirstButtonVisible;
  }

  bool getSecondButtonVisible() {
    return _isSecondButtonVisible;
  }

  Widget getWidget() {
    return _widget;
  }
}
