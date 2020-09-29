import 'package:flutter/material.dart';
import 'dart:async';
import 'package:synword/widgets/layers/buttonBarLayer.dart';
import 'package:synword/widgets/layers/originalTextLayer.dart';
import 'package:synword/widgets/layers/uniqueTextLayer.dart';
import 'package:synword/widgets/layers/uniqueCheckLayer.dart';
import 'package:synword/widgets/layers/layerInfo.dart';
import 'package:synword/widgets/layers/layersSetting.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  List<Offset> _offsets = List<Offset>();
  List<LayerInfo> _layersInfo = List<LayerInfo>();
  List<Widget> _layers = List<Widget>();

  bool _isFirstFloatingActionButtonVisible = true;
  bool _isSecondFloatingActionButtonVisible = true;
  bool _isFloatingActionButtonsNotVisible = false;

  TextEditingController _textEditingController = TextEditingController();

  void addLayer(LayerInfo item) {
    _layersInfo.add(item);

    for (int i = 0; i < _offsets.length; i++) {
      _offsets[i] = Offset(0, ((i + 1) * LayersSetting.titleHeight).toDouble());
    }
  }

  void deleteLayer(int position) {
    _offsets.removeAt(position);
    _layersInfo.removeAt(position);
    updateLayersInfo(position);
  }

  void updateLayersInfo(int index) {
    for (int i = index; i < _layersInfo.length; i++) {
      _layersInfo[i].setPosition(_layersInfo[i].getPositionInStack() - 1);
    }
  }

  void updateLayers() {
    _layers = List<Widget>();

    for (int i = 0; i < _layersInfo.length; i++) {
      bool isTitleVisible = true;
      bool isCloseButtonVisible = false;
      bool isContains = false;
      Color color = Colors.white;

      if (i == _layersInfo.length - 1) {
        isCloseButtonVisible = true;
      }

      if (_layersInfo[i].getName() == 'UniqueCheck') {
        for (int j = 0; j < _offsets.length; j++) {
          if (j == _layersInfo[i].getPositionInStack()) {
            isContains = true;
          }
        }

        if (!isContains) {
          _offsets.add(Offset(0, ((_layers.length + 1) * LayersSetting.titleHeight).toDouble()));
        }

        if (_offsets[i].dy >=  MediaQuery.of(context).copyWith().size.height - 137) {
          isTitleVisible = false;
        }

        if (i != _layersInfo.length - 1) {
          color = UniqueCheckLayer.getColor();
        }

        UniqueCheckLayer layer = UniqueCheckLayer(
            _offsets[_layersInfo[i].getPositionInStack()],
            color,
            isTitleVisible,
            isCloseButtonVisible,
            (offset) {
              Offset newOffset = Offset(0, _offsets[_layersInfo[i].getPositionInStack()].dy + offset.dy);

              setState(() {
                if (_offsets.length < 2 && newOffset.dy >= LayersSetting.titleHeight && newOffset.dy <= MediaQuery.of(context).copyWith().size.height - 127) {
                  _offsets[_layersInfo[i].getPositionInStack()] = newOffset;
                } else if (_offsets.length >= 2 && newOffset.dy >= LayersSetting.titleHeight && !isOffsetOutOfBounds(_layersInfo[i].getPositionInStack(), newOffset) && newOffset.dy <= MediaQuery.of(context).copyWith().size.height - 127) {
                  _offsets[_layersInfo[i].getPositionInStack()] = newOffset;
                }
              });
            },
            (offset) {
              double border;

              if (offset.dy > 0) {
                if (i + 1 != _layersInfo.length) {
                  border = _offsets[i + 1].dy - LayersSetting.titleHeight / 1.2;
                } else {
                  border = MediaQuery.of(context).copyWith().size.height - 127;
                }

                hideLayer(i, border);
              } else if (offset.dy < 0) {
                if (i != 0) {
                  border = _offsets[i - 1].dy + LayersSetting.titleHeight;
                } else {
                  border = LayersSetting.titleHeight;
                }

                showLayer(i, border);
              }
            },
            () {
              setState(() {
                deleteLayer(_layersInfo[i].getPositionInStack());
                updateFloatingActionButtons();
              });
            }
        );

        _layers.add(layer);
      } else if (_layersInfo[i].getName() == 'UniqueText') {
        for (int j = 0; j < _offsets.length; j++) {
          if (j == _layersInfo[i].getPositionInStack()) {
            isContains = true;
          }
        }

        if (!isContains) {
          _offsets.add(Offset(0, ((_layers.length + 1) * LayersSetting.titleHeight).toDouble()));
        }

        if (_offsets[i].dy >=  MediaQuery.of(context).copyWith().size.height - 137) {
          isTitleVisible = false;
        }

        if (i != _layersInfo.length - 1) {
          color = UniqueTextLayer.getColor();
        }

        _layers.add(UniqueTextLayer(
          _offsets[_layersInfo[i].getPositionInStack()],
          color,
            isTitleVisible,
          isCloseButtonVisible,
          (offset) {
            Offset newOffset = Offset(0, _offsets[_layersInfo[i].getPositionInStack()].dy + offset.dy);
            setState(() {
              if (_offsets.length < 2 && newOffset.dy >= LayersSetting.titleHeight && newOffset.dy <= MediaQuery.of(context).copyWith().size.height - 127) {
                _offsets[_layersInfo[i].getPositionInStack()] = newOffset;
              } else if (_offsets.length >= 2 && newOffset.dy >= LayersSetting.titleHeight && !isOffsetOutOfBounds(_layersInfo[i].getPositionInStack(), newOffset) && newOffset.dy <= MediaQuery.of(context).copyWith().size.height - 127) {
                _offsets[_layersInfo[i].getPositionInStack()] = newOffset;
              }
            });
          },
          (offset) {
            double border;

            if (offset.dy > 0) {
              if (i + 1 != _layersInfo.length) {
                border = _offsets[i + 1].dy - LayersSetting.titleHeight / 1.2;
              } else {
                border = MediaQuery.of(context).copyWith().size.height - 127;
              }

              hideLayer(i, border);
            } else if (offset.dy < 0) {
              if (i != 0) {
                border = _offsets[i - 1].dy + LayersSetting.titleHeight;
              } else {
                if (i != 0) {
                  border = _offsets[i - 1].dy + LayersSetting.titleHeight;
                } else {
                  border = LayersSetting.titleHeight;
                }
              }

              showLayer(i, border);
            }
          },
          () {
            setState(() {
              deleteLayer(_layersInfo[i].getPositionInStack());
              updateFloatingActionButtons();
            });
          }
        )
      );
      }
    }
  }

  void hideLayer(int layerPosition, double border) {
    Timer.periodic(Duration(milliseconds: 5), (timer) {
      if (_offsets[layerPosition].dy < border) {
        setState(() {
          Offset newOffset = Offset(0, _offsets[layerPosition].dy + 10);

          if (newOffset.dy > border) {
            newOffset = Offset(0, border);
          }

          _offsets[layerPosition] = newOffset;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void showLayer(int layerPosition, double border) {
    Timer.periodic(Duration(milliseconds: 5), (timer) {
      if (_offsets[layerPosition].dy > border) {
        setState(() {
          Offset newOffset = Offset(0, _offsets[layerPosition].dy - 10);

          if (newOffset.dy < border) {
            newOffset = Offset(0, border);
          }

          _offsets[layerPosition] = newOffset;
        });
      } else {
        timer.cancel();
      }
    });
  }

  bool isOffsetOutOfBounds(int position, Offset offset) {
    for (int i = position - 1; i >= 0; i--) {
      if (offset.dy <= _offsets[i].dy + LayersSetting.titleHeight) {
        return true;
      }
    }

    for (int i = position + 1; i < _offsets.length; i++) {
      if (offset.dy >= _offsets[i].dy - LayersSetting.titleHeight) {
        return true;
      }
    }

    return false;
  }

  void updateCheckButton() {
    if (_layersInfo.isNotEmpty && !_isFloatingActionButtonsNotVisible) {
      if (_layersInfo[_layersInfo.length - 1].getName() == 'UniqueCheck') {
        _isFirstFloatingActionButtonVisible = false;
      } else {
        _isFirstFloatingActionButtonVisible = true;
      }
    } else if (_layersInfo.isEmpty && !_isFloatingActionButtonsNotVisible) {
      _isFirstFloatingActionButtonVisible = true;
    }
  }

  void updateUpButton() {
    if (_layersInfo.isNotEmpty && !_isFloatingActionButtonsNotVisible) {
      if (!isContains('UniqueText')) {
        _isSecondFloatingActionButtonVisible = true;
      } else {
        _isSecondFloatingActionButtonVisible = false;
      }
    } else if (_layersInfo.isEmpty && !_isFloatingActionButtonsNotVisible) {
      _isSecondFloatingActionButtonVisible = true;
    }
  }

  void updateFloatingActionButtons() {
    if ((!_isFirstFloatingActionButtonVisible && !_isSecondFloatingActionButtonVisible) && _layersInfo.isNotEmpty) {
      _isFloatingActionButtonsNotVisible = true;
    } else {
      _isFloatingActionButtonsNotVisible = false;
    }

    updateCheckButton();
    updateUpButton();
  }

  bool isContains(String name) {
    bool isContains = false;

    _layersInfo.forEach((element) {
      if (element.getName() == name) {
        isContains = true;
      }
    });

    return isContains;
  }

  List<Widget> createContent() {
    updateLayers();
    List<Widget> content = new List<Widget>();

    bool isOriginalTextTitleVisible = true;

    if (_layers.length == 0) {
      isOriginalTextTitleVisible = false;
    }

    content.add(OriginalTextLayer(_textEditingController, isOriginalTextTitleVisible));

    for (int i = 0; i < _layers.length; i++) {
      content.add(_layers[i]);
    }

    content.add(ButtonBarLayer(
      _isFirstFloatingActionButtonVisible,
      _isSecondFloatingActionButtonVisible,
      () {
        setState(() {
          if (isContains('UniqueCheck')) {
            int position = 0;

            _layersInfo.forEach((element) {
              if (element.getName() == 'UniqueCheck') {
                position = element.getPositionInStack();
              }
            });

            deleteLayer(position);
          }

          addLayer(LayerInfo('UniqueCheck', _layersInfo.length));
          updateFloatingActionButtons();
        });
      },
      () {
        setState(() {
          addLayer(LayerInfo('UniqueText', _layersInfo.length));
          updateFloatingActionButtons();
        });
      })
    );

    return content;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: createContent()
    );
  }
}
