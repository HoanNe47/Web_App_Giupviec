import 'package:giup_viec_nha_app_user_flutter/services/vnpay/src/web_view_page.dart';
import 'package:nb_utils/nb_utils.dart';
import './vnpay/vnpay_flutter.dart';
import '../../main.dart';
import '../model/payment_gateway_response.dart';
import 'package:flutter/material.dart';

class VnpayServiceNew {
  late PaymentSetting paymentSetting;
  double totalAmount = 0;
  num? bookingId = 0;
  num discount = 0;
  String type = "";
  late Function(Map<String, dynamic>) onComplete;
  bool isTopUp; 

  VnpayServiceNew({
    required PaymentSetting paymentSetting,
    required double totalAmount,
    num discount  = 0,
    type = "",
    this.bookingId,
    required Function(Map<String, dynamic>) onComplete,
    this.isTopUp = false,
  }) {
    this.paymentSetting = paymentSetting;
    this.totalAmount = totalAmount;
    this.discount = discount;
    this.type = type;
    this.bookingId = bookingId;
    this.onComplete = onComplete;
  }

  Future<void> vnpayPay(BuildContext context) async {
  String vnpayPaymentKey = '';
  String vnpayURL = '';
  String vnpayPaymentPublishKey = '';
  
  if (paymentSetting.isTest == 1) {
    vnpayPaymentKey = paymentSetting.testValue!.vnpayKey.validate();
    vnpayURL = paymentSetting.testValue!.vnpayUrl.validate();
    vnpayPaymentPublishKey = paymentSetting.testValue!.vnpayPublickey.validate();
  } else {
    vnpayPaymentKey = paymentSetting.liveValue!.vnpayKey!;
    vnpayURL = paymentSetting.liveValue!.vnpayUrl!;
    vnpayPaymentPublishKey = paymentSetting.liveValue!.vnpayPublickey!;
  }
  
  if (vnpayPaymentKey.isEmpty || vnpayURL.isEmpty || vnpayPaymentPublishKey.isEmpty) {
    throw Exception('Payment configuration is incomplete. Contact your admin.');
  }
  
  num customerId = appStore.userId;
  
  try {
    final paymentUrl = await VNPAYFlutter.instance.generatePaymentUrl(
      bookingId: bookingId,
      customerId: customerId,
      discount: discount,
      txnRef: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: totalAmount,
      isTopUp: isTopUp
    );

    log('Payment URL: $paymentUrl');

    if (paymentUrl.isNotEmpty) {
      final result = await  Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewPage(url: paymentUrl),
        ),
      );
      print("result::: $result");
      if (result is Map<String, String>) {
      final transactionStatus = result['transactionStatus'] ?? 'unknown';
      final transactionId = result['transactionId'] ?? 'unknown';

      onComplete.call({
        'transaction_status': transactionStatus,
        'transaction_id': transactionId,
      });
      } else {
        onComplete.call({
          'transaction_status': 'unknown',
          'transaction_status_text': 'unknown',
          'transaction_id': 'unknown',
        });
      }
    } else {
        onComplete.call({
          'transaction_status': '03',
          'transaction_status_text': 'Payment URL is not valid',
          'transaction_id': 'unknown',
        });
    }
  } catch (e) {
    log('Error generating payment URL: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to generate payment URL. Please try again.')),
    );
  }
}

  
}
