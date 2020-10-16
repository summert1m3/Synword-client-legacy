import 'package:flutter/material.dart';
import 'package:synword/widgets/layers/uniqueTextWidget.dart';
import 'movingLayer.dart';
import 'layersSetting.dart';
import 'types.dart';

class UniqueTextLayer extends MovingLayer {
  UniqueTextLayer.zero() {
    offset = Offset.zero;
    titleColor = UniqueTextTitleColor;
    isTitleVisible = true;
    isCloseButtonVisible = true;
    onPanUpdateCallback = null;
    onPanEndCallback = null;
    closeButtonCallback = null;
    build();
  }

  UniqueTextLayer.common(Offset offset) {
    this.offset = offset;
    titleColor = UniqueTextTitleColor;
    isTitleVisible = true;
    isCloseButtonVisible = true;
    onPanUpdateCallback = null;
    onPanEndCallback = null;
    closeButtonCallback = null;
    build();
  }

  UniqueTextLayer(Offset offset, Color titleColor, bool isTitleVisible, bool isCloseButtonVisible, OnPanUpdateCallback onPanUpdateCallback, OnPanEndCallback onPanEndCallback, CloseButtonCallback closeButtonCallback) {
    this.offset = offset;
    this.titleColor = titleColor;
    this.isTitleVisible = isTitleVisible;
    this.isCloseButtonVisible = isCloseButtonVisible;
    this.onPanUpdateCallback = onPanUpdateCallback;
    this.onPanEndCallback = onPanEndCallback;
    this.closeButtonCallback = closeButtonCallback;
    build();
  }

  void build() {
    widget = UniqueTextWidget(
        offset,
        titleColor,
        isTitleVisible,
        isCloseButtonVisible,
        onPanUpdateCallback,
        onPanEndCallback,
        closeButtonCallback
    );
  }

  Color getDefaultColor() {
    return UniqueTextTitleColor;
  }
}
