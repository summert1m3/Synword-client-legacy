import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:synword/layers/layersSetting.dart';

class LoadingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        child: Center(
          child: LoadingBouncingGrid.square(size: 70),
        ),
      ),
      height: (MediaQuery.of(context).copyWith().size.height - 167) - layersSetting.titleHeight,
    );
  }
}
