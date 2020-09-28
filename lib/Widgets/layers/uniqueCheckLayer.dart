import 'package:flutter/material.dart';
import 'package:synword/widgets/bodyLayer.dart';
import 'package:synword/widgets/layerTitle.dart';

class UniqueCheckLayer extends StatelessWidget {
  final Offset _offset;
  final Color _titleColor;
  final GestureDetectorCallback _gestureDetectorCallback;
  final CloseButtonCallback _closeButtonCallback;
  final bool _isCloseButtonEnable;

  UniqueCheckLayer(
      this._offset,
      this._titleColor,
      this._isCloseButtonEnable,
      this._gestureDetectorCallback,
      this._closeButtonCallback
  );

  static Color getColor() {
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _offset.dy,
      child: BodyLayer(
          SizedBox(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Text('Под инкапсуляцией понимается скрытие полей объекта с целью обеспечения доступа к ним только посредством методов класса. В языке Delphi ограничение доступа к полям объекта реализуется при помощи свойств объекта.',
                  style: TextStyle(fontSize: 20, fontFamily: 'Audrey'),
                ),
              ),
              width: MediaQuery.of(context).copyWith().size.width - 20,
              height: MediaQuery.of(context).copyWith().size.height
          ),
          LayerTitle(
              Text('Unique check', style: TextStyle(fontSize: 25, fontFamily: 'Audrey', fontWeight: FontWeight.bold, color: Colors.black)),
              _titleColor,
              Colors.black.withOpacity(0.2),
              _isCloseButtonEnable,
              _closeButtonCallback
          ),
          true,
          true,
          _gestureDetectorCallback
      ),
    );
  }
}
