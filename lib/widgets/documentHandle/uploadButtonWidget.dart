import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synword/widgets/documentHandle/cases/startCase.dart';
import 'package:synword/widgets/documentHandle/cases/choiceCase.dart';
import 'package:synword/widgets/documentHandle/dialogState.dart';
import 'package:synword/widgets/documentHandle/documentHandlerData.dart';
import 'cases/errorCase.dart';
import 'cases/loading.dart';
import 'package:synword/widgets/documentHandle/cases/results/resultCase.dart';

class UploadFileUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UploadFileUIState();
}

class _UploadFileUIState extends State<UploadFileUI> {
  DialogState _state = DialogState.start;

  @override
  Widget build(BuildContext context) {
    var updateMainState = (DialogState state) {
      setState(() {
        this._state = state;
      });
    };
    return Provider(
      create: (_) => DocumentHandlerData(updateMainState),
      child: dialogChoice(_state),
    );
  }
}

Widget dialogChoice(DialogState state) {
  switch (state) {
    case DialogState.start:
      return StartCase();
    case DialogState.choice:
      return ChoiceCase();
    case DialogState.loading:
      return LoadingCase();
    case DialogState.finish:
      return ResultCase();
    case DialogState.error:
      return ErrorCase();
    default:
      return ErrorCase();
  }
}
