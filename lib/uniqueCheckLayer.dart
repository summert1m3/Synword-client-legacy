import 'package:flutter/material.dart';
import 'package:synword/movingLayer.dart';
import 'package:synword/uniqueCheckData.dart';
import 'types.dart';

abstract class UniqueCheckLayer extends MovingLayer {
  UniqueCheckData _originalTextCheckData;
  UniqueCheckData _uniqueTextCheckData;

  UniqueCheckLayer(Widget loadingWidget, Offset offset, this._originalTextCheckData, this._uniqueTextCheckData, Color titleColor, OnPanUpdateCallback onPanUpdateCallback, OnPanEndCallback onPanEndCallback, CloseButtonCallback closeButtonCallback, bool isLoadingWidgetEnabled, bool isMovingEnabled, bool isTitleVisible, bool isCloseButtonVisible)
    : super(loadingWidget, offset, titleColor, onPanUpdateCallback, onPanEndCallback, closeButtonCallback, isLoadingWidgetEnabled, isMovingEnabled, isTitleVisible, isCloseButtonVisible);

  void setOriginalTextCheckData(UniqueCheckData value) {
    _originalTextCheckData = value;
    build();
  }

  UniqueCheckData getOriginalTextCheckData() {
    return _originalTextCheckData;
  }

  void setUniqueTextCheckData(UniqueCheckData value) {
    _uniqueTextCheckData = value;
    build();
  }

  UniqueCheckData getUniqueTextCheckData() {
    return _uniqueTextCheckData;
  }
}