import 'package:giup_viec_nha_app_user_flutter/model/service_data_model.dart';

import 'pagination_model.dart';

class ServiceResponse {
  List<ServiceData>? serviceList;
  Pagination? pagination;
  num? max;
  num? min;
  List<ServiceData>? userServices;

  ServiceResponse({this.serviceList, this.pagination, this.max, this.min, this.userServices});

  factory ServiceResponse.fromJson(Map<String, dynamic> json) {
    return ServiceResponse(
      serviceList: json['data'] != null ? (json['data'] as List).map((i) => ServiceData.fromJson(i)).toList() : null,
      max: json['max'] != null ? num.parse(json['max'].toString()) : 0.0,
      min: json['min'] != null ? num.parse(json['min'].toString()) : 0.0,
      pagination: json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null,
      userServices: json['user_services'] != null ? (json['user_services'] as List).map((i) => ServiceData.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['max'] = this.max;
    data['min'] = this.min;
    if (this.serviceList != null) {
      data['data'] = this.serviceList!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.userServices != null) {
      data['user_services'] = this.userServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
