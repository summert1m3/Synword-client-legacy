import 'package:synword/constants/defaultUserRestrictions.dart';
import 'package:easy_localization/easy_localization.dart';

class MaxSymbolLimitException implements Exception {
  MaxSymbolLimitException([this.symbolCount]);

  static final String message = "maxSymbolLimit";

  int? symbolCount;
  String symbolCountMessage = 'symbolCountMessage'.tr();
  int symbolLimit = DefaultUserRestrictions.maxSymbolLimit;
  String symbolLimitMessage = 'symbolLimitMessage'.tr();

  @override
  String toString() => message;
}