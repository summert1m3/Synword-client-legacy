import 'package:easy_localization/easy_localization.dart';

class MinSymbolLimitException implements Exception {
  MinSymbolLimitException(this.symbolCount, this.symbolLimit);

  static final String message = "minSymbolLimit";

  int symbolCount;
  int symbolLimit;
  String symbolCountMessage = 'symbolCountMessage'.tr();
  String symbolLimitMessage = 'symbolLimitMessage'.tr();

  @override
  String toString() => message;
}