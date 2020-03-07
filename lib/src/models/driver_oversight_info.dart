class DriverOversightInfo {
  double lat;
  double lng;
  String id;
  bool isFull;
  String route;

  DriverOversightInfo({this.lat, this.lng, this.id, this.isFull, this.route});

  DriverOversightInfo.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    id = json['id'];
    isFull = json['is_full'];
    route = json['route'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['id'] = this.id;
    data['is_full'] = this.isFull;
    data['route'] = this.route;
    return data;
  }
}
