import 'package:file_picker/file_picker.dart';
import 'package:synword/model/json/uniqueCheckData.dart';

import 'dialogState.dart';

class DocumentHandlerData {
  static late FilePickerResult file;

  static late bool uniqueUp = false;
  static late bool uniqueCheck = false;

  static late UniqueCheckData uniqueCheckData;

  static const String downloadPath = "/storage/emulated/0/Download/";

  static late Function state;

  static void updateState(DialogState state){
    DocumentHandlerData.state(state);
  }
}