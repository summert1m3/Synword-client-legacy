import 'package:easy_localization/easy_localization.dart';

class MaxSymbolLimitException implements Exception {
  MaxSymbolLimitException(this.symbolCount, this.symbolLimit);

  static final String message = "maxSymbolLimit";

  int symbolCount;
  int symbolLimit;
  String symbolCountMessage = 'symbolCountMessage'.tr();
  String symbolLimitMessage = 'symbolLimitMessage'.tr();

  @override
  String toString() => message;
}