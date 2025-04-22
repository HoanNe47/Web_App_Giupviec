import 'package:giup_viec_nha_app_user_flutter/services/momo/momo_web_view_page.dart';
import 'package:nb_utils/nb_utils.dart';
import './momo/momo_flutter.dart';
import '../../main.dart';
import '../model/payment_gateway_response.dart';
import 'package:flutter/material.dart';

class MomoServiceNew {
  late PaymentSetting paymentSetting;
  double totalAmount = 0;
  num? bookingId = 0;
  num discount = 0;
  String type = "";
  late Function(Map<String, dynamic>) onComplete;
  bool isTopUp;

  MomoServiceNew({
    required this.paymentSetting,
    required this.totalAmount,
    this.discount = 0,
    this.type = "",
    this.bookingId,
    required this.onComplete,
    this.isTopUp = false
  });

  Future<void> momoPay(BuildContext context) async {
    String momoPartnerCode = paymentSetting.isTest == 1
        ? paymentSetting.testValue!.momoPartCode.validate()
        : paymentSetting.liveValue!.momoPartCode!;
    String momoURL = paymentSetting.isTest == 1
        ? paymentSetting.testValue!.momoUrl.validate()
        : paymentSetting.liveValue!.momoUrl!;
    
    if (momoPartnerCode.isEmpty || momoURL.isEmpty) {
      throw Exception('Payment configuration is incomplete. Contact your admin.');
    } 

    num customerId = appStore.userId;
    try {
      final paymentUrl = await MOMOFlutter.instance.generatePaymentUrl(
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
          builder: (context) => MomoWebViewPage(url: paymentUrl),
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
