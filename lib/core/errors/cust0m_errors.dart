import 'package:dio/dio.dart';

abstract class Failure {
  String message;
  Failure(this.message);
}

class ServerError extends Failure {
  ServerError(super.message);
  factory ServerError.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerError('sorry connectionTimeout,try again later');
      case DioExceptionType.sendTimeout:
        return ServerError('sorry sendTimeout,try again later');
      case DioExceptionType.receiveTimeout:
        return ServerError('sorry receiveTimeout,try again later');
      case DioExceptionType.badCertificate:
        return ServerError('sorry badCertificate,try again later');
      case DioExceptionType.badResponse:
        return ServerError.BadResponse(
          dioException.response!.statusCode!,
          dioException.response,
        );
      case DioExceptionType.cancel:
        return ServerError('sorry cancel requste,try again later');
      case DioExceptionType.connectionError:
        return ServerError('Please check your internet connection');
      case DioExceptionType.unknown:
        if (dioException.message!.contains('SocketException')) {
          return ServerError('no internet conection');
        } else {
          return ServerError('unexpected error,plz try again later');
        }
      default:
        return ServerError('Ops somthing went wronge ,plz try agein later');
    }
  }
  factory ServerError.BadResponse(int status, dynamic response) {
    if (status == 401 || status == 403) {
      return ServerError('error');
    } else if (status == 404) {
      return ServerError('Ruqste not found');
    } else if (status == 400)
      return ServerError('Please Search for another city');
    else
      return ServerError('Ops somthing went wronge ,plz try agein later');
  }
}
