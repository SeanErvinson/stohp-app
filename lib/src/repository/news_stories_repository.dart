import 'dart:convert';

import 'package:stohp/src/models/article.dart';
import 'package:http/http.dart' as http;
import 'package:stohp/src/services/api_service.dart';

class NewsStoriesRepository {
  Future<List<Article>> fetchArticles({int limit = 5}) async {
    String url = "${ApiService.baseUrl}/api/v1/news-stories/";
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      Iterable results = jsonData["results"];
      List<Article> articles =
          results.map((model) => Article.fromJson(model)).toList();
      return articles;
    }
    return null;
  }

  Future<Article> fetchArticle(String slug) async {
    String url = "${ApiService.baseUrl}/api/v1/news-stories/$slug";
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var article = Article.fromJson(jsonData);
      return article;
    }
    return null;
  }
}
