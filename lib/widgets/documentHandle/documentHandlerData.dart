import 'package:file_picker/file_picker.dart';
import 'package:synword/model/json/uniqueCheckData.dart';

import 'dialogState.dart';

class DocumentHandlerData {
  DocumentHandlerData(this.updateMainState);

  late FilePickerResult file;

  late bool uniqueUp = true;
  late bool uniqueCheck = false;

  late UniqueCheckData uniqueCheckData;

  final String downloadPath = "/storage/emulated/0/Download/";

  Function updateMainState;

  void updateState(DialogState state){
    updateMainState(state);
  }
}