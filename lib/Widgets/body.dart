import 'package:flutter/material.dart';
import 'package:synword/movingLayer.dart';
import 'package:synword/originalTextLayer.dart';
import 'package:synword/buttonBarLayer.dart';
import 'package:synword/originalTextUniqueCheckLayer.dart';
import 'package:synword/uniqueTextLayer.dart';
import 'package:synword/uniqueTextUniqueCheckLayer.dart';
import 'package:synword/twoTextUniqueCheckLayer.dart';
import 'package:synword/types.dart';
import 'package:synword/layersSetting.dart';
import 'dart:async';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  List<MovingLayer> _layerList;

  TextEditingController _textEditingController;

  double _originalTextUniqueness = 40;
  double _uniqueTextUniqueness = 85;

  OriginalTextLayer _originalText;
  ButtonBarLayer _buttonBar;

  bool _isButtonBarButtonNotVisible = false;

  @override
  void initState() {
    super.initState();

    _layerList = List<MovingLayer>();
    _textEditingController = TextEditingController();
    _originalText = OriginalTextLayer(_textEditingController, false);
    _buttonBar = ButtonBarLayer(true, true, buttonBarFirstButtonCallback(), buttonBarSecondButtonCallback());
  }

  FloatingActionButtonCallback buttonBarFirstButtonCallback() => () {
    setState(() {
      MovingLayer movingLayer;
      double originalProgress = _originalTextUniqueness / 100;
      double uniqueProgress = _uniqueTextUniqueness / 100;
      Offset offset = Offset(0, (_layerList.length + 1) * TitleHeight);

      if (isContains(OriginalTextUniqueCheckLayer) && isContains(UniqueTextLayer)) {
        deleteLayer(OriginalTextUniqueCheckLayer);
        offset = Offset(0, (_layerList.length + 1) * TitleHeight);
        movingLayer = TwoTextUniqueCheckLayer.common(offset, originalProgress, uniqueProgress);
      } else if (isContains(UniqueTextLayer)) {
        movingLayer = UniqueTextUniqueCheckLayer.common(offset, uniqueProgress);
      } else {
        movingLayer = OriginalTextUniqueCheckLayer.common(offset, originalProgress);
      }

      movingLayer.setOnPanUpdateCallback(layerOnPanUpdateCallback(movingLayer));
      movingLayer.setOnPanEndCallback(layerOnPanEndCallback(movingLayer));
      movingLayer.setCloseButtonCallback(layerCloseButtonCallback(movingLayer));
      addLayer(movingLayer);
    });
  };

  FloatingActionButtonCallback buttonBarSecondButtonCallback() => () {
    setState(() {
      MovingLayer movingLayer;
      Offset offset = Offset(0, (_layerList.length + 1) * TitleHeight);

      movingLayer = UniqueTextLayer.common(offset);

      movingLayer.setOnPanUpdateCallback(layerOnPanUpdateCallback(movingLayer));
      movingLayer.setOnPanEndCallback(layerOnPanEndCallback(movingLayer));
      movingLayer.setCloseButtonCallback(layerCloseButtonCallback(movingLayer));
      addLayer(movingLayer);
    });
  };

  OnPanUpdateCallback layerOnPanUpdateCallback(MovingLayer layer) => (offset) {
    Offset newOffset = Offset(0, layer.getOffset().dy + offset.dy);
    double bottomBorder = MediaQuery.of(context).copyWith().size.height - 127;

    setState(() {
      if (_layerList.length < 2 && newOffset.dy >= TitleHeight && newOffset.dy <= bottomBorder) {
        layer.setOffset(newOffset);
      } else if (_layerList.length >= 2 && newOffset.dy >= TitleHeight && !isLayerOutOfBounds(getIndex(layer.runtimeType), newOffset) && newOffset.dy <= bottomBorder) {
        layer.setOffset(newOffset);
      }

      updateLayers();
    });
  };

  OnPanEndCallback layerOnPanEndCallback(MovingLayer layer) => (offset) {
    double border;
    int index = getIndex(layer.runtimeType);

    if (offset.dy > 0) {
      if (index + 1 != _layerList.length) {
        border = _layerList[index + 1].getOffset().dy - TitleHeight / 1.2;
      } else {
        border = MediaQuery.of(context).copyWith().size.height - 127;
      }

      hideLayer(layer, border);
    } else if (offset.dy < 0) {
      if (index != 0) {
        border = _layerList[index - 1].getOffset().dy + TitleHeight;
      } else {
        border = TitleHeight;
      }

      showLayer(layer, border);
    }
  };

  CloseButtonCallback layerCloseButtonCallback(MovingLayer layer) => () {
    setState(() {
      deleteLayer(layer.runtimeType);
    });
  };

  void addLayer(MovingLayer layer) {
    _layerList.add(layer);
    setLayerDefaultOffset();
    updateLayers();
  }

  void deleteLayer(Type type) {
    for (int i = 0; i < _layerList.length; i++) {
      if (_layerList[i].runtimeType == type) {
        _layerList.removeAt(i);
        break;
      }
    }

    updateLayers();
  }

  void updateLayers() {
    updateOriginalTextTitleVisible();
    updateLayersTitleColors();
    updateLastLayerTitleVisible();
    updateButtons();
  }

  void updateOriginalTextTitleVisible() {
    if (_layerList.isNotEmpty) {
      _originalText.setTitleVisible(true);
    } else {
      _originalText.setTitleVisible(false);
    }
  }

  void updateLayersTitleColors() {
    if (_layerList.isNotEmpty) {
      for (int i = 0; i < _layerList.length - 1; i++) {
        _layerList[i].setTitleColor(_layerList[i].getDefaultColor());
      }

      _layerList.last.setTitleColor(Colors.white);
    }
  }

  void updateLastLayerTitleVisible() {
    if (_layerList.isNotEmpty) {
      if (_layerList.last.getOffset().dy >= MediaQuery.of(context).copyWith().size.height - 137) {
        _layerList.last.setTitleVisible(false);
      } else {
        _layerList.last.setTitleVisible(true);
      }
    }
  }

  void updateButtons() {
    updateUpButton();
    updateCheckButton();
    updateButtonBarButtonVisible();
  }

  void updateCheckButton() {
    if (_layerList.isNotEmpty) {
      Type type = _layerList.last.runtimeType;

      if (type == UniqueTextUniqueCheckLayer || type == OriginalTextUniqueCheckLayer || type == TwoTextUniqueCheckLayer) {
        _buttonBar.setFirstButtonVisible(false);
      } else if (!_isButtonBarButtonNotVisible) {
        _buttonBar.setFirstButtonVisible(true);
      }
    }
  }

  void updateUpButton() {
    if (_layerList.isNotEmpty) {
      if (isContains(UniqueTextLayer)) {
        _buttonBar.setSecondButtonVisible(false);
      }
    }
  }

  void updateButtonBarButtonVisible() {
    if (!_buttonBar.getFirstButtonVisible() && !_buttonBar.getSecondButtonVisible()) {
      _isButtonBarButtonNotVisible = true;
    }

    if (_layerList.isEmpty) {
      _buttonBar.setFirstButtonVisible(true);
      _buttonBar.setSecondButtonVisible(true);
      _isButtonBarButtonNotVisible = false;
    }
  }

  void hideLayer(MovingLayer layer, double border) {
    Timer.periodic(Duration(milliseconds: 5), (timer) {
      if (layer.getOffset().dy < border) {
        setState(() {
          Offset newOffset = Offset(0, layer.getOffset().dy + 10);

          if (newOffset.dy > border) {
            newOffset = Offset(0, border);
          }

          layer.setOffset(newOffset);
          updateLayers();
        });
      } else {
        timer.cancel();
      }
    });
  }

  void showLayer(MovingLayer layer, double border) {
    Timer.periodic(Duration(milliseconds: 5), (timer) {
      if (layer.getOffset().dy > border) {
        setState(() {
          Offset newOffset = Offset(0, layer.getOffset().dy - 10);

          if (newOffset.dy < border) {
            newOffset = Offset(0, border);
          }

          layer.setOffset(newOffset);
          updateLayers();
        });
      } else {
        timer.cancel();
      }
    });
  }

  void setLayerDefaultOffset() {
    for (int i = 0; i < _layerList.length; i++) {
      Offset offset = Offset(0, (i + 1) * TitleHeight);
      _layerList[i].setOffset(offset);
    }
  }

  bool isContains(Type type) {
    bool isContains = false;

    _layerList.forEach((element) {
      if (element.runtimeType == type) {
        isContains = true;
      }
    });

    return isContains;
  }

  bool isLayerOutOfBounds(int index, Offset newOffset) {
    bool isOutOfBounds = false;

    for (int i = index - 1; i >= 0; i--) {
      if (newOffset.dy < _layerList[i].getOffset().dy + TitleHeight / 1.2) {
        isOutOfBounds = true;
        return isOutOfBounds;
      }
    }

    for (int i = index + 1; i < _layerList.length; i++) {
      if (newOffset.dy > _layerList[i].getOffset().dy - TitleHeight / 1.2) {
        isOutOfBounds = true;
        return isOutOfBounds;
      }
    }

    return isOutOfBounds;
  }


  int getIndex(Type type) {
    int index = 0;

    for (int i = 0; i < _layerList.length; i++) {
      if (_layerList[i].runtimeType == type) {
        index = i;
        break;
      }
    }

    return index;
  }

  List<Widget> getWidgets() {
    List<Widget> widgetList = List<Widget>();
    widgetList.add(_originalText.getWidget());

    _layerList.forEach((element) {
      widgetList.add(element.getWidget());
    });

    widgetList.add(_buttonBar.getWidget());

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: getWidgets()
    );
  }
}
