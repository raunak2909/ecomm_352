import 'dart:convert';
import 'dart:io';

import 'package:ecomm_352/data/remote/helper/app_exception.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {
  Future<dynamic> getAPI({
    required String url,
    Map<String, String>? mHeaders,
    bool isAuth = false,
  }) async{

    if (!isAuth) {
      ///getting token from prefs
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      mHeaders ??= {};
      mHeaders["Authorization"] = "Bearer $token";
    }

    try{
      var res = await http.get(
        Uri.parse(url),
        headers: mHeaders,
      );

      print(res.body);

      return returnResponse(res);

    } on SocketException catch (e){
      throw NoInternetException(errorMessage: e.toString());
    }

  }

  Future<dynamic> postAPI({
    required String url,
    Map<String, dynamic>? params,
    Map<String, String>? mHeaders,
    bool isAuth = false,
  }) async{
    if (!isAuth) {
      ///getting token from prefs
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      mHeaders ??= {};
      mHeaders["Authorization"] = "Bearer $token";
    }

    try{
      var res = await http.post(
        Uri.parse(url),
        body: params != null ? jsonEncode(params) : null,
        headers: mHeaders,
      );

      print(res.body);

      return returnResponse(res);

    } on SocketException catch (e){
      throw NoInternetException(errorMessage: e.toString());
    }
  }

  dynamic returnResponse(http.Response response){

    switch(response.statusCode){
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(errorMessage: response.body);
      case 401:
      case 403:
        throw UnauthorisedException(errorMessage: response.body);
      case 500:
      default:
        throw FetchDataException(errorMessage: response.body);
    }

  }



}
