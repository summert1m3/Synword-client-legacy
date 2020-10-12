import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class UploadFileUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UploadFileUIState();
}

class _UploadFileUIState extends State<UploadFileUI> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Hexcolor('#262626'),
      content: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 2.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              IconButton(
                iconSize: 100,
                tooltip: 'Upload file',
                icon: SvgPicture.asset(
                  'icons/upload_file_button.svg',
                  semanticsLabel: 'Upload file',
                ),
                onPressed: () {

                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Supported files: docx, pdf',
                style: TextStyle(color: Colors.white, fontFamily: 'Audrey', fontSize: 18),
              ),
            ],
          ),
      ),
    );
  }
}