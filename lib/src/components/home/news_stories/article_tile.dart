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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: bgPrimary,
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 9,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.network(currentArticle.image),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(12.0),
              child: Text(
                currentArticle.title,
                textScaleFactor: 1.15,
                style: TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
