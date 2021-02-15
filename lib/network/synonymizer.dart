import 'package:synword/model/json/uniqueUpData.dart';

abstract class Synonymizer {
  Future<UniqueUpData> synonymize(String text);
}
