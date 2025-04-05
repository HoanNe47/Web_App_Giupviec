class WardListResponse {
  int? id;
  String? name;
  int? cityId;

  WardListResponse({this.id, this.name, this.cityId});

  factory WardListResponse.fromJson(Map<String, dynamic> json) {
    return WardListResponse(
      id: json['id'],
      name: json['name'],
      cityId: json['city_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['city_id'] = this.cityId;
    return data;
  }
}

