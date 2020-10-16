import 'package:flutter/material.dart';
import 'package:synword/widgets/layers/uniqueCheckWidget.dart';
import 'package:synword/widgets/textUniqueCheck.dart';
import 'layersSetting.dart';
import 'movingLayer.dart';
import 'types.dart';

class OriginalTextUniqueCheckLayer extends MovingLayer {
  double _progress;

  OriginalTextUniqueCheckLayer.zero() {
    offset = Offset.zero;
    _progress = 0;
    titleColor = UniqueCheckTitleColor;
    onPanUpdateCallback = null;
    onPanEndCallback = null;
    closeButtonCallback = null;
    isTitleVisible = true;
    isCloseButtonVisible = true;
    build();
  }

  OriginalTextUniqueCheckLayer.common(Offset offset, double progress) {
    this.offset = offset;
    this._progress = progress;
    titleColor = UniqueCheckTitleColor;
    isTitleVisible = true;
    isCloseButtonVisible = true;
    onPanUpdateCallback = null;
    onPanEndCallback = null;
    closeButtonCallback = null;
    build();
  }

  OriginalTextUniqueCheckLayer(Offset offset, double progress, Color titleColor, bool isTitleVisible, bool isCloseButtonVisible, OnPanUpdateCallback onPanUpdateCallback, OnPanEndCallback onPanEndCallback, CloseButtonCallback closeButtonCallback) {
    this.offset = offset;
    _progress = progress;
    this.titleColor = titleColor;
    this.isTitleVisible = isTitleVisible;
    this.isCloseButtonVisible = isCloseButtonVisible;
    this.onPanUpdateCallback = onPanUpdateCallback;
    this.onPanEndCallback = onPanEndCallback;
    this.closeButtonCallback = closeButtonCallback;
    build();
  }

  void build() {
    widget = UniqueCheckWidget(
        TextUniqueCheck(offset, _progress),
        offset,
        titleColor,
        isTitleVisible,
        isCloseButtonVisible,
        onPanUpdateCallback,
        onPanEndCallback,
        closeButtonCallback
    );
  }

  void setProgress(double value) {
    _progress = value;
    build();
  }

  Color getDefaultColor() {
    return UniqueCheckTitleColor;
  }

}
