class Article {
  int id;
  String title;
  String slug;
  String image;
  String content;
  String createdOn;

  Article(
      {this.id,
      this.title,
      this.slug,
      this.image,
      this.content,
      this.createdOn});

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    image = json['image'];
    content = json['content'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['content'] = this.content;
    data['created_on'] = this.createdOn;
    return data;
  }
}
