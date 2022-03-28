import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pixbit/src/models/response_data.dart';
import 'package:pixbit/src/models/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class Api {
  Dio dio = Dio();

  // Default constructor
  Api({String? token}) {
    // this.user = user;
    BaseOptions options = BaseOptions(baseUrl: SERVER_ADDRESS_API, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });
    dio = Dio(options);
  }

  Future post(url, {required data}) async {
    try {
      Response response = await dio.post(url, data: data);
      log(response.data.toString());
      return response;
    } catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e is DioError) {
        log(e.message);
        //print(e.response.headers);
        ////print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        ////print(e.request);
        log(e.toString());
      }
    }
  }

  Future get(url, {queryParameters}) async {
    try {
      Response response = await dio.get(url, queryParameters: queryParameters);
      log(response.data.toString());
      return response;
    } on DioError catch (e) {
      log(e.message);
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        //print(e.response.data);
        //print(e.response.headers);
        ////print(e.response.request);
      } else {
        log(e.message);
        // Something happened in setting up or sending the request that triggered an Error
        //print(e.request);
        // print(e.message);
      }
    }
  }

  Future<LoginData> login(String email, String password) async {
    Response r = await post('login', data: {
      'email': email,
      'password': password,
    });
    return LoginData.fromJson(r.data);
  }

  Future<Users> users() async {
    Response r = await get('employees');
    return Users.fromJson(r.data);
  }
}

Api pixBitAPI = Api();
