import 'package:flutter/material.dart';
import 'package:synword/uniqueCheckData.dart';
import 'package:synword/uniqueCheckLayer.dart';
import 'package:synword/widgets/layers/uniqueCheckWidget.dart';
import 'package:synword/widgets/textUniqueCheck.dart';
import 'package:synword/widgets/loadingScreen.dart';
import 'layersSetting.dart';
import 'types.dart';

class UniqueTextUniqueCheckLayer extends UniqueCheckLayer {
  UniqueTextUniqueCheckLayer.zero() : super(LoadingScreen(), Offset.zero, null, null, layersSetting.uniqueCheckTitleColor, null, null, null, false, true, true, true) {
    build();
  }

  UniqueTextUniqueCheckLayer.common(Offset offset, UniqueCheckData uniqueTextCheckData) : super(LoadingScreen(), offset, null, uniqueTextCheckData, layersSetting.uniqueCheckTitleColor, null, null, null, false, true, true, true) {
    build();
  }

  UniqueTextUniqueCheckLayer(Offset offset, UniqueCheckData uniqueTextCheckData, Color titleColor, bool isLoadingWidgetEnabled, bool isMovingEnabled, bool isTitleVisible, bool isCloseButtonVisible, OnPanUpdateCallback onPanUpdateCallback, OnPanEndCallback onPanEndCallback, CloseButtonCallback closeButtonCallback)
      : super(LoadingScreen(), offset, null, uniqueTextCheckData, titleColor, onPanUpdateCallback, onPanEndCallback, closeButtonCallback, isLoadingWidgetEnabled, isMovingEnabled, isTitleVisible, isCloseButtonVisible) {
    build();
  }

  void build() {
    setWidget(UniqueCheckWidget(
        isLoadingScreenEnabled() ? getLoadingScreen() : TextUniqueCheck(getUniqueTextCheckData(), getOffset()),
        getOffset(),
        getTitleColor(),
        isTitleVisible(),
        isCloseButtonVisible(),
        getOnPanUpdateCallback(),
        getOnPanEndCallback(),
        getCloseButtonCallback()
    ));
  }

  Color getDefaultColor() {
    return layersSetting.uniqueCheckTitleColor;
  }
}
