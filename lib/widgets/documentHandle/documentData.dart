import 'package:file_picker/file_picker.dart';

class DocumentData{
  FilePickerResult file;
  bool uniqueUp = false;
  bool uniqueCheck = false;

  void reset(){
    file = null;
    uniqueUp = false;
    uniqueCheck = false;
  }

}

final DocumentData docData = DocumentData();