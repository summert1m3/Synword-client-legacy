import 'package:flutter/material.dart';
import 'package:synword/Widgets/bodyLayer.dart';
import 'package:synword/Widgets/layerTextForm.dart';
import 'package:synword/Widgets/layerTitle.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  List<Offset> offsets = [Offset(0, 0), Offset(0, 65), Offset(0, 130)];
  bool isSecondLayerVisible = true;
  bool isThirdLayerVisible = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: BodyLayer(
              Expanded(child: LayerTextForm()),
              LayerTitle(
                Text('Original text', style: TextStyle(fontSize: 25, fontFamily: 'Audrey', fontWeight: FontWeight.bold, color: Colors.white)),
                Colors.red,
                true,
                false,
                false,
                null,
                null
              )
          ),
        ),
        Positioned(
          top: offsets[1].dy,
          child: Visibility(
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
                Colors.yellow,
                true,
                true,
                true,
                (Offset offset) {
                  setState(() {
                    if (isThirdLayerVisible == true && offsets[1].dy + offset.dy >= offsets[0].dy + 65 && offsets[1].dy + offset.dy <= offsets[2].dy - 65) {
                    offsets[1] = Offset(offsets[1].dx, offsets[1].dy + offset.dy);
                    } else if (isThirdLayerVisible == false && offsets[1].dy + offset.dy >= offsets[0].dy + 65 && offsets[1].dy + offset.dy <= MediaQuery.of(context).copyWith().size.height - 157) {
                    offsets[1] = Offset(offsets[1].dx, offsets[1].dy + offset.dy);
                    }
                  });
                },
                () {
                  setState(() {
                    isSecondLayerVisible = false;
                  });
                }
            )
          ),
          visible: isSecondLayerVisible,
        ),
        ),
        Positioned(
            top: offsets[2].dy,
            child: Visibility(
              child: BodyLayer(
                  SizedBox(
                      child: Container(
                        margin: EdgeInsets.all(10),
                          child: Text('Под инкапсуляцией понимается скрытие полей объекта с целью обеспечения доступа к ним только посредством методов класса. В языке Delphi ограничение доступа к полям объекта реализуется при помощи свойств объекта.',
                            style: TextStyle(fontSize: 20, fontFamily: 'Audrey'),
                          ),
                      ),
                      width: MediaQuery.of(context).copyWith().size.width - 20,
                      height: MediaQuery.of(context).copyWith().size.height
                  ),
                  LayerTitle(
                    Text('Unique check', style: TextStyle(fontSize: 25, fontFamily: 'Audrey', fontWeight: FontWeight.bold, color: Colors.black)),
                    Colors.green,
                    true,
                    true,
                    true,
                    (Offset offset) {
                      setState(() {
                        if (isSecondLayerVisible == true && offsets[2].dy + offset.dy >= offsets[1].dy + 65 && offsets[2].dy + offset.dy <= MediaQuery.of(context).copyWith().size.height - 157) {
                          offsets[2] = Offset(offsets[2].dx, offsets[2].dy + offset.dy);
                        } else if (isSecondLayerVisible == false && offsets[2].dy + offset.dy >= offsets[0].dy + 65 && offsets[2].dy + offset.dy <= MediaQuery.of(context).copyWith().size.height - 157) {
                          offsets[2] = Offset(offsets[2].dx, offsets[2].dy + offset.dy);
                        }
                      });
                    },
                    () {
                      setState(() {
                        isThirdLayerVisible = false;
                      });
                    }
                  )
              ),
              visible: isThirdLayerVisible,
            )
        ),
      ],
    );
  }
}
