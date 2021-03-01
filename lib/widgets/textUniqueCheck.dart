import 'package:flutter/material.dart';
import 'package:synword/layers/layersSetting.dart';
import 'package:synword/model/json/uniqueCheckData.dart';
import 'package:synword/widgets/waveBar.dart';
import 'package:synword/widgets/uniqueCheckLinks.dart';

class TextUniqueCheck extends StatelessWidget {
  final UniqueCheckData _uniqueCheckData;
  final Offset _offset;
  final double _dividerHeight = 30;

  TextUniqueCheck(
    this._uniqueCheckData,
    this._offset,
  );

  double _getUniqueCheckLinksHeight(BuildContext context) {
    double height = (MediaQuery.of(context).copyWith().size.height - MediaQuery.of(context).copyWith().size.height / 4.6) - (_offset.dy + layersSetting.titleHeight + layersSetting.waveBarHeight - _dividerHeight / 2);

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
            _uniqueCheckData.percent / 100
          ),
          Divider(
            color: Colors.grey,
            height: _dividerHeight,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          UniqueCheckLinks(
              _uniqueCheckData,
              _getUniqueCheckLinksHeight(context)
          )
        ],
      ),
      width: MediaQuery.of(context).copyWith().size.width - 20,
      height: MediaQuery.of(context).copyWith().size.height
    );
  }
}
