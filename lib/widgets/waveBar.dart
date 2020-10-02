import 'package:flutter/material.dart';
import 'package:synword/widgets/waveBall.dart';

class WaveBar extends StatelessWidget {
  final double _progress;

  WaveBar(
    this._progress
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(width: 0.8)
      ),
      child: Center(
        child: WaveBall(
          size: 130,
          circleColor: Colors.white,
          progress: _progress,
          child: Center(
            child: Text(
              (_progress * 100).toString(),
              style: TextStyle(color: Colors.black, fontSize: 27, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
