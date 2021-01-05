import 'package:flutter/material.dart';
import 'package:synword/widgets/documentHandle/cases/startCase.dart';
import 'package:synword/widgets/documentHandle/cases/choiceCase.dart';
import 'package:synword/widgets/documentHandle/dialogState.dart';
import 'cases/loading.dart';
import 'package:synword/widgets/documentHandle/cases/results/resultCase.dart';


class UploadFileUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UploadFileUIState();
}

class _UploadFileUIState extends State<UploadFileUI> {
  DialogState _state;

  @override
  void initState(){
    super.initState();
    _state = DialogState.start;
  }

  @override
  Widget build(BuildContext context) {
    return dialogChoice(_state,
          ({DialogState state}) {
      setState(() {
        this._state = state;
      });
    },
    );
  }
}

Widget dialogChoice(DialogState state,Function setStateCallback){
  switch(state){
    case DialogState.start: return StartCase(setStateCallback);break;
    case DialogState.choice: return ChoiceCase(setStateCallback);break;
    case DialogState.loading: return LoadingCase();break;
    case DialogState.finish: return ResultCase();break;
    //TODO: throw exception
    default: return null;
  }
}

