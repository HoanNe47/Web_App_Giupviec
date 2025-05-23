import 'package:spa_manager_flutter/models/provider_subscription_model.dart';

class UserData {
  int? id;
  String? uid;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? emailVerifiedAt;
  String? userType;
  String? contactNumber;
  int? countryId;
  int? stateId;
  int? cityId;
  String? address;
  int? providerId;
  String? playerId;
  int? status;
  int? providertypeId;
  int? isFeatured;
  String? displayName;
  String? timeZone;
  String? lastNotificationSeen;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? apiToken;
  String? profileImage;
  String? description;
  int? serviceAddressId;
  num? handymanRating;
  int? isSubscribe;
  String? designation;
  String? password;
  String? cityName;
  num? providerServiceRating;
  String? providerType;
  bool? isHandymanAvailable;
  String? loginType;
  String? handymanType;
  int? isOnline;
  List<String>? userRole;
  ProviderSubscriptionModel? subscription;

  //Local
  bool isActive = false;

  UserData({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.emailVerifiedAt,
    this.userType,
    this.contactNumber,
    this.countryId,
    this.providerServiceRating,
    this.stateId,
    this.cityId,
    this.address,
    this.providerId,
    this.playerId,
    this.status,
    this.providertypeId,
    this.isFeatured,
    this.displayName,
    this.timeZone,
    this.lastNotificationSeen,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.userRole,
    this.apiToken,
    this.profileImage,
    this.description,
    this.serviceAddressId,
    this.handymanRating,
    this.subscription,
    this.isSubscribe,
    this.uid,
    this.designation,
    this.cityName,
    this.providerType,
    this.handymanType,
    this.isHandymanAvailable,
    this.loginType,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    providerServiceRating = json['providers_service_rating'];
    isOnline = json['isOnline'];
    userType = json['user_type'];
    contactNumber = json['contact_number'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    address = json['address'];
    providerId = json['provider_id'];
    playerId = json['player_id'];
    status = json['status'];
    isActive = status == 1;
    serviceAddressId = json['service_address_id'];
    handymanRating = json['handyman_rating'];
    isFeatured = json['is_featured'];
    displayName = json['display_name'];
    timeZone = json['time_zone'];
    lastNotificationSeen = json['last_notification_seen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    apiToken = json['api_token'];
    profileImage = json['profile_image'];
    description = json['description'];
    uid = json['uid'];
    subscription = json['subscription'] != null ? ProviderSubscriptionModel.fromJson(json['subscription']) : null;
    isSubscribe = json['is_subscribe'];
    designation = json['designation'];
    cityName = json['city_name'];
    providerType = json['providertype'];
    handymanType = json['handymantype'];
    isHandymanAvailable = json['isHandymanAvailable'] != null ? json['isHandymanAvailable'] == 1 : false;
    loginType = json['login_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) data['id'] = this.id;
    if (this.username != null) data['username'] = this.username;
    if (this.firstName != null) data['first_name'] = this.firstName;
    if (this.lastName != null) data['last_name'] = this.lastName;
    if (this.email != null) data['email'] = this.email;
    if (this.providerServiceRating != null) data['providers_service_rating'] = this.providerServiceRating;
    if (this.serviceAddressId != null) data['service_address_id'] = this.serviceAddressId;
    if (this.handymanRating != null) data['handyman_rating'] = this.handymanRating;
    if (this.emailVerifiedAt != null) data['email_verified_at'] = this.emailVerifiedAt;
    if (this.userType != null) data['user_type'] = this.userType;
    if (this.contactNumber != null) data['contact_number'] = this.contactNumber;
    if (this.countryId != null) data['country_id'] = this.countryId;
    if (this.isOnline != null) data['isOnline'] = this.isOnline;
    if (this.handymanType != null) data['handymantype'] = this.handymanType;
    if (this.stateId != null) data['state_id'] = this.stateId;
    if (this.cityId != null) data['city_id'] = this.cityId;
    if (this.address != null) data['address'] = this.address;
    if (this.providerId != null) data['provider_id'] = this.providerId;
    if (this.playerId != null) data['player_id'] = this.playerId;
    if (this.status != null) data['status'] = this.status;
    if (this.providertypeId != null) data['providertype_id'] = this.providertypeId;
    if (this.isFeatured != null) data['is_featured'] = this.isFeatured;
    if (this.displayName != null) data['display_name'] = this.displayName;
    if (this.timeZone != null) data['time_zone'] = this.timeZone;
    if (this.lastNotificationSeen != null) data['last_notification_seen'] = this.lastNotificationSeen;
    if (this.createdAt != null) data['created_at'] = this.createdAt;
    if (this.updatedAt != null) data['updated_at'] = this.updatedAt;
    if (this.deletedAt != null) data['deleted_at'] = this.deletedAt;
    if (this.userRole != null) data['user_role'] = this.userRole;
    if (this.apiToken != null) data['api_token'] = this.apiToken;
    if (this.profileImage != null) data['profile_image'] = this.profileImage;
    if (this.description != null) data['description'] = this.description;
    if (this.uid != null) data['uid'] = this.uid;
    if (this.isSubscribe != null) data['is_subscribe'] = this.isSubscribe;
    if (this.cityName != null) data['city_name'] = this.cityName;
    if (this.providerType != null) data['providertype'] = this.providerType;
    if (this.isHandymanAvailable != null) data['isHandymanAvailable'] = this.isHandymanAvailable;
    if (this.loginType != null) data['login_type'] = this.loginType;

    if (this.subscription != null) {
      data['subscription'] = this.subscription!.toJson();
    }
    if (this.designation != null) data['designation'] = this.designation;
    return data;
  }
}
