import 'package:flutter/material.dart';
import 'package:synword/widgets/waveBar.dart';
import 'package:synword/widgets/uniqueCheckLinks.dart';
import 'package:synword/layersSetting.dart';

class TextUniqueCheck extends StatelessWidget {
  final Offset _offset;
  final double _progress;
  final double _dividerHeight = 30;

  TextUniqueCheck(
    this._offset,
    this._progress
  );

  double _getUniqueCheckLinksHeight(BuildContext context) {
    double height = (MediaQuery.of(context).copyWith().size.height - 127) - (_offset.dy + TitleHeight + WaveBarHeight - _dividerHeight / 2);

    if (height < 0) {
      height = 0;
    }

    return height;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          WaveBar(
              _progress
          ),
          Divider(
            color: Colors.grey,
            height: _dividerHeight,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          UniqueCheckLinks(_getUniqueCheckLinksHeight(context))
        ],
      ),
    );
  }
}
