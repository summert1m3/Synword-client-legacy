import 'package:flutter/material.dart';
import 'package:synword/widgets/layers/uniqueCheckWidget.dart';
import 'package:synword/widgets/textUniqueCheck.dart';
import 'movingLayer.dart';
import 'layersSetting.dart';
import 'types.dart';

class UniqueTextUniqueCheckLayer extends MovingLayer {
  double _progress;

  UniqueTextUniqueCheckLayer.zero() : super(null, Offset.zero, UniqueCheckTitleColor, null, null, null, false, true, true, true) {
    _progress = 0;
    build();
  }

  UniqueTextUniqueCheckLayer.common(Offset offset, this._progress) : super(null, offset, UniqueCheckTitleColor, null, null, null, false, true, true, true) {
    build();
  }

  UniqueTextUniqueCheckLayer(Offset offset, this._progress, Color titleColor, bool isLoadingWidgetEnabled, bool isMovingEnabled, bool isTitleVisible, bool isCloseButtonVisible, OnPanUpdateCallback onPanUpdateCallback, OnPanEndCallback onPanEndCallback, CloseButtonCallback closeButtonCallback)
      : super(null, offset, titleColor, onPanUpdateCallback, onPanEndCallback, closeButtonCallback, isLoadingWidgetEnabled, isMovingEnabled, isTitleVisible, isCloseButtonVisible) {
    build();
  }

  void build() {
    widget = UniqueCheckWidget(
        isLoadingWidgetEnabled ? loadingScreen : TextUniqueCheck(offset, _progress),
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
