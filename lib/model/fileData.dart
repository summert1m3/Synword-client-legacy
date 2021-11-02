import 'dart:typed_data';

class FileData {
  FileData(this.name, this.bytes);

  String name;
  Uint8List bytes;
}