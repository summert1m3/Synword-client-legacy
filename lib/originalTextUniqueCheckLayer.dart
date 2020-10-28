import 'package:flutter/material.dart';
import 'package:synword/widgets/layers/uniqueCheckWidget.dart';
import 'package:synword/widgets/textUniqueCheck.dart';
import 'layersSetting.dart';
import 'movingLayer.dart';
import 'types.dart';

class OriginalTextUniqueCheckLayer extends MovingLayer {
  double _progress;

  OriginalTextUniqueCheckLayer.zero() : super(null, Offset.zero, layersSetting.uniqueCheckTitleColor, null, null, null, false, true, true, true) {
    _progress = 0;
    build();
  }

  OriginalTextUniqueCheckLayer.common(Offset offset, this._progress) : super(null, offset, layersSetting.uniqueCheckTitleColor, null, null, null, false, true, true, true) {
    build();
  }

  OriginalTextUniqueCheckLayer(Offset offset, this._progress, Color titleColor, bool isLoadingWidgetEnabled, bool isMovingEnabled, bool isTitleVisible, bool isCloseButtonVisible, OnPanUpdateCallback onPanUpdateCallback, OnPanEndCallback onPanEndCallback, CloseButtonCallback closeButtonCallback)
      : super(null, offset, titleColor, onPanUpdateCallback, onPanEndCallback, closeButtonCallback, isLoadingWidgetEnabled, isMovingEnabled, isTitleVisible, isCloseButtonVisible) {
    build();
  }

  void build() {
    setWidget(UniqueCheckWidget(
        isLoadingScreenEnabled() ? getLoadingScreen() : TextUniqueCheck(getOffset(), _progress),
        getOffset(),
        getTitleColor(),
        isTitleVisible(),
        isCloseButtonVisible(),
        getOnPanUpdateCallback(),
        getOnPanEndCallback(),
        getCloseButtonCallback()
    ));
  }

  void setProgress(double value) {
    _progress = value;
    build();
  }

  Color getDefaultColor() {
    return layersSetting.uniqueCheckTitleColor;
  }

}
