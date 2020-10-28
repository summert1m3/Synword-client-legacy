import 'package:flutter/material.dart';
import 'package:synword/movingLayer.dart';
import 'package:synword/originalTextLayer.dart';
import 'package:synword/buttonBarLayer.dart';
import 'package:synword/originalTextUniqueCheckLayer.dart';
import 'package:synword/synonymizer.dart';
import 'package:synword/uniqueTextLayer.dart';
import 'package:synword/uniqueTextUniqueCheckLayer.dart';
import 'package:synword/twoTextUniqueCheckLayer.dart';
import 'package:synword/types.dart';
import 'package:synword/layersSetting.dart';
import 'package:synword/freeSynonymizer.dart';
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
  Synonymizer _synonymizer = FreeSynonymizer();

  double _originalTextUniqueness = 40;
  double _uniqueTextUniqueness = 85;

  OriginalTextLayer _originalText;
  ButtonBarLayer _buttonBar;

  String _uniqueText;

  bool _isButtonBarButtonNotVisible = false;

  @override
  void initState() {
    super.initState();

    _layerList = List<MovingLayer>();
    _textEditingController = TextEditingController();
    _originalText = OriginalTextLayer(_textEditingController, false);
    _buttonBar = ButtonBarLayer(true, true, _buttonBarFirstButtonCallback(), _buttonBarSecondButtonCallback());
  }

  FloatingActionButtonCallback _buttonBarFirstButtonCallback() => () async {
    setState(() {
      MovingLayer movingLayer;
      double originalProgress = _originalTextUniqueness / 100;
      double uniqueProgress = _uniqueTextUniqueness / 100;
      Offset offset = Offset(0, (_layerList.length + 1) * layersSetting.titleHeight);

      if (_isContains(OriginalTextUniqueCheckLayer) && _isContains(UniqueTextLayer)) {
        _deleteLayer(OriginalTextUniqueCheckLayer);
        offset = Offset(0, (_layerList.length + 1) * layersSetting.titleHeight);
        movingLayer = TwoTextUniqueCheckLayer.common(offset, originalProgress, uniqueProgress);
      } else if (_isContains(UniqueTextLayer)) {
        movingLayer = UniqueTextUniqueCheckLayer.common(offset, uniqueProgress);
      } else {
        movingLayer = OriginalTextUniqueCheckLayer.common(offset, originalProgress);
      }

      movingLayer.setOnPanUpdateCallback(_layerOnPanUpdateCallback(movingLayer));
      movingLayer.setOnPanEndCallback(_layerOnPanEndCallback(movingLayer));
      movingLayer.setCloseButtonCallback(_layerCloseButtonCallback(movingLayer));
      _addLayer(movingLayer);
    });
  };

  FloatingActionButtonCallback _buttonBarSecondButtonCallback() => () async {
    UniqueTextLayer uniqueTextLayer;
    Offset offset = Offset(0, (_layerList.length + 1) * layersSetting.titleHeight);
    uniqueTextLayer = UniqueTextLayer.zero();
    uniqueTextLayer.setOffset(offset);
    uniqueTextLayer.setLoadingScreenEnabled(true);
    uniqueTextLayer.setOnPanUpdateCallback(_layerOnPanUpdateCallback(uniqueTextLayer));
    uniqueTextLayer.setOnPanEndCallback(_layerOnPanEndCallback(uniqueTextLayer));
    uniqueTextLayer.setCloseButtonCallback(_layerCloseButtonCallback(uniqueTextLayer));

    setState(() {
      _addLayer(uniqueTextLayer);
    });

    String originalText = _textEditingController.value.text;
    _uniqueText = await _synonymizer.synonymize(originalText);

    setState(() {
      uniqueTextLayer.setLoadingScreenEnabled(false);
      uniqueTextLayer.setText(_uniqueText);
    });
  };

  OnPanUpdateCallback _layerOnPanUpdateCallback(MovingLayer layer) => (offset) {
    if (layer.isMovingEnabled()) {
      Offset newOffset = Offset(0, layer.getOffset().dy + offset.dy);
      double bottomBorder = MediaQuery.of(context).copyWith().size.height - 127;

      setState(() {
        if (_layerList.length < 2 && newOffset.dy >= layersSetting.titleHeight - layersSetting.titleContactHeight && newOffset.dy <= bottomBorder) {
          layer.setOffset(newOffset);
        } else if (_layerList.length >= 2 && newOffset.dy >= layersSetting.titleHeight - layersSetting.titleContactHeight && !_isLayerOutOfBounds(_getIndex(layer.runtimeType), newOffset) && newOffset.dy <= bottomBorder) {
          layer.setOffset(newOffset);
        }

        _updateLayers();
      });
    }
  };

  OnPanEndCallback _layerOnPanEndCallback(MovingLayer layer) => (offset) {
    if (layer.isMovingEnabled()) {
      double border;
      int index = _getIndex(layer.runtimeType);

      if (offset.dy > 0) {
        if (index + 1 != _layerList.length) {
          border = _layerList[index + 1].getOffset().dy - layersSetting.titleHeight + layersSetting.titleContactHeight;
        } else {
          border = MediaQuery.of(context).copyWith().size.height - 127;
        }

        _hideLayer(layer, border);
      } else if (offset.dy < 0) {
        if (index != 0) {
          border = _layerList[index - 1].getOffset().dy + layersSetting.titleHeight - layersSetting.titleContactHeight;
        } else {
          border = layersSetting.titleHeight - layersSetting.titleContactHeight;
        }

        _showLayer(layer, border);
      }
    }
  };

  CloseButtonCallback _layerCloseButtonCallback(MovingLayer layer) => () {
    setState(() {
      _deleteLayer(layer.runtimeType);
    });
  };

  void _addLayer(MovingLayer layer) {
    _layerList.add(layer);
    _setLayerDefaultOffset();
    _updateLayers();
  }

  void _deleteLayer(Type type) {
    for (int i = 0; i < _layerList.length; i++) {
      if (_layerList[i].runtimeType == type) {
        _layerList.removeAt(i);
        break;
      }
    }

    _updateLayers();
  }

  void _updateLayers() {
    _updateOriginalTextTitleVisible();
    _updateLayersTitleColors();
    _updateLastLayerTitleVisible();
    _updateLayersCloseButtonVisible();
    _updateButtons();
  }

  void _updateOriginalTextTitleVisible() {
    if (_layerList.isNotEmpty) {
      _originalText.setTitleVisible(true);
    } else {
      _originalText.setTitleVisible(false);
    }
  }

  void _updateLayersTitleColors() {
    if (_layerList.isNotEmpty) {
      for (int i = 0; i < _layerList.length - 1; i++) {
        _layerList[i].setTitleColor(_layerList[i].getDefaultColor());
      }

      _layerList.last.setTitleColor(Colors.white);
    }
  }

  void _updateLastLayerTitleVisible() {
    _layerList.forEach((element) {
      if (element.getOffset().dy >= MediaQuery.of(context).copyWith().size.height - 137) {
        element.setTitleVisible(false);
      } else {
        element.setTitleVisible(true);
      }
    });
  }

  void _updateLayersCloseButtonVisible() {
    for (int i = 0; i < _layerList.length; i++) {
      if (i == _layerList.length - 1) {
        _layerList[i].setCloseButtonVisible(true);
      } else {
        _layerList[i].setCloseButtonVisible(false);
      }
    }
  }

  void _updateButtons() {
    _updateUpButton();
    _updateCheckButton();
    _updateButtonBarButtonVisible();
  }

  void _updateCheckButton() {
    if (_layerList.isNotEmpty) {
      Type type = _layerList.last.runtimeType;

      if (type == UniqueTextUniqueCheckLayer || type == OriginalTextUniqueCheckLayer || type == TwoTextUniqueCheckLayer) {
        _buttonBar.setFirstButtonVisible(false);
      } else if (!_isButtonBarButtonNotVisible) {
        _buttonBar.setFirstButtonVisible(true);
      }
    }
  }

  void _updateUpButton() {
    if (_layerList.isNotEmpty) {
      if (_isContains(UniqueTextLayer)) {
        _buttonBar.setSecondButtonVisible(false);
      } else {
        _buttonBar.setSecondButtonVisible(true);
      }
    }
  }

  void _updateButtonBarButtonVisible() {
    if (!_buttonBar.getFirstButtonVisible() && !_buttonBar.getSecondButtonVisible()) {
      _isButtonBarButtonNotVisible = true;
    }

    if (_layerList.isEmpty) {
      _buttonBar.setFirstButtonVisible(true);
      _buttonBar.setSecondButtonVisible(true);
      _isButtonBarButtonNotVisible = false;
    }
  }

  void _hideLayer(MovingLayer layer, double border) {
    layer.setMovingEnabled(false);

    Timer.periodic(Duration(milliseconds: 5), (timer) {
      if (layer.getOffset().dy < border) {

        setState(() {
          Offset newOffset = Offset(0, layer.getOffset().dy + 10);
          if (newOffset.dy > border) {
            newOffset = Offset(0, border);
          }

          layer.setOffset(newOffset);
          _updateLayers();
        });
      } else {
        layer.setMovingEnabled(true);
        timer.cancel();
      }
    });
  }

  void _showLayer(MovingLayer layer, double border) {
    layer.setMovingEnabled(false);

    Timer.periodic(Duration(milliseconds: 5), (timer) {
      if (layer.getOffset().dy > border) {

        setState(() {
          Offset newOffset = Offset(0, layer.getOffset().dy - 10);
          if (newOffset.dy < border) {
            newOffset = Offset(0, border);
          }

          layer.setOffset(newOffset);
          _updateLayers();
        });
      } else {
        layer.setMovingEnabled(true);
        timer.cancel();
      }
    });
  }

  void _setLayerDefaultOffset() {
    for (int i = 0; i < _layerList.length; i++) {
      Offset offset;

      if (i == 0) {
        offset = Offset(0, layersSetting.titleHeight - layersSetting.titleContactHeight);
      } else {
        offset = Offset(0, _layerList[i - 1].getOffset().dy + layersSetting.titleHeight - layersSetting.titleContactHeight);
      }

      _layerList[i].setOffset(offset);
    }
  }

  bool _isContains(Type type) {
    bool isContains = false;

    _layerList.forEach((element) {
      if (element.runtimeType == type) {
        isContains = true;
      }
    });

    return isContains;
  }

  bool _isLayerOutOfBounds(int index, Offset newOffset) {
    bool isOutOfBounds = false;

    for (int i = index - 1; i >= 0; i--) {
      if (newOffset.dy < _layerList[i].getOffset().dy + layersSetting.titleHeight - layersSetting.titleContactHeight) {
        isOutOfBounds = true;
        return isOutOfBounds;
      }
    }

    for (int i = index + 1; i < _layerList.length; i++) {
      if (newOffset.dy > _layerList[i].getOffset().dy - layersSetting.titleHeight + layersSetting.titleContactHeight) {
        isOutOfBounds = true;
        return isOutOfBounds;
      }
    }

    return isOutOfBounds;
  }


  int _getIndex(Type type) {
    int index = 0;

    for (int i = 0; i < _layerList.length; i++) {
      if (_layerList[i].runtimeType == type) {
        index = i;
        break;
      }
    }

    return index;
  }

  List<Widget> _getWidgets() {
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
      children: _getWidgets()
    );
  }
}
