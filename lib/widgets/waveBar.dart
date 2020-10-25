import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:synword/widgets/waveBall.dart';
import 'package:synword/layersSetting.dart';

class WaveBar extends StatelessWidget {
  final double _progress;

  WaveBar(
    this._progress
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: WaveBarWidth,
      height: WaveBarHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(width: 0.8)
      ),
      child: Center(
        child: WaveBall(
          size: 130,
          circleColor: Colors.white,
          foregroundColor: HexColor("#008FFF"),
          backgroundColor: HexColor("#6FC0FF"),
          progress: _progress,
          range: 8,
          child: Center(
            child: Text(
              (_progress * 100).toInt().toString(),
              style: TextStyle(color: Colors.black, fontSize: 27, fontWeight: FontWeight.bold, fontFamily: 'Audrey'),
            ),
          ),
        ),
      ),
    );
  }
}
