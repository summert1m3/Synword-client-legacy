import 'package:flutter/material.dart';
import 'package:synword/widgets/waveBar.dart';
import 'package:synword/widgets/uniqueCheckLinks.dart';
import 'package:synword/layersSetting.dart';

class TwoTextUniqueCheckWidget extends StatelessWidget {
  final Offset _offset;
  final double _originalProgress;
  final double _uniqueProgress;
  final double _dividerHeight = 30;
  final double _paddingTop = 5;

  TwoTextUniqueCheckWidget(
    this._offset,
    this._originalProgress,
    this._uniqueProgress,
  );

  double _getUniqueCheckLinksHeight(BuildContext context) {
    double height = (MediaQuery.of(context).copyWith().size.height - 127) - (_offset.dy + TitleHeight + WaveBarHeight + _dividerHeight / 2 + _paddingTop);

    if (height < 0) {
      height = 0;
    }

    return height;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: _paddingTop),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    WaveBar(_originalProgress),
                    Container(
                      height: 35,
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        'Original',
                        style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'Audrey', fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    WaveBar(_uniqueProgress),
                    Container(
                      height: 35,
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        'Unique',
                        style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'Audrey', fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
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
