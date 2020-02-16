class Distance {
  String distanceInText;
  String distanceInUnit;
  int distanceInValue;
  String durationInText;
  String durationInUnit;
  int durationInValue;
  String points;

  Distance(
      {this.distanceInText,
      this.distanceInValue,
      this.distanceInUnit,
      this.durationInText,
      this.durationInValue,
      this.durationInUnit,
      this.points});

  Distance.fromJson(Map<String, dynamic> json) {
    String distance = json["routes"][0]["legs"][0]["distance"]['text'];
    distanceInText = distance.split(" ")[0];
    distanceInUnit = distance.split(" ")[1];
    String duration = json["routes"][0]["legs"][0]["duration"]['text'];
    distanceInValue = json["routes"][0]["legs"][0]["distance"]['value'];
    durationInText = duration.split(" ")[0];
    durationInUnit = duration.split(" ")[1];
    durationInValue = json["routes"][0]["legs"][0]["duration"]['value'];
    points = json['routes'][0]["overview_polyline"]["points"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distance_in_text'] = this.distanceInText;
    data['distance_in_value'] = this.distanceInValue;
    data['duration_in_text'] = this.durationInText;
    data['duration_in_value'] = this.durationInValue;
    data['points'] = this.points;
    return data;
  }
}
