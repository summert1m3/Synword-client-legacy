import 'package:flutter/material.dart';
import 'package:synword/Widgets/Layers/buttonBarLayer.dart';
import 'package:synword/Widgets/Layers/originalTextLayer.dart';
import 'package:synword/Widgets/Layers/uniqueTextLayer.dart';
import 'package:synword/Widgets/Layers/uniqueCheckLayer.dart';
import 'package:synword/Widgets/Layers/layerInfo.dart';

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
      _offsets[i] = Offset(0, ((i + 1) * 65).toDouble());
    }
  }

  void deleteLayer(int position) {
    _offsets.removeAt(position);
    _layersInfo.removeAt(position);
    updateLayersInfo(position);
  }

  void updateLayersInfo(int index) {
    for (int i = index; i < _layersInfo.length; i++) {
      _layersInfo[i].setPosition(_layersInfo[i].getPosition() - 1);
    }
  }

  void updateLayers() {
    _layers = List<Widget>();

    for (int i = 0; i < _layersInfo.length; i++) {
      bool isCloseButtonEnable = false;
      bool isContains = false;
      Color color = Colors.white;

      if (i == _layersInfo.length - 1) {
        isCloseButtonEnable = true;
      }

      if (_layersInfo[i].getName() == 'UniqueCheck') {
        for (int j = 0; j < _offsets.length; j++) {
          if (j == _layersInfo[i].getPosition()) {
            isContains = true;
          }
        }

        if (!isContains) {
          _offsets.add(Offset(0, ((_layers.length + 1) * 65).toDouble()));
        }

        if (i != _layersInfo.length - 1) {
          color = UniqueCheckLayer.getColor();
        }

        UniqueCheckLayer layer = UniqueCheckLayer(
            _offsets[_layersInfo[i].getPosition()],
            color,
            isCloseButtonEnable,
            (offset) {
              Offset newOffset = Offset(0, _offsets[_layersInfo[i].getPosition()].dy + offset.dy);

              setState(() {
                if (_offsets.length < 2 && newOffset.dy >= 65 && newOffset.dy <= MediaQuery.of(context).copyWith().size.height - 157) {
                  _offsets[_layersInfo[i].getPosition()] = newOffset;
                } else if (_offsets.length >= 2 && newOffset.dy >= 65 && !isOffsetOutOfBounds(_layersInfo[i].getPosition(), newOffset) && newOffset.dy <= MediaQuery.of(context).copyWith().size.height - 157) {
                  _offsets[_layersInfo[i].getPosition()] = newOffset;
                }
              });
            },
            () {
              setState(() {
                deleteLayer(_layersInfo[i].getPosition());
                updateFloatingActionButtons();
              });
            }
        );

        _layers.add(layer);
      } else if (_layersInfo[i].getName() == 'UniqueText') {
        for (int j = 0; j < _offsets.length; j++) {
          if (j == _layersInfo[i].getPosition()) {
            isContains = true;
          }
        }

        if (!isContains) {
          _offsets.add(Offset(0, ((_layers.length + 1) * 65).toDouble()));
        }

        if (i != _layersInfo.length - 1) {
          color = UniqueTextLayer.getColor();
        }

        _layers.add(UniqueTextLayer(
          _offsets[_layersInfo[i].getPosition()],
          color,
          isCloseButtonEnable,
          (offset) {
            Offset newOffset = Offset(0, _offsets[_layersInfo[i].getPosition()].dy + offset.dy);

            setState(() {
              if (_offsets.length < 2 && newOffset.dy >= 65 && newOffset.dy <= MediaQuery.of(context).copyWith().size.height - 157) {
                _offsets[_layersInfo[i].getPosition()] = newOffset;
              } else if (_offsets.length >= 2 && newOffset.dy >= 65 && !isOffsetOutOfBounds(_layersInfo[i].getPosition(), newOffset) && newOffset.dy <= MediaQuery.of(context).copyWith().size.height - 157) {
                _offsets[_layersInfo[i].getPosition()] = newOffset;
              }
            });
          },
          () {
            setState(() {
              deleteLayer(_layersInfo[i].getPosition());
              updateFloatingActionButtons();
            });
          }
        )
      );
      }
    }
  }

  bool isOffsetOutOfBounds(int position, Offset offset) {
    for (int i = position - 1; i >= 0; i--) {
      if (offset.dy <= _offsets[i].dy + 65) {
        return true;
      }
    }

    for (int i = position + 1; i < _offsets.length; i++) {
      if (offset.dy >= _offsets[i].dy - 65) {
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
                position = element.getPosition();
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
