import 'package:synword/constants/defaultUserRestrictions.dart';
import 'package:easy_localization/easy_localization.dart';

class MinSymbolLimitException implements Exception {
  MinSymbolLimitException([this.symbolCount]);

  static final String message = "minSymbolLimit";

  int? symbolCount;
  String symbolCountMessage = 'symbolCountMessage'.tr();
  int symbolLimit = DefaultUserRestrictions.minSymbolLimit;
  String symbolLimitMessage = 'symbolLimitMessage'.tr();

  @override
  String toString() => message;
}