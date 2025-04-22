import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:spa_manager_flutter/components/app_widgets.dart';
import 'package:spa_manager_flutter/components/back_widget.dart';
import 'package:spa_manager_flutter/main.dart';
import 'package:spa_manager_flutter/models/dashboard_response.dart';
import 'package:spa_manager_flutter/models/provider_subscription_model.dart';
import 'package:spa_manager_flutter/provider/payment/components/flutter_wave_services.dart';
import 'package:spa_manager_flutter/provider/payment/components/razor_pay_services.dart';
import 'package:spa_manager_flutter/provider/payment/components/stripe_services.dart';
import 'package:spa_manager_flutter/utils/configs.dart';
import 'package:spa_manager_flutter/utils/constant.dart';
import 'package:spa_manager_flutter/utils/extensions/context_ext.dart';
import 'package:spa_manager_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class PaymentScreen extends StatefulWidget {
  final ProviderSubscriptionModel selectedPricingPlan;

  const PaymentScreen(this.selectedPricingPlan);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  RazorPayServices razorPayServices = RazorPayServices();

  List<PaymentSetting> paymentList = [];

  PaymentSetting? currentTimeValue;

  bool isPaymentProcessing = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    paymentList = PaymentSetting.decode(getStringAsync(PAYMENT_LIST));
    paymentList.removeWhere((element) => element.type == PAYMENT_METHOD_COD);
    if (paymentList.isNotEmpty) {
      currentTimeValue = paymentList.first;
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void _handleClick() async {
    if (isPaymentProcessing) return;
    isPaymentProcessing = false;

    if (currentTimeValue!.type == PAYMENT_METHOD_STRIPE) {
      if (currentTimeValue!.isTest == 1) {
        await stripeServices.init(
          data: widget.selectedPricingPlan,
          stripePaymentPublishKey: currentTimeValue!.testValue!.stripePublickey.validate(),
          totalAmount: widget.selectedPricingPlan.amount.validate(),
          stripeURL: currentTimeValue!.testValue!.stripeUrl.validate(),
          stripePaymentKey: currentTimeValue!.testValue!.stripeKey.validate(),
          isTest: true,
        );
        await 1.seconds.delay;
        stripeServices.stripePay(widget.selectedPricingPlan, onPaymentComplete: () {
          isPaymentProcessing = false;
        });
      } else {
        await stripeServices.init(
          data: widget.selectedPricingPlan,
          stripePaymentPublishKey: currentTimeValue!.liveValue!.stripePublickey.validate(),
          totalAmount: widget.selectedPricingPlan.amount.validate(),
          stripeURL: currentTimeValue!.liveValue!.stripeUrl.validate(),
          stripePaymentKey: currentTimeValue!.liveValue!.stripeKey.validate(),
          isTest: true,
        );
        await 1.seconds.delay;
        stripeServices.stripePay(widget.selectedPricingPlan, onPaymentComplete: () {
          isPaymentProcessing = false;
        });
      }
    } else if (currentTimeValue!.type == PAYMENT_METHOD_RAZOR) {
      if (currentTimeValue!.isTest == 1) {
        appStore.setLoading(true);
        razorPayServices.init(razorKey: currentTimeValue!.testValue!.razorKey!, data: widget.selectedPricingPlan);
        await 1.seconds.delay;
        appStore.setLoading(false);
        razorPayServices.razorPayCheckout(widget.selectedPricingPlan.amount.validate());
      } else {
        appStore.setLoading(true);
        razorPayServices.init(razorKey: currentTimeValue!.liveValue!.razorKey!, data: widget.selectedPricingPlan);
        await 1.seconds.delay;
        appStore.setLoading(false);
        razorPayServices.razorPayCheckout(widget.selectedPricingPlan.amount.validate());
      }
    } else if (currentTimeValue!.type == PAYMENT_METHOD_FLUTTER_WAVE) {
      if (currentTimeValue!.isTest == 1) {
        appStore.setLoading(true);
        handlePaymentInitialization(context, flutterWavePublicKeys: currentTimeValue!.testValue!.flutterwavePublic.validate(), data: widget.selectedPricingPlan);
        await 1.seconds.delay;
        appStore.setLoading(false);
      } else {
        appStore.setLoading(true);
        handlePaymentInitialization(context, flutterWavePublicKeys: currentTimeValue!.liveValue!.flutterwavePublic.validate(), data: widget.selectedPricingPlan);
        await 1.seconds.delay;
        appStore.setLoading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context.translate.lblPayment, color: context.primaryColor, textColor: Colors.white, backWidget: BackWidget()),
      body: Stack(
        children: [
          if (paymentList.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.height,
                Text(context.translate.lblChoosePaymentMethod, style: boldTextStyle(size: 18)).paddingOnly(left: 16),
                16.height,
                ListView.builder(
                  itemCount: paymentList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    PaymentSetting value = paymentList[index];
                    return RadioListTile<PaymentSetting>(
                      dense: true,
                      activeColor: primaryColor,
                      value: value,
                      controlAffinity: ListTileControlAffinity.trailing,
                      groupValue: currentTimeValue,
                      onChanged: (PaymentSetting? ind) {
                        currentTimeValue = ind;
                        setState(() {});
                      },
                      title: Text(value.title.validate(), style: primaryTextStyle()),
                    );
                  },
                ),
                Spacer(),
                AppButton(
                  onTap: () {
                    if (currentTimeValue!.type == PAYMENT_METHOD_COD) {
                      showConfirmDialogCustom(
                        context,
                        dialogType: DialogType.CONFIRMATION,
                        title: "${context.translate.lblPayWith} ${currentTimeValue!.title.validate()}",
                        primaryColor: primaryColor,
                        onAccept: (p0) {
                          _handleClick();
                        },
                      );
                    } else {
                      _handleClick();
                    }
                  },
                  text: context.translate.lblProceed,
                  color: context.primaryColor,
                  width: context.width(),
                ).paddingAll(16),
              ],
            ),
          if (paymentList.isEmpty)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(notDataFoundImg, height: 150),
                16.height,
                Text(context.translate.lblNoPayments, style: boldTextStyle()).center(),
              ],
            ),
          Observer(builder: (context) => LoaderWidget().center().visible(appStore.isLoading))
        ],
      ),
    );
  }
}
