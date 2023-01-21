//*ADAPTER PER API li uso qui
import 'dart:convert';

import 'package:advicer/0_data/models/advice_model.dart';
import 'package:http/http.dart' as http;

abstract class AdviceRemoteDataSource {
  //*RESTITUISCE UN DTO (MODEL)
  /// requests a random advice from api
  /// returns [AdivceModel] if successfull
  /// throws a ServerException if status code is not 200
  Future<AdviceModel> getRandomAdviceFromApi();
}

class AdviceRemoteDataSourceImpl implements AdviceRemoteDataSource {
  final client = http.Client(); //client da usare
  @override
  Future<AdviceModel> getRandomAdviceFromApi() async {
    final response = await client.get(
        Uri.parse(
          "https://api.flutter-community.com/api/v1/advice",
        ),
        headers: {
          //*additional info (API KEY etc content-type )
          'content-type': 'application/json'
        });
    final responseBody = json.decode(response.body); //*in json format
    return AdviceModel.fromJson(responseBody);
  }
}
