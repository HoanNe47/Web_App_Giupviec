import 'package:actcms_spa_flutter/component/add_review_dialog.dart';
import 'package:actcms_spa_flutter/component/disabled_rating_bar_widget.dart';
import 'package:actcms_spa_flutter/component/image_border_component.dart';
import 'package:actcms_spa_flutter/main.dart';
import 'package:actcms_spa_flutter/model/booking_data_model.dart';
import 'package:actcms_spa_flutter/model/service_data_model.dart';
import 'package:actcms_spa_flutter/model/service_detail_response.dart';
import 'package:actcms_spa_flutter/model/user_data_model.dart';
import 'package:actcms_spa_flutter/screens/chat/user_chat_screen.dart';
import 'package:actcms_spa_flutter/utils/colors.dart';
import 'package:actcms_spa_flutter/utils/common.dart';
import 'package:actcms_spa_flutter/utils/images.dart';
import 'package:actcms_spa_flutter/utils/model_keys.dart';
import 'package:actcms_spa_flutter/utils/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingDetailHandymanWidget extends StatefulWidget {
  final UserData handymanData;
  final ServiceData serviceDetail;
  final BookingData bookingDetail;
  final Function() onUpdate;

  BookingDetailHandymanWidget({required this.handymanData, required this.serviceDetail, required this.bookingDetail, required this.onUpdate});

  @override
  BookingDetailHandymanWidgetState createState() => BookingDetailHandymanWidgetState();
}

class BookingDetailHandymanWidgetState extends State<BookingDetailHandymanWidget> {
  int? flag;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor, borderRadius: radius()),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ImageBorder(
                src: widget.handymanData.profileImage.validate(),
                height: 70,
              ),
              16.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(widget.handymanData.displayName.validate(), style: boldTextStyle()).flexible(),
                      16.width,
                      ic_info.iconImage(size: 20),
                    ],
                  ),
                  4.height,
                  DisabledRatingBarWidget(rating: widget.handymanData.handymanRating.validate().toDouble()),
                ],
              ).expand()
            ],
          ),
          8.height,
          Divider(),
          8.height,
          Row(
            children: [
              if (widget.handymanData.contactNumber.validate().isNotEmpty)
                AppButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ic_calling.iconImage(size: 18, color: Colors.white),
                      8.width,
                      Text(language.lblCall, style: boldTextStyle(color: white)),
                    ],
                  ).fit(),
                  width: context.width(),
                  color: primaryColor,
                  elevation: 0,
                  onTap: () {
                    launchCall(widget.handymanData.contactNumber.validate());
                  },
                ).expand(),
              16.width,
              AppButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ic_chat.iconImage(size: 18),
                    8.width,
                    Text(language.lblchat, style: boldTextStyle()),
                  ],
                ).fit(),
                width: context.width(),
                elevation: 0,
                color: context.scaffoldBackgroundColor,
                onTap: () async {
                  await userService.getUser(email: widget.handymanData.email.validate()).then((value) {
                    widget.handymanData.uid = value.uid;
                  }).catchError((e) {
                    log(e.toString());
                  });
                  UserChatScreen(receiverUser: widget.handymanData).launch(context);
                },
              ).expand(),
              16.width,
              AppButton(
                child: Image.asset(ic_whatsapp, height: 18),
                elevation: 0,
                color: context.scaffoldBackgroundColor,
                onTap: () async {
                  String phoneNumber = "";
                  if (widget.handymanData.contactNumber.validate().contains('+')) {
                    phoneNumber = "${widget.handymanData.contactNumber.validate().replaceAll('-', '')}";
                  } else {
                    phoneNumber = "+${widget.handymanData.contactNumber.validate().replaceAll('-', '')}";
                  }
                  launchUrl(Uri.parse('${getSocialMediaLink(LinkProvider.WHATSAPP)}$phoneNumber'), mode: LaunchMode.externalApplication);
                },
              ),
            ],
          ),
          8.height,
          if (widget.bookingDetail.status == BookingStatusKeys.complete && widget.bookingDetail.paymentStatus == "paid")
            TextButton(
              onPressed: () {
                _handleHandymanRatingClick();
              },
              child: Text(widget.handymanData.handymanReview != null ? language.lblEditYourReview : language.lblRateHandyman, style: boldTextStyle(color: primaryColor)),
            ).center()
        ],
      ),
    );
  }

  void _handleHandymanRatingClick() {
    if (widget.handymanData.handymanReview == null) {
      showInDialog(
        context,
        contentPadding: EdgeInsets.zero,
        backgroundColor: context.scaffoldBackgroundColor,
        dialogAnimation: DialogAnimation.SCALE,
        builder: (p0) {
          return AddReviewDialog(
            serviceId: widget.serviceDetail.id.validate(),
            bookingId: widget.bookingDetail.id.validate(),
            handymanId: widget.handymanData.id,
          );
        },
      ).then((value) {
        if (value ?? false) {
          widget.onUpdate.call();
        }
      }).catchError((e) {
        log(e.toString());
      });
    } else {
      showInDialog(
        context,
        contentPadding: EdgeInsets.zero,
        backgroundColor: context.scaffoldBackgroundColor,
        dialogAnimation: DialogAnimation.SCALE,
        builder: (p0) {
          return AddReviewDialog(
            serviceId: widget.serviceDetail.id.validate(),
            bookingId: widget.bookingDetail.id.validate(),
            handymanId: widget.handymanData.id,
            customerReview: RatingData(
              bookingId: widget.handymanData.handymanReview!.bookingId,
              createdAt: widget.handymanData.handymanReview!.createdAt,
              customerName: widget.handymanData.handymanReview!.customerName,
              id: widget.handymanData.handymanReview!.id,
              rating: widget.handymanData.handymanReview!.rating,
              customerId: widget.handymanData.handymanReview!.customerId,
              review: widget.handymanData.handymanReview!.review,
              serviceId: widget.handymanData.handymanReview!.serviceId,
            ),
          );
        },
      ).then((value) {
        if (value ?? false) {
          widget.onUpdate.call();
        }
      }).catchError((e) {
        log(e.toString());
      });
    }
  }
}
