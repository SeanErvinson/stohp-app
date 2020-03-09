class CommuterOversightInfo {
  String id;
  String vehicleType;
  String route;
  double lat;
  double lng;

  CommuterOversightInfo({this.id, this.lat, this.lng, this.route, this.vehicleType});

  CommuterOversightInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lat = json['lat'];
    lng = json['lng'];
    vehicleType = json['vehicle_type'];
    route = json['route'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['route'] = this.route;
    data['vehicle_type'] = this.vehicleType;
    return data;
  }
}
