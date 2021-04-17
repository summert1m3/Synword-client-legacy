import 'package:dio/dio.dart';
import 'package:synword/exceptions/badRequestException.dart';
import 'package:synword/exceptions/notEnoughCoinsException.dart';
import 'package:synword/exceptions/serverUnavailableException.dart';

class DetermineExceptionType {
  static dynamic determine(DioError ex){
    if (ex.type != DioErrorType.response) {
      return ServerUnavailableException();
    }
    if (ex.response!.data.toString() == NotEnoughCoinsException.message) {
      return NotEnoughCoinsException();
    } else {
      return BadRequestException(ex.response!.data.toString());
    }
  }
}