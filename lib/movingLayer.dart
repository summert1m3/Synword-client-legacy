import 'package:flutter/material.dart';
import 'layer.dart';
import 'types.dart';

abstract class MovingLayer extends Layer {
  Offset offset;
  Color titleColor;
  OnPanUpdateCallback onPanUpdateCallback;
  OnPanEndCallback onPanEndCallback;
  CloseButtonCallback closeButtonCallback;
  bool isTitleVisible;
  bool isCloseButtonVisible;

  void setTitleColor(Color value) {
    titleColor = value;
    build();
  }

  void setTitleVisible(bool value) {
    isTitleVisible = value;
    build();
  }

  void setCloseButtonVisible(bool value) {
    isCloseButtonVisible = value;
    build();
  }

  void setOnPanUpdateCallback(OnPanUpdateCallback value) {
    onPanUpdateCallback = value;
    build();
  }

  void setOnPanEndCallback(OnPanEndCallback value) {
    onPanEndCallback = value;
    build();
  }

  void setCloseButtonCallback(CloseButtonCallback value) {
    closeButtonCallback = value;
    build();
  }

  void setOffset(Offset value) {
    offset = value;
    build();
  }

  Offset getOffset() {
    return offset;
  }

  Color getDefaultColor();
}
