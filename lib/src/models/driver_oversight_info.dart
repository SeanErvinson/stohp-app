class DriverOversightInfo {
  double lat;
  double lng;
  String id;
  String vehicleType;
  bool isFull;
  String route;

  DriverOversightInfo(
      {this.lat, this.lng, this.id, this.isFull, this.vehicleType, this.route});

  DriverOversightInfo.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    id = json['id'];
    vehicleType = json["vehicle_type"];
    isFull = json['is_full'];
    route = json['route'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['id'] = this.id;
    data['vehicle_type'] = this.vehicleType;
    data['is_full'] = this.isFull;
    data['route'] = this.route;
    return data;
  }
}
