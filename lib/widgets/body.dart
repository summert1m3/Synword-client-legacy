import 'package:flutter/material.dart';
import 'package:synword/internetChecker.dart';
import 'package:synword/movingLayer.dart';
import 'package:synword/originalTextLayer.dart';
import 'package:synword/buttonBarLayer.dart';
import 'package:synword/originalTextUniqueCheckLayer.dart';
import 'package:synword/serverException.dart';
import 'package:synword/textLongLengthException.dart';
import 'package:synword/textShortLengthException.dart';
import 'package:synword/uniqueCheckData.dart';
import 'package:synword/uniqueCheckException.dart';
import 'package:synword/uniqueTextLayer.dart';
import 'package:synword/uniqueTextUniqueCheckLayer.dart';
import 'package:synword/twoTextUniqueCheckLayer.dart';
import 'package:synword/types.dart';
import 'package:synword/layersSetting.dart';
import 'package:synword/widgets/userData/userDataController.dart';
import 'dart:async';

class Body extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;

  Body(
    this._scaffoldKey
  );

  @override
  State<StatefulWidget> createState() {
    return _BodyState(_scaffoldKey);
  }
}

class _BodyState extends State<Body> {
  final GlobalKey<ScaffoldState> _scaffoldKey;

  List<MovingLayer> _layerList;

  TextEditingController _textEditingController;

  UniqueCheckData _originalTextCheckData;

  OriginalTextLayer _originalTextLayer;
  ButtonBarLayer _buttonBarLayer;

  String _uniqueText;

  bool _isButtonBarButtonNotVisible = false;

  _BodyState(
    this._scaffoldKey
  );

  @override
  void initState() {
    super.initState();

    _layerList = List<MovingLayer>();
    _textEditingController = TextEditingController();
    _originalTextLayer = OriginalTextLayer(_textEditingController, false);
    _buttonBarLayer = ButtonBarLayer(true, true, _buttonBarFirstButtonCallback(), _buttonBarSecondButtonCallback());
  }

  FloatingActionButtonCallback _buttonBarFirstButtonCallback() => () async {
    if (await InternetChecker().isInternetAvailability()) {
      try {
        if (_isLayersContains(OriginalTextUniqueCheckLayer) && _isLayersContains(UniqueTextLayer)) {
          _deleteLayer(OriginalTextUniqueCheckLayer);

          await _createAndAddTwoTextUniqueCheckLayer();
        } else if (_isLayersContains(UniqueTextLayer)) {
          await _createAndAddUniqueTextUniqueCheckLayer();
        } else {
          await _createAndAddOriginalTextUniqueCheckLayer();
        }
      } on UniqueCheckException catch (exception) {

        if (exception.getLayer() != null) {
          setState(() {
            _deleteLayer(exception.getLayer().runtimeType);
          });
        }

        _showSnackBar('Server error');
      } on TextShortLengthException {
        _showSnackBar('Text length less than 100 characters');
      } on TextLongLengthException {
        _showSnackBar('Text length over 20000 characters');
      }
    } else {
      _showSnackBar('Check internet availability');
    }
  };

  FloatingActionButtonCallback _buttonBarSecondButtonCallback() => () async {
    String originalText = _textEditingController.value.text;
    UniqueTextLayer uniqueTextLayer;

      if (await InternetChecker().isInternetAvailability()) {
        try {
          if (originalText.length < 10) {
            throw TextShortLengthException();
          }

          if (originalText.length > 20000) {
            throw TextLongLengthException();
          }

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

          _uniqueText = await userDataController.uniqueUpRequest(originalText);

          if (uniqueTextLayer != null) {
            setState(() {
              uniqueTextLayer.setLoadingScreenEnabled(false);
              uniqueTextLayer.setText(_uniqueText);
            });
          }
        } on ServerException {
          if (uniqueTextLayer != null) {
            setState(() {

              _deleteLayer(uniqueTextLayer.runtimeType);
            });
          }

          _showSnackBar('Server error');
        } on TextShortLengthException {
          _showSnackBar('Text length less than 10 characters');
        } on TextLongLengthException {
          _showSnackBar('Text length over 20000 characters');
        }
      } else {
        _showSnackBar('Check internet availability');
      }
  };

  OnPanUpdateCallback _layerOnPanUpdateCallback(MovingLayer layer) => (offset) {
    if (layer.isMovingEnabled()) {
      Offset newOffset = Offset(0, layer.getOffset().dy + offset.dy);
      double bottomBorder = MediaQuery.of(context).copyWith().size.height - 127;

      setState(() {
        if (_layerList.length < 2 && newOffset.dy >= layersSetting.titleHeight - layersSetting.titleContactHeight && newOffset.dy <= bottomBorder) {
          layer.setOffset(newOffset);
        } else if (_layerList.length >= 2 && newOffset.dy >= layersSetting.titleHeight - layersSetting.titleContactHeight && !_isLayerOutOfBounds(_getLayerIndexInLayerList(layer.runtimeType), newOffset) && newOffset.dy <= bottomBorder) {
          layer.setOffset(newOffset);
        }

        _updateLayers();
      });
    }
  };

  OnPanEndCallback _layerOnPanEndCallback(MovingLayer layer) => (offset) {
    if (layer.isMovingEnabled()) {
      double border;
      int index = _getLayerIndexInLayerList(layer.runtimeType);

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

  Future _createAndAddUniqueTextUniqueCheckLayer() async {
    UniqueTextUniqueCheckLayer uniqueCheckLayer;

    try {
      Offset offset = Offset(0, (_layerList.length + 1) * layersSetting.titleHeight);

      uniqueCheckLayer = UniqueTextUniqueCheckLayer.zero();
      uniqueCheckLayer.setOffset(offset);
      uniqueCheckLayer.setLoadingScreenEnabled(true);
      _setCallbackFunctions(uniqueCheckLayer);

      setState(() {
        _addLayer(uniqueCheckLayer);
      });

      UniqueCheckData uniqueCheckData = await userDataController.uniqueCheckRequest(_uniqueText);

      if (uniqueCheckLayer != null) {
        setState(() {
          uniqueCheckLayer.setLoadingScreenEnabled(false);
          uniqueCheckLayer.setUniqueTextCheckData(uniqueCheckData);
        });
      }
    } on ServerException {
      throw UniqueCheckException(uniqueCheckLayer);
    }
  }

  Future _createAndAddTwoTextUniqueCheckLayer() async {
    TwoTextUniqueCheckLayer uniqueCheckLayer;

    try {
      Offset offset = Offset(0, (_layerList.length + 1) * layersSetting.titleHeight);

      uniqueCheckLayer = TwoTextUniqueCheckLayer.zero();
      uniqueCheckLayer.setOffset(offset);
      uniqueCheckLayer.setLoadingScreenEnabled(true);
      _setCallbackFunctions(uniqueCheckLayer);

      setState(() {
        _addLayer(uniqueCheckLayer);
      });

      UniqueCheckData uniqueUniqueCheckData = await userDataController.uniqueCheckRequest(_uniqueText);

      setState(() {
        uniqueCheckLayer.setLoadingScreenEnabled(false);
        uniqueCheckLayer.setOriginalTextCheckData(_originalTextCheckData);
        uniqueCheckLayer.setUniqueTextCheckData(uniqueUniqueCheckData);
      });
    } on ServerException {
      throw UniqueCheckException(uniqueCheckLayer);
    }
  }

  Future _createAndAddOriginalTextUniqueCheckLayer() async {
    OriginalTextUniqueCheckLayer uniqueCheckLayer;
    String originalText = _textEditingController.value.text;

    if (originalText.length < 100) {
      throw TextShortLengthException();
    }

    if (originalText.length > 20000) {
      throw TextLongLengthException();
    }

    try {
      Offset offset = Offset(0, (_layerList.length + 1) * layersSetting.titleHeight);

      uniqueCheckLayer = OriginalTextUniqueCheckLayer.zero();
      uniqueCheckLayer.setOffset(offset);
      uniqueCheckLayer.setLoadingScreenEnabled(true);
      _setCallbackFunctions(uniqueCheckLayer);

      setState(() {
        _addLayer(uniqueCheckLayer);
      });

      _originalTextCheckData = await userDataController.uniqueCheckRequest(originalText);

      if (uniqueCheckLayer != null) {
        setState(() {
          uniqueCheckLayer.setLoadingScreenEnabled(false);
          uniqueCheckLayer.setOriginalTextCheckData(_originalTextCheckData);
        });
      }
    } on ServerException {
      throw UniqueCheckException(uniqueCheckLayer);
    }
  }

  void _setCallbackFunctions(MovingLayer layer) {
    layer.setOnPanUpdateCallback(_layerOnPanUpdateCallback(layer));
    layer.setOnPanEndCallback(_layerOnPanEndCallback(layer));
    layer.setCloseButtonCallback(_layerCloseButtonCallback(layer));
  }

  void _showSnackBar(String message) {
    Scaffold.of(context).hideCurrentSnackBar();
    SnackBar snackBar = SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _addLayer(MovingLayer layer) {
    _layerList.add(layer);
    _setLayersDefaultOffset();
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

  void _updateLayers() {
    _updateOriginalTextTitleVisible();
    _updateLayersTitleColors();
    _updateLastLayerTitleVisible();
    _updateLayersCloseButtonVisible();
    _updateButtons();
  }

  void _updateOriginalTextTitleVisible() {
    if (_layerList.isNotEmpty) {
      _originalTextLayer.setTitleVisible(true);
    } else {
      _originalTextLayer.setTitleVisible(false);
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
        _buttonBarLayer.setFirstButtonVisible(false);
      } else if (!_isButtonBarButtonNotVisible) {
        _buttonBarLayer.setFirstButtonVisible(true);
      }
    }
  }

  void _updateUpButton() {
    if (_layerList.isNotEmpty) {
      if (_isLayersContains(UniqueTextLayer)) {
        _buttonBarLayer.setSecondButtonVisible(false);
      } else {
        _buttonBarLayer.setSecondButtonVisible(true);
      }
    }
  }

  void _updateButtonBarButtonVisible() {
    if (!_buttonBarLayer.getFirstButtonVisible() && !_buttonBarLayer.getSecondButtonVisible()) {
      _isButtonBarButtonNotVisible = true;
    }

    if (_layerList.isEmpty) {
      _buttonBarLayer.setFirstButtonVisible(true);
      _buttonBarLayer.setSecondButtonVisible(true);
      _isButtonBarButtonNotVisible = false;
    }
  }

  void _setLayersDefaultOffset() {
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

  bool _isLayersContains(Type type) {
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

  int _getLayerIndexInLayerList(Type type) {
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
    widgetList.add(_originalTextLayer.getWidget());

    _layerList.forEach((element) {
      widgetList.add(element.getWidget());
    });

    widgetList.add(_buttonBarLayer.getWidget());

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _getWidgets()
    );
  }
}
