import 'package:flutter/material.dart';
import 'package:synword/widgets/bodyLayer.dart';
import 'package:synword/widgets/layerTitle.dart';

class UniqueTextLayer extends StatelessWidget {
  final Offset _offset;
  final Color _titleColor;
  final GestureDetectorCallback _gestureDetectorCallback;
  final CloseButtonCallback _closeButtonCallback;
  final bool _isTitleVisible;
  final bool _isCloseButtonVisible;

  UniqueTextLayer(
      this._offset,
      this._titleColor,
      this._isTitleVisible,
      this._isCloseButtonVisible,
      this._gestureDetectorCallback,
      this._closeButtonCallback
  );

  static Color getColor() {
    return Colors.yellow;
  }

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
              _titleColor,
              Colors.black.withOpacity(0.2),
              _isTitleVisible,
              _isCloseButtonVisible,
              _closeButtonCallback,
          ),
          true,
          true,
          _gestureDetectorCallback
      ),
    );
  }
}
