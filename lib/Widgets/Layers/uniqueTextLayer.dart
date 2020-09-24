import 'package:flutter/material.dart';
import 'package:synword/Widgets/bodyLayer.dart';
import 'package:synword/Widgets/layerTitle.dart';

class UniqueTextLayer extends StatelessWidget {
  final Offset _offset;
  final GestureDetectorCallback _gestureDetectorCallback;
  final CloseButtonCallback _closeButtonCallback;
  final bool _isCloseButtonEnable;

  UniqueTextLayer(
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
                child: Text('Исторически сложилось так, что программирование возникло и развивалось как процедурное программирование. В школьных курсах информатики рассматриваются традиционные процедурно-ориентированные языки программирования.',
                  style: TextStyle(fontSize: 20, fontFamily: 'Audrey'),
                ),
              ),
              width: MediaQuery.of(context).copyWith().size.width - 20,
              height: MediaQuery.of(context).copyWith().size.height
          ),
          LayerTitle(
              Text('Unique text', style: TextStyle(fontSize: 25, fontFamily: 'Audrey', fontWeight: FontWeight.bold, color: Colors.black)),
              Colors.yellow,
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
