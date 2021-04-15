import 'package:flutter/material.dart';
import 'package:synword/layers/uniqueCheckLayer.dart';
import 'package:synword/model/json/uniqueCheckData.dart';
import 'package:synword/widgets/layers/uniqueCheckWidget.dart';
import 'package:synword/widgets/textUniqueCheck.dart';
import 'package:synword/widgets/loadingScreen.dart';
import 'layersSetting.dart';
import 'package:synword/types.dart';

class OriginalTextUniqueCheckLayer extends UniqueCheckLayer {
  OriginalTextUniqueCheckLayer.zero() : super(LoadingScreen(), Offset.zero, null, null, layersSetting.uniqueCheckTitleColor, null, null, null, false, true, true, true) {
    build();
  }

  OriginalTextUniqueCheckLayer.common(Offset offset, UniqueCheckData originalTextCheckData) : super(LoadingScreen(), offset, originalTextCheckData, null, layersSetting.uniqueCheckTitleColor, null, null, null, false, true, true, true) {
    build();
  }

  OriginalTextUniqueCheckLayer(Offset offset, UniqueCheckData originalTextCheckData, Color titleColor, bool isLoadingWidgetEnabled, bool isMovingEnabled, bool isTitleVisible, bool isCloseButtonVisible, OnPanUpdateCallback onPanUpdateCallback, OnPanEndCallback onPanEndCallback, CloseButtonCallback closeButtonCallback)
      : super(LoadingScreen(), offset, originalTextCheckData, null, titleColor, onPanUpdateCallback, onPanEndCallback, closeButtonCallback, isLoadingWidgetEnabled, isMovingEnabled, isTitleVisible, isCloseButtonVisible) {
    build();
  }

  void build() {
    setWidget(UniqueCheckWidget(
        isLoadingScreenEnabled() ? getLoadingScreen() : TextUniqueCheck(getOriginalTextCheckData()!, getOffset()),
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
