import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animations/loading_animations.dart';

class LoadingCase extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: HexColor('#262626'),
      content: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 1.8,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoadingBouncingGrid.square(
                size: 100,
                backgroundColor: Colors.blue,
              ),
              SizedBox(
                height: 40,
              ),
              Text('Пожалуйста подождите.', style: TextStyle(color: Colors.white),),
              SizedBox(
                height: 15,
              ),
              Text('Среднее время ожидания: 10 секунд', style: TextStyle(color: Colors.white, fontSize: 15),),
            ],
          ),
        ),
      )
    );
  }
}