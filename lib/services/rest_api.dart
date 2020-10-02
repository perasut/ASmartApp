import 'dart:convert';

import 'package:ASmartApp/models/BaacTimeDetailModel.dart';
import 'package:ASmartApp/models/NewsModel.dart';
import 'package:ASmartApp/models/TimeDetailModel.dart';
import 'package:ASmartApp/models/RegisterModel.dart';
import 'package:http/http.dart' as http;

class CallAPI {

  _setHeaders() => {
    'Content-Type':'application/json',
    'Accept': 'application/json'
  };

  _setBAACHeaders() => {
    'Content-Type':'application/x-www-form-urlencoded',
    'Accept': 'application/json'
  };
  
  final String baseAPIURL = 'https://www.itgenius.co.th/sandbox_api/baacstaffapi/public/api/';
  final String baseAPIURLBAAC = 'https://dinodev.baac.or.th/wsBEM/';
  final String baseURLBAACV2 = 'https://dinodev.baac.or.th/wsBEMV2/';

  // Register API
  postData(data, apiURL) async {
    var fullURL = baseAPIURL + apiURL;
    return await http.post(
      fullURL,
      body: jsonEncode(data),
      headers: _setHeaders()
    );
  }

  // Read Employee Detail
  Future<RegisterModel> getEmployee(data) async {
      final response = await http.post(
        baseAPIURL+'register', 
        body: jsonEncode(data),
        headers: _setHeaders()
      );
      if(response.statusCode == 200){
        return registerModelFromJson(response.body);
      }else{
        return null;
      }
  }

  // Read News
  Future<List<NewsModel>> getNews() async{
    final response = await http.get(
      baseAPIURL+'news',
      headers: _setHeaders()
    );
    if(response.body != null){
      return newsModelFromJson(response.body);
    }else{
      return null;
    }
  }

  // CheckIn/Out working time
  checkInAndOut(data, apiURL) async{
    var fullURL = baseAPIURLBAAC + apiURL;
    return await http.post(
      fullURL,
      body: data,
      headers: _setBAACHeaders(),
      encoding: Encoding.getByName("utf-8")
    );
  }

  // Read Time Datail
  Future<List<TimeDetailModel>> getTimeDetail() async{
    final response = await http.get(
      baseAPIURL+'timeDetail',
      headers: _setHeaders()
    );
    if(response.body != null){
      return timeDetailModelFromJson(response.body);
    }else{
      return null;
    }
  } 

  // BAAC Post Time Detail
  Future<List<BaacTimeDetailModel>> baacPostTimeDetail(data) async {

    final response = await http.post(
      baseURLBAACV2+'TimeDetail', 
      body: data,
      headers: _setBAACHeaders(),
      encoding: Encoding.getByName("utf-8")
    );
    if(response.statusCode == 200){
      return baacTimeDetailModelFromJson(response.body);
    }else{
      return null;
    }

  }

}