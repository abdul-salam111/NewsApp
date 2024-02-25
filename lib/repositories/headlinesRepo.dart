import 'dart:typed_data';

import 'package:newsapp/Data/network/baseApiServices.dart';
import 'package:newsapp/Data/network/networkApiServices.dart';
import 'package:newsapp/models/headlinesModel.dart';
import 'package:newsapp/res/apiKeys.dart';

class HeadlinesRepository {
  BaseApiServices apiServices = NetworkApiService();

  Future<HeadlinesModel> getNewsHeadliens(String channelName) async {
    try {
      dynamic response = await apiServices.getResponse(
          "https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=b2de24d650864d8aa48c9ddf3cbf17e6");

      return HeadlinesModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<HeadlinesModel> getCategoryNews(String categoryName) async {
    try {
      dynamic response = await apiServices.getResponse(
          "https://newsapi.org/v2/everything?q=$categoryName&apiKey=b2de24d650864d8aa48c9ddf3cbf17e6");

      return HeadlinesModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
