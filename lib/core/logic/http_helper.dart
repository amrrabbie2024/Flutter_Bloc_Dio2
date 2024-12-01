

import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpHelper{
  //static final client = http.Client();

  Future<dynamic> post(
      {required String url,
      Map<String, dynamic>? body,
      Map<String, String>? headers}) async {

      http.Response response = await http.post(
          Uri.parse('https://fakestoreapi.com/$url'),
          body: body,
        headers: headers
      );

      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else{
        throw Exception("There is an error ${response.statusCode}");
      }

  }

  Future<dynamic> put(
      {required String url,
        Map<String, dynamic>? body,
        Map<String, String>? headers}) async {

    http.Response response = await http.put(
        Uri.parse('https://fakestoreapi.com/$url'),
        body: body,
        headers: headers
    );

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception("There is an error ${response.statusCode}");
    }

  }

  Future<dynamic> patch(
      {required String url,
        Map<String, dynamic>? body,
        Map<String, String>? headers}) async {

    http.Response response = await http.patch(
        Uri.parse('https://fakestoreapi.com/$url'),
        body: body,
        headers: headers
    );

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception("There is an error ${response.statusCode}");
    }

  }

  Future<dynamic> delete(
      {required String url,
        Map<String, dynamic>? body,
        Map<String, String>? headers}) async {

    http.Response response = await http.delete(
        Uri.parse('https://fakestoreapi.com/$url'),
        body: body,
        headers: headers
    );

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception("There is an error ${response.statusCode}");
    }

  }

   Future<dynamic> get(
      {required String url,
      Map<String, dynamic>? body,
      Map<String, String>? headers}) async {

      http.Response response = await http.get(
          Uri.parse('https://fakestoreapi.com/$url'),
          //body: body,
          headers: headers
      );

      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else{
        throw Exception("There is an error ${response.statusCode}");
      }
  }
}