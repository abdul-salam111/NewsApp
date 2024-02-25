import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Data/response/response.dart';
import 'package:newsapp/models/headlinesModel.dart';
import 'package:newsapp/repositories/headlinesRepo.dart';

class HomeViewModel with ChangeNotifier {
  HeadlinesRepository headlinesRepo = HeadlinesRepository();

  ApiResponse<HeadlinesModel> headlinesNews = ApiResponse.loading();
  setHeadlinesList(ApiResponse<HeadlinesModel> response) {
    headlinesNews = response;
    notifyListeners();
  }

  void getHeadlineNews(String channelName) {
    setHeadlinesList(ApiResponse.loading());
    headlinesRepo.getNewsHeadliens(channelName).then((value) {
      setHeadlinesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setHeadlinesList(ApiResponse.error(error.toString())));
  }

  ApiResponse<HeadlinesModel> categoryNews = ApiResponse.loading();
  setcategoryNewsList(ApiResponse<HeadlinesModel> response) {
    categoryNews = response;
    notifyListeners();
  }

  void getcategoryNews(String categoryName) {
    setcategoryNewsList(ApiResponse.loading());
    headlinesRepo.getCategoryNews(categoryName).then((value) {
      setcategoryNewsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) =>
        setcategoryNewsList(ApiResponse.error(error.toString())));
  }
}
