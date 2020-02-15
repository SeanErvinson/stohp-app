class Place {
  String id;
  String name;
  String formattedAddress;
  double lat;
  double lng;

  Place({this.id, this.name, this.formattedAddress, this.lat, this.lng});

  Place.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    formattedAddress = json['formatted_address'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['formatted_address'] = this.formattedAddress;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}