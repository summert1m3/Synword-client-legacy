import 'package:synword/uniqueUpData.dart';

abstract class Synonymizer {
  Future<UniqueUpData> synonymize(String text);
}