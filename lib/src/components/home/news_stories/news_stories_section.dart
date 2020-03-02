import 'package:flutter/material.dart';
import 'package:stohp/src/components/common/card_header.dart';
import 'package:stohp/src/components/home/news_stories/article_tile.dart';
import 'package:stohp/src/models/article.dart';
import 'package:stohp/src/repository/news_stories_repository.dart';
import 'package:stohp/src/values/values.dart';

class NewsStoriesSection extends StatelessWidget {
  const NewsStoriesSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _usableScreenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    NewsStoriesRepository _newsStoriesRepository = new NewsStoriesRepository();
    return Container(
      height: _usableScreenHeight * .3,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CardHeader(
              title: Strings.newsStoriesHeader,
            ),
            Expanded(
              child: FutureBuilder<List<Article>>(
                future: _newsStoriesRepository.fetchArticles(),
                initialData: [],
                builder: (BuildContext context,
                    AsyncSnapshot<List<Article>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError) return Container();
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1),
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: false,
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            snapshot.data != null ? snapshot.data.length : 0,
                        itemBuilder: (BuildContext context, int index) {
                          Article currentArticle = snapshot.data[index];
                          return ArticleTile(currentArticle: currentArticle);
                        },
                      );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
