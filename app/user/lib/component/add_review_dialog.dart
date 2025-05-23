import 'package:giup_viec_nha_app_user_flutter/component/loader_widget.dart';
import 'package:giup_viec_nha_app_user_flutter/main.dart';
import 'package:giup_viec_nha_app_user_flutter/model/service_detail_response.dart';
import 'package:giup_viec_nha_app_user_flutter/network/rest_apis.dart';
import 'package:giup_viec_nha_app_user_flutter/utils/colors.dart';
import 'package:giup_viec_nha_app_user_flutter/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import 'chat_gpt_loder.dart';

class AddReviewDialog extends StatefulWidget {
  final RatingData? customerReview;
  final int? bookingId;
  final int? serviceId;
  final int? handymanId;
  final bool? isCustomerRating;

  AddReviewDialog({this.customerReview, this.bookingId, this.serviceId, this.handymanId, this.isCustomerRating});

  @override
  State<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  double selectedRating = 0;

  TextEditingController reviewCont = TextEditingController();

  bool isUpdate = false;
  bool isHandymanUpdate = false;

  @override
  void initState() {
    isUpdate = widget.customerReview != null;
    isHandymanUpdate = widget.customerReview != null && widget.handymanId != null;

    if (isUpdate) {
      selectedRating = widget.customerReview!.rating.validate().toDouble();
      reviewCont.text = widget.customerReview!.review.validate();
    }

    super.initState();
  }

  void submit() async {
    hideKeyboard(context);
    Map<String, dynamic> req = {};
    if (isUpdate) {
      req = {
        "id": widget.customerReview!.id.validate(),
        "booking_id": widget.customerReview!.bookingId.validate(),
        "service_id": widget.customerReview!.serviceId.validate(),
        "customer_id": appStore.userId.validate(),
        "rating": selectedRating.validate(),
        "review": reviewCont.text.validate(),
      };
      if (widget.handymanId != null) {
        req.putIfAbsent("handyman_id", () => widget.handymanId);
      }
      appStore.setLoading(true);

      if (widget.handymanId == null) {
        await updateReview(req).then((value) {
          toast(value.message);
          if (widget.isCustomerRating.validate(value: false)) {
            finish(context, req);
          } else {
            finish(context, true);
          }
        }).catchError((e) {
          toast(e.toString());
          finish(context, false);
        });
      } else {
        await handymanRating(req).then((value) {
          finish(context, true);
          toast(value.message);
        }).catchError((e) {
          toast(e.toString());
          finish(context, false);
        });
      }

      appStore.setLoading(false);

      return;
    }
    req = {
      "id": "",
      "booking_id": widget.bookingId.validate(),
      "service_id": widget.serviceId.validate(),
      "customer_id": appStore.userId.validate(),
      "rating": selectedRating.validate(),
      "review": reviewCont.text.validate(),
    };
    if (widget.handymanId != null) {
      req.putIfAbsent("handyman_id", () => widget.handymanId);
    }
    appStore.setLoading(true);

    if (widget.handymanId == null) {
      await updateReview(req).then((value) {
        finish(context, true);
        toast(value.message);
      }).catchError((e) {
        toast(e.toString());
        finish(context, false);
      });
    } else {
      await handymanRating(req).then((value) {
        finish(context, true);
        toast(value.message);
      }).catchError((e) {
        toast(e.toString());
        finish(context, false);
      });
    }

    appStore.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.width(),
                padding: EdgeInsets.only(left: 16, top: 4, bottom: 4),
                decoration: boxDecorationDefault(
                  color: primaryColor,
                  borderRadius: radiusOnly(topRight: 8, topLeft: 8),
                ),
                child: Row(
                  children: [
                    Text(language.yourReview, style: boldTextStyle(color: Colors.white)).expand(),
                    IconButton(
                      icon: Icon(Icons.clear, color: Colors.white, size: 16),
                      onPressed: () {
                        finish(context);
                      },
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(language.lblYourRating, style: boldTextStyle()),
                      Text("*", style: secondaryTextStyle(color: Colors.red)),
                    ],
                  ),
                  16.height,
                  Container(
                    padding: EdgeInsets.all(16),
                    width: context.width(),
                    decoration: boxDecorationDefault(color: appStore.isDarkMode ? context.dividerColor : context.cardColor),
                    child: RatingBarWidget(
                      onRatingChanged: (rating) {
                        selectedRating = rating;
                        setState(() {});
                      },
                      activeColor: getRatingBarColor(selectedRating.toInt()),
                      inActiveColor: ratingBarColor,
                      rating: selectedRating,
                      size: 18,
                    ),
                  ),
                  16.height,
                  Text(language.lblYourComment, style: boldTextStyle()),
                  16.height,
                  AppTextField(
                    controller: reviewCont,
                    textFieldType: TextFieldType.OTHER,
                    minLines: 5,
                    maxLines: 10,
                    enableChatGPT: appConfigurationStore.chatGPTStatus,
                    promptFieldInputDecorationChatGPT: inputDecoration(context).copyWith(
                      hintText: language.writeHere,
                      fillColor: context.scaffoldBackgroundColor,
                      filled: true,
                    ),
                    testWithoutKeyChatGPT: appConfigurationStore.testWithoutKey,
                    loaderWidgetForChatGPT: const ChatGPTLoadingWidget(),
                    textCapitalization: TextCapitalization.sentences,
                    decoration: inputDecoration(
                      context,
                      labelText: language.lblEnterReview,
                    ).copyWith(fillColor: appStore.isDarkMode ? context.dividerColor : context.cardColor, filled: true),
                  ),
                  32.height,
                  Row(
                    children: [
                      if (isHandymanUpdate)
                        AppButton(
                          text: isHandymanUpdate ? language.lblDelete : language.lblCancel,
                          textColor: isHandymanUpdate ? Colors.red : textPrimaryColorGlobal,
                          color: context.cardColor,
                          onTap: () {
                            if (isHandymanUpdate) {
                              showConfirmDialogCustom(
                                context,
                                primaryColor: context.primaryColor,
                                title: language.lblDeleteRatingMsg,
                                positiveText: language.lblYes,
                                negativeText: language.lblCancel,
                                onAccept: (c) async {
                                  appStore.setLoading(true);

                                  await deleteHandymanReview(id: widget.customerReview!.id.validate().toInt()).then((value) {
                                    toast(value.message);
                                    finish(context, true);
                                  }).catchError((e) {
                                    toast(e.toString());
                                  });

                                  setState(() {});

                                  appStore.setLoading(false);
                                },
                              );
                            } else {
                              finish(context);
                            }
                          },
                        ).expand(),
                      if (isHandymanUpdate) 16.width,
                      AppButton(
                        textColor: Colors.white,
                        text: language.btnSubmit,
                        color: context.primaryColor,
                        onTap: () {
                          if (selectedRating == 0) {
                            toast(language.lblSelectRating);
                          } else {
                            submit();
                          }
                        },
                      ).expand(),
                    ],
                  )
                ],
              ).paddingAll(16)
            ],
          ),
        ),
        Observer(builder: (context) => LoaderWidget().visible(appStore.isLoading).withSize(height: 80, width: 80))
      ],
    );
  }
}
