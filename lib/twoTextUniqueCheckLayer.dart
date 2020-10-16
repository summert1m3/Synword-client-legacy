import 'package:flutter/material.dart';
import 'package:synword/widgets/layers/uniqueCheckWidget.dart';
import 'package:synword/widgets/twoTextUniqueCheck.dart';
import 'movingLayer.dart';
import 'layersSetting.dart';
import 'types.dart';

class TwoTextUniqueCheckLayer extends MovingLayer {
  double _originalProgress;
  double _uniqueProgress;

  TwoTextUniqueCheckLayer.zero() {
    offset = Offset.zero;
    _originalProgress = 0;
    _uniqueProgress = 0;
    titleColor = UniqueCheckTitleColor;
    onPanUpdateCallback = null;
    onPanEndCallback = null;
    closeButtonCallback = null;
    isTitleVisible = true;
    isCloseButtonVisible = true;
    build();
  }

  TwoTextUniqueCheckLayer.common(Offset offset, double originalProgress, double uniqueProgress) {
    this.offset = offset;
    _originalProgress = originalProgress;
    _uniqueProgress = uniqueProgress;
    titleColor = UniqueCheckTitleColor;
    isTitleVisible = true;
    isCloseButtonVisible = true;
    onPanUpdateCallback = null;
    onPanEndCallback = null;
    closeButtonCallback = null;
    build();
  }

  TwoTextUniqueCheckLayer(Offset offset, double originalProgress, double uniqueProgress, Color titleColor, bool isTitleVisible, bool isCloseButtonVisible, OnPanUpdateCallback onPanUpdateCallback, OnPanEndCallback onPanEndCallback, CloseButtonCallback closeButtonCallback) {
    this.offset = offset;
    _originalProgress = originalProgress;
    _uniqueProgress = uniqueProgress;
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
        TwoTextUniqueCheckWidget(offset, _originalProgress, _uniqueProgress),
        offset,
        titleColor,
        isTitleVisible,
        isCloseButtonVisible,
        onPanUpdateCallback,
        onPanEndCallback,
        closeButtonCallback
    );
  }

  void setOriginalProgress(double value) {
    _originalProgress = value;
    build();
  }

  void setUniqueProgress(double value) {
    _uniqueProgress = value;
    build();
  }

  Color getDefaultColor() {
    return UniqueCheckTitleColor;
  }
}
