import 'package:actcms_spa_flutter/model/user_data_model.dart';

class LoginResponse {
  UserData? data;
  bool? isUserExist;
  bool? status;
  String? message;

  LoginResponse({this.data, this.isUserExist, this.status, this.message});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
      isUserExist: json['is_user_exist'],
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['is_user_exist'] = this.isUserExist;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
