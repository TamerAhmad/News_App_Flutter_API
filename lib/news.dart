import 'dart:convert';
import 'article.dart';
import 'package:http/http.dart' as http;

class News {
  List<Article> news = [];
  String apiKey = 'your api key here';
  String newsSource = 'top-headlines';

  Future<void> getNews() async {
    String url = 'https://newsapi.org/v2/$newsSource?country=us&apiKey=$apiKey';

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if(element['urlToImage'] != null){
          Article article = Article(
              title: element['title'],
              author: element['author'],
              urlToImage: element['urlToImage'],
              description: element['description'],
              publishedAt: DateTime.parse(element['publishedAt']),
              content: element['content']
          );
          news.add(article);
        }
      });
    }
  }
}
