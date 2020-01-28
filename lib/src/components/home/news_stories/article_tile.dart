import 'package:flutter/material.dart';
import 'package:stohp/src/models/article.dart';
import 'package:stohp/src/values/colors.dart';

class ArticleTile extends StatelessWidget {
  const ArticleTile({
    Key key,
    @required this.currentArticle,
  }) : super(key: key);

  final Article currentArticle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148.0,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: bgSecondary,
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 9,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.network(currentArticle.image),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0),
              child: Text(
                currentArticle.title,
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
