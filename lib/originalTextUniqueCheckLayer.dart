import 'package:flutter/material.dart';
import 'package:synword/widgets/layers/uniqueCheckWidget.dart';
import 'package:synword/widgets/textUniqueCheck.dart';
import 'layersSetting.dart';
import 'movingLayer.dart';
import 'types.dart';

class OriginalTextUniqueCheckLayer extends MovingLayer {
  double _progress;

  OriginalTextUniqueCheckLayer.zero() : super(null, Offset.zero, UniqueCheckTitleColor, null, null, null, false, true, true) {
    _progress = 0;
    build();
  }

  OriginalTextUniqueCheckLayer.common(Offset offset, this._progress) : super(null, offset, UniqueCheckTitleColor, null, null, null, false, true, true) {
    build();
  }

  OriginalTextUniqueCheckLayer(Offset offset, this._progress, Color titleColor, bool isLoadingWidgetEnabled, bool isTitleVisible, bool isCloseButtonVisible, OnPanUpdateCallback onPanUpdateCallback, OnPanEndCallback onPanEndCallback, CloseButtonCallback closeButtonCallback)
      : super(null, offset, titleColor, onPanUpdateCallback, onPanEndCallback, closeButtonCallback, isLoadingWidgetEnabled, isTitleVisible, isCloseButtonVisible) {
    build();
  }

  void build() {
    widget = UniqueCheckWidget(
        isLoadingWidgetEnabled ? loadingWidget : TextUniqueCheck(offset, _progress),
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
