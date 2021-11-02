import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:synword/widgets/waveBall.dart';

class WaveBar extends StatelessWidget {
  final double _progress;

  WaveBar(
    this._progress
  );

  List<Color> _getColors() {
    List<Color> colors = <Color>[];

    if (_progress < 0.2) {
      colors.add(HexColor("#ff0000"));
      colors.add(HexColor("#ff4848"));
    } else if (_progress >= 0.2 && _progress < 0.4) {
      colors.add(HexColor("#ff5757"));
      colors.add(HexColor("#ff9292"));
    } else if (_progress >= 0.4 && _progress < 0.6) {
      colors.add(HexColor("#fff600"));
      colors.add(HexColor("#fdfaa4"));
    } else if (_progress >= 0.6 && _progress < 0.8) {
      colors.add(HexColor("#62ff4d"));
      colors.add(HexColor("#92fc83"));
    } else {
      colors.add(HexColor("#1eff00"));
      colors.add(HexColor("#7bff69"));
    }

    return colors;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    List<Color> colors = _getColors();

    return Container(
      width: (screenSize.width + screenSize.height) / 8.5,
      height: (screenSize.width + screenSize.height) / 8.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(width: 0.8)
      ),
      child: Center(
        child: WaveBall(
          size: (screenSize.width + screenSize.height) / 8.5,
          circleColor: Colors.white,
          foregroundColor: colors[0],
          backgroundColor: colors[1],
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
