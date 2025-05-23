import 'package:giup_viec_nha_app_user_flutter/component/loader_widget.dart';
import 'package:giup_viec_nha_app_user_flutter/main.dart';
import 'package:giup_viec_nha_app_user_flutter/model/booking_detail_model.dart';
import 'package:giup_viec_nha_app_user_flutter/network/rest_apis.dart';
import 'package:giup_viec_nha_app_user_flutter/utils/colors.dart';
import 'package:giup_viec_nha_app_user_flutter/utils/common.dart';
import 'package:giup_viec_nha_app_user_flutter/utils/constant.dart';
import 'package:giup_viec_nha_app_user_flutter/utils/model_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../component/chat_gpt_loder.dart';

class ReasonDialog extends StatefulWidget {
  final BookingDetailResponse status;
  final String? currentStatus;

  ReasonDialog({required this.status, this.currentStatus});

  @override
  State<ReasonDialog> createState() => _ReasonDialogState();
}

class _ReasonDialogState extends State<ReasonDialog> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController _textFieldReason = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: context.width(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.height,
                  Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: AppTextField(
                      controller: _textFieldReason,
                      textFieldType: TextFieldType.MULTILINE,
                      decoration: inputDecoration(context, labelText: language.enterReason, fillColor: appStore.isDarkMode ? context.scaffoldBackgroundColor : context.cardColor),
                      enableChatGPT: appConfigurationStore.chatGPTStatus,
                      promptFieldInputDecorationChatGPT: inputDecoration(context).copyWith(
                        hintText: language.writeHere,
                        fillColor: context.scaffoldBackgroundColor,
                        filled: true,
                      ),
                      testWithoutKeyChatGPT: appConfigurationStore.testWithoutKey,
                      loaderWidgetForChatGPT: const ChatGPTLoadingWidget(),
                      minLines: 4,
                      maxLines: 10,
                    ),
                  ),
                  24.height,
                  AppButton(
                    color: primaryColor,
                    height: 40,
                    text: language.btnSubmit,
                    textStyle: boldTextStyle(color: Colors.white),
                    width: context.width() - context.navigationBarHeight,
                    onTap: () {
                      _handleClick();
                    },
                  ),
                  8.height,
                ],
              ).paddingAll(16)
            ],
          ),
        ),
        Observer(
          builder: (context) => LoaderWidget().withSize(height: 80, width: 80).visible(appStore.isLoading),
        )
      ],
    );
  }

  void saveCancelClick() async {
    Map request = {
      CommonKeys.id: widget.status.bookingDetail!.id.validate(),
      BookingUpdateKeys.startAt: widget.status.bookingDetail!.date.validate(),
      BookingUpdateKeys.endAt: formatBookingDate(DateTime.now().toString(), format: BOOKING_SAVE_FORMAT, isLanguageNeeded: false),
      BookingUpdateKeys.durationDiff: widget.status.bookingDetail!.durationDiff.validate(),
      BookingUpdateKeys.reason: _textFieldReason.text,
      CommonKeys.status: BookingStatusKeys.cancelled,
      CommonKeys.advancePaidAmount: widget.status.bookingDetail!.paidAmount,
      CommonKeys.cancellationCharge: 0,
      CommonKeys.cancellationChargeAmount: 0,
      BookingUpdateKeys.paymentStatus: widget.status.bookingDetail!.isAdvancePaymentDone ? SERVICE_PAYMENT_STATUS_ADVANCE_PAID : widget.status.bookingDetail!.paymentStatus.validate(),
    };

    appStore.setLoading(true);

    await updateBooking(request).then((res) async {
      toast(res.message!);
      finish(context, true);
    }).catchError((e) {
      toast(e.toString(), print: true);
    });

    appStore.setLoading(false);
  }

  void saveHoldClick() async {
    Map request = {
      CommonKeys.id: widget.status.bookingDetail!.id.validate(),
      BookingUpdateKeys.startAt: widget.status.bookingDetail!.startAt.validate(),
      // BookingUpdateKeys.endAt: formatBookingDate(DateTime.now().toString(), format: BOOKING_SAVE_FORMAT, isLanguageNeeded: false),
      BookingUpdateKeys.durationDiff: DateTime.parse(DateFormat(BOOKING_SAVE_FORMAT).format(DateTime.now())).difference(DateTime.parse(widget.status.bookingDetail!.startAt.validate())).inSeconds,
      BookingUpdateKeys.reason: _textFieldReason.text,
      CommonKeys.status: BookingStatusKeys.hold,
      BookingUpdateKeys.paymentStatus: widget.status.bookingDetail!.isAdvancePaymentDone ? SERVICE_PAYMENT_STATUS_ADVANCE_PAID : widget.status.bookingDetail!.paymentStatus.validate(),
    };

    appStore.setLoading(true);

    await updateBooking(request).then((res) async {
      toast(res.message!);
      Map<String, dynamic> liveStreamRequest = {
        "inSeconds": "${(widget.status.bookingDetail!.durationDiff.toInt() + request[BookingUpdateKeys.durationDiff].toString().toInt())}".toInt(),
        "status": BookingStatusKeys.hold,
      };
      LiveStream().emit(LIVESTREAM_START_TIMER, liveStreamRequest);
      finish(context, true);
    }).catchError((e) {
      toast(e.toString(), print: true);
    });

    appStore.setLoading(false);
  }

  void _handleClick() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (widget.status.bookingDetail!.status == BookingStatusKeys.pending || widget.status.bookingDetail!.status == BookingStatusKeys.hold || widget.status.bookingDetail!.status == BookingStatusKeys.accept) {
        saveCancelClick();
      } else if (widget.currentStatus == BookingStatusKeys.hold) {
        saveHoldClick();
      }
    }
  }
}
