class Profile {
  String gender;
  String avatar;

  Profile({this.gender, this.avatar});

  Profile.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['avatar'] = this.avatar;
    return data;
  }
}
