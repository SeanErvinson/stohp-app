import 'package:stohp/src/models/article.dart';

class NewsStoriesRepository {
  List<Article> dummyArticles = [
    Article(
      id: "4",
      content: "Walang Pasok #walangpasok",
      title: "Walang Pasok #walangpasok",
      image:
          "https://newsinfo.inquirer.net/files/2016/08/Walang-Pasok-e1468162230394-620x391-620x391.jpg",
    ),
    Article(
      id: "1",
      content: "Heavy rainfall this afternoon",
      image:
          "https://hhsmedia.com/wp-content/uploads/2019/06/rain-3964186_960_720.jpg",
      title: "Heavy rainfall this afternoon",
    ),
    Article(
        id: "2",
        content: "Coronavirus death toll increases.",
        image:
            "https://upload.wikimedia.org/wikipedia/commons/7/78/Coronaviruses_004_lores.jpg",
        title: "Coronavirus death toll increases."),
    Article(
      id: "3",
      content: "Government warns of potential terrorist attacks",
      title: "Government warns of potential terrorist attacks",
      image:
          "https://cdn.cfr.org/sites/default/files/styles/article_header_l_16x9_600px/public/image/2018/02/Somalia-al-Shabaab-Africa-militant-terrorist.jpg",
    ),
  ];
  Future<List<Article>> fetchArticles({int limit = 5}) async {
    return dummyArticles;
  }

  Future<Article> fetchArticle(String id) async {
    for (var article in dummyArticles) {
      if (article.id == id) {
        return article;
      }
    }
    return null;
  }
}
