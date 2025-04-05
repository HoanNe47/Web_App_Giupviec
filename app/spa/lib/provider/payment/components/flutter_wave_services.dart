import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:spa_manager_flutter/main.dart';
import 'package:spa_manager_flutter/models/provider_subscription_model.dart';
import 'package:spa_manager_flutter/networks/rest_apis.dart';
import 'package:spa_manager_flutter/utils/configs.dart';
import 'package:spa_manager_flutter/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uuid/uuid.dart';

void handlePaymentInitialization(BuildContext context, {required ProviderSubscriptionModel data, required String flutterWavePublicKeys}) async {
  final Customer customer = Customer(
    name: appStore.userName,
    phoneNumber: appStore.userContactNumber,
    email: appStore.userEmail,
  );

  Flutterwave flutterWave = Flutterwave(
    context: context,
    style: FlutterwaveStyle(
      appBarText: "Pay By FlutterWave",
      buttonColor: primaryColor,
      appBarIcon: Icon(Icons.arrow_back_ios, color: Colors.white),
      buttonTextStyle: boldTextStyle(color: Colors.white),
      buttonText: "Continue to pay ${data.amount.validate()}${appStore.currencySymbol}",
      appBarColor: primaryColor,
      appBarTitleTextStyle: boldTextStyle(color: Colors.white, size: 18),
      dialogCancelTextStyle: TextStyle(color: Colors.redAccent, fontSize: 18),
      dialogContinueTextStyle: TextStyle(color: Colors.blue, fontSize: 18),
    ),
    publicKey: flutterWavePublicKeys,
    currency: appStore.currencyCode,
    redirectUrl: "https://google.com",
    txRef: Uuid().v1(),
    amount: data.amount.validate().toString(),
    customer: customer,
    paymentOptions: "card, payattitude, barter",
    customization: Customization(title: "FlutterWave Payment"),
    isTestMode: false,
  );

  await flutterWave.charge().then((value) {
    if (value.success.validate()) {
      savePayment(data: data, paymentMethod: PAYMENT_METHOD_FLUTTER_WAVE, paymentStatus: SERVICE_PAYMENT_STATUS_PAID, txtId: value.transactionId.validate());
    }
  }).catchError((e) {
    appStore.setLoading(false);
    log(e.toString());
  });
}
