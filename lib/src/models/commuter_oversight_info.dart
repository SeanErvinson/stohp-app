class CommuterOversightInfo {
  String id;
  double lat;
  double lng;

  CommuterOversightInfo({this.id, this.lat, this.lng});

  CommuterOversightInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
