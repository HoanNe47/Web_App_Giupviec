import 'package:giup_viec_nha_app_user_flutter/network/rest_apis.dart';

class VNPAYFlutter {
  static final VNPAYFlutter _instance = VNPAYFlutter();
  static VNPAYFlutter get instance => _instance;

  Future<String>  generatePaymentUrl({
    required num? bookingId,
    required num customerId,
    required num discount,
    required String txnRef,
    required double amount,
    bool? isTopUp
  }) async  {
     var requestBody = {
      "payment_method": "vnpay",
      "booking_id": bookingId,
      "customer_id": customerId,
      "discount": discount,
      "payment_type": "vnpay",
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
     final response = await createVnpayPayment(requestBody);

      print("responseData::: $response");
    if (response.isNotEmpty) {
      print("responseData::: $response");
      return response['url'] ?? '';
    } else {
      return '';
    }
  }

  
}

