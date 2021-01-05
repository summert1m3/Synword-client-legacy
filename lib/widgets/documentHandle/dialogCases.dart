import 'package:dio/dio.dart';

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:synword/widgets/documentHandle/documentData.dart';

void docUniqueUpRequest() async {
  Dio dio = Dio();
  var downloadDirectory = await getExternalStorageDirectory();

  FormData formData = new FormData.fromMap({
    "files": new MultipartFile.fromBytes(
        docData.file.files.first.bytes.toList(),
        filename: docData.file.names.first),
  });
  Response response = await dio.post("http://194.87.146.123/api/fileupload",
      //data: formData,
      options: Options(
        responseType: ResponseType.bytes,
      ));

  File file = File(
    join(downloadDirectory.path, docData.file.names.first),
  );
  file.writeAsBytesSync(response.data);
}
