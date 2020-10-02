import 'package:flutter/material.dart';
import 'package:synword/widgets/waveBar.dart';
import 'package:synword/widgets/uniqueCheckLinks.dart';

class TwoTextUniqueCheckWidget extends StatelessWidget {
  final double _originalProgress;
  final double _uniqueProgress;

  TwoTextUniqueCheckWidget(
    this._originalProgress,
    this._uniqueProgress
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
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
            height: 30,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          UniqueCheckLinks()
        ],
      ),
    );
  }
}
