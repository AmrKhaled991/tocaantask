import 'package:dio/dio.dart';

class ApiServices {
  static const url = "https://fakestoreapi.com/products";

  ApiServices(this.dio);
  Dio dio;

}
