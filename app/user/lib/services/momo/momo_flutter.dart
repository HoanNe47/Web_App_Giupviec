import 'package:giup_viec_nha_app_user_flutter/network/rest_apis.dart';


class MOMOFlutter {
  static final MOMOFlutter _instance = MOMOFlutter();
  static MOMOFlutter get instance => _instance;
  Map<String, dynamic> _sortParams(Map<String, dynamic> params) {
    final sortedParams = <String, dynamic>{};
    final keys = params.keys.toList()..sort();
    for (String key in keys) {
      sortedParams[key] = params[key];
    }
    return sortedParams;
  }

  Future<String>  generatePaymentUrl({
    required num? bookingId,
    required num customerId,
    required num discount,
    required String txnRef,
    required double amount,
    isTopUp
  }) async  {
     var requestBody = {
      "payment_method": "momo",
      "booking_id": bookingId,
      "customer_id": customerId,
      "discount": discount,
      "payment_type": "momo",
      "total_amount": amount,
      "is_mobile": true,
      "type": "advance_payment",
      "datetime": DateTime.now().toIso8601String(),
      "payment_status": "failed",
      "currency_code": "VND",
    };

     if (isTopUp == true) {
          requestBody["is_top_up"] = true;
     }

     final response = await createMomoPayment(requestBody);

    if (response.isNotEmpty) {
      print("responseData::: $response");
      return response['url'] ?? '';
    } else {
      return '';
    }
  }

}

