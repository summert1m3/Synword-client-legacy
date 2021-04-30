import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:synword/exceptions/badRequestException.dart';
import 'package:synword/exceptions/maxSymbolLimitException.dart';
import 'package:synword/exceptions/minSymbolLimitException.dart';
import 'package:synword/exceptions/notEnoughCoinsException.dart';
import 'package:synword/exceptions/serverUnavailableException.dart';

class DetermineExceptionType {
  static dynamic determine(DioError ex){
    if (ex.type != DioErrorType.response) {
      return ServerUnavailableException();
    }
    String responseString;
    if(ex.requestOptions.responseType == ResponseType.bytes){
      AsciiDecoder bytesDecoder = AsciiDecoder();
      responseString = bytesDecoder.convert(ex.response!.data);
    } else {
      responseString = ex.response!.data.toString();
    }

    Map<String, dynamic> responseJson = jsonDecode(responseString);

    String responseError = responseJson['message'] as String;
    if (responseError == NotEnoughCoinsException.message) {
      return NotEnoughCoinsException();
    } else if(responseError == MaxSymbolLimitException.message){
      int? symbolCount = responseJson['symbolCount'] as int;
      return MaxSymbolLimitException(symbolCount);
    } else if(responseError == MinSymbolLimitException.message){
      int? symbolCount = responseJson['symbolCount'] as int;
      return MinSymbolLimitException(symbolCount);
    } else {
      return BadRequestException(ex.response!.data.toString());
    }
  }
}