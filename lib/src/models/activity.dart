class Activity {
  String id;
  String userId;
  String title;
  DateTime createdOn;

  Activity({this.id, this.userId, this.title, this.createdOn});

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['createdOn'] = this.createdOn;
    return data;
  }
}
