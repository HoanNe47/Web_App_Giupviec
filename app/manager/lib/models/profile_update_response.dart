import 'package:spa_manager_flutter/models/user_data.dart';

class ProfileUpdateResponse {
  UserData? data;
  String? message;

  ProfileUpdateResponse({this.data, this.message});

  ProfileUpdateResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}
