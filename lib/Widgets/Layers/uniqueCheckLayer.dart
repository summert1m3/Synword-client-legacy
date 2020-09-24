import 'package:flutter/material.dart';
import 'package:synword/Widgets/bodyLayer.dart';
import 'package:synword/Widgets/layerTitle.dart';

class UniqueCheckLayer extends StatelessWidget {
  final Offset _offset;
  final GestureDetectorCallback _gestureDetectorCallback;
  final CloseButtonCallback _closeButtonCallback;
  final bool _isCloseButtonEnable;

  UniqueCheckLayer(
      this._offset,
      this._isCloseButtonEnable,
      this._gestureDetectorCallback,
      this._closeButtonCallback
  );

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
              Colors.green,
              true,
              _isCloseButtonEnable,
              true,
              _gestureDetectorCallback,
              _closeButtonCallback
          )
      ),
    );
  }
}
