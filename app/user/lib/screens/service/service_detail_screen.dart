import 'package:actcms_spa_flutter/component/loader_widget.dart';
import 'package:actcms_spa_flutter/component/view_all_label_component.dart';
import 'package:actcms_spa_flutter/main.dart';
import 'package:actcms_spa_flutter/model/service_data_model.dart';
import 'package:actcms_spa_flutter/model/service_detail_response.dart';
import 'package:actcms_spa_flutter/model/user_data_model.dart';
import 'package:actcms_spa_flutter/network/rest_apis.dart';
import 'package:actcms_spa_flutter/screens/auth/sign_in_screen.dart';
import 'package:actcms_spa_flutter/screens/booking/book_service_screen.dart';
import 'package:actcms_spa_flutter/screens/booking/component/booking_detail_provider_widget.dart';
import 'package:actcms_spa_flutter/screens/booking/provider_info_screen.dart';
import 'package:actcms_spa_flutter/screens/review/rating_view_all_screen.dart';
import 'package:actcms_spa_flutter/screens/review/review_widget.dart';
import 'package:actcms_spa_flutter/screens/service/component/service_component.dart';
import 'package:actcms_spa_flutter/screens/service/component/service_detail_header_component.dart';
import 'package:actcms_spa_flutter/screens/service/component/service_faq_widget.dart';
import 'package:actcms_spa_flutter/utils/colors.dart';
import 'package:actcms_spa_flutter/utils/constant.dart';
import 'package:actcms_spa_flutter/utils/images.dart';
import 'package:actcms_spa_flutter/utils/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ServiceDetailScreen extends StatefulWidget {
  final int serviceId;

  ServiceDetailScreen({required this.serviceId});

  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> with TickerProviderStateMixin {
  PageController pageController = PageController();

  Future<ServiceDetailResponse>? future;

  int selectedAddressId = 0;
  int selectedBookingAddressId = -1;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setStatusBarColor(transparentColor);

    future = getServiceDetails(serviceId: widget.serviceId.validate(), customerId: appStore.userId);
  }

  //region Widgets
  Widget availableWidget({required ServiceData data}) {
    if (data.serviceAddressMapping.validate().isEmpty) return Offstage();

    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(language.lblAvailableAt, style: boldTextStyle(size: LABEL_TEXT_SIZE)),
          16.height,
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(
              data.serviceAddressMapping!.length,
              (index) {
                ServiceAddressMapping value = data.serviceAddressMapping![index];
                bool isSelected = selectedAddressId == index;
                if (selectedBookingAddressId == -1) {
                  selectedBookingAddressId = data.serviceAddressMapping!.first.providerAddressId.validate();
                }
                return GestureDetector(
                  onTap: () {
                    selectedAddressId = index;
                    selectedBookingAddressId = value.providerAddressId.validate();
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: boxDecorationDefault(color: isSelected ? primaryColor : context.cardColor),
                    child: Text(
                      '${value.providerAddressMapping!.address.validate()}',
                      style: boldTextStyle(color: isSelected ? Colors.white : textPrimaryColorGlobal),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget providerWidget({required UserData data}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(language.lblAboutProvider, style: boldTextStyle(size: LABEL_TEXT_SIZE)),
        16.height,
        BookingDetailProviderWidget(providerData: data).onTap(() {
          ProviderInfoScreen(providerId: data.id).launch(context);
        }),
      ],
    ).paddingAll(16);
  }

  Widget serviceFaqWidget({required List<ServiceFaq> data}) {
    if (data.isEmpty) return Offstage();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.height,
          ViewAllLabel(label: language.lblFaq, list: data),
          8.height,
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.length,
            padding: EdgeInsets.all(0),
            itemBuilder: (_, index) => ServiceFaqWidget(serviceFaq: data[index]),
          ),
        ],
      ),
    );
  }

  Widget reviewWidget({required List<RatingData> data}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllLabel(
          label: language.review,
          list: data,
          onTap: () {
            RatingViewAllScreen(serviceId: widget.serviceId).launch(context);
          },
        ),
        data.isNotEmpty
            ? Wrap(
                children: List.generate(
                  data.length,
                  (index) => ReviewWidget(data: data[index]),
                ),
              ).paddingTop(8)
            : Text(language.lblNoReviews, style: secondaryTextStyle()),
      ],
    ).paddingSymmetric(horizontal: 16);
  }

  Widget relatedServiceWidget({required List<ServiceData> serviceList, required int serviceId}) {
    if (serviceList.isEmpty) return Offstage();

    serviceList.removeWhere((element) => element.id == serviceId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        8.height,
        Text(language.lblRelatedServices, style: boldTextStyle(size: LABEL_TEXT_SIZE)).paddingSymmetric(horizontal: 16),
        HorizontalList(
          itemCount: serviceList.length,
          padding: EdgeInsets.all(16),
          spacing: 8,
          runSpacing: 16,
          itemBuilder: (_, index) => ServiceComponent(serviceData: serviceList[index], width: context.width() / 2 - 26).paddingOnly(right: 8),
        ),
        16.height,
      ],
    );
  }

  //endregion

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    Widget buildBodyWidget(AsyncSnapshot<ServiceDetailResponse> snap) {
      if (snap.hasError) {
        return Text(snap.error.toString()).center();
      } else if (snap.hasData) {
        return Stack(
          children: [
            AnimatedScrollView(
              padding: EdgeInsets.only(bottom: 120),
              listAnimationType: ListAnimationType.FadeIn,
              children: [
                ServiceDetailHeaderComponent(serviceDetail: snap.data!.serviceDetail!),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      8.height,
                      Text(language.hintDescription, style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                      8.height,
                      snap.data!.serviceDetail!.description.validate().isNotEmpty
                          ? ReadMoreText(
                              snap.data!.serviceDetail!.description.validate(),
                              style: secondaryTextStyle(),
                            )
                          : Text(language.lblNotDescription, style: secondaryTextStyle()),
                    ],
                  ).paddingAll(16),
                ),
                availableWidget(data: snap.data!.serviceDetail!),
                providerWidget(data: snap.data!.provider!),
                serviceFaqWidget(data: snap.data!.serviceFaq.validate()),
                reviewWidget(data: snap.data!.ratingData!),
                24.height,
                relatedServiceWidget(serviceList: snap.data!.realtedService.validate(), serviceId: snap.data!.serviceDetail!.id.validate()),
              ],
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: AppButton(
                onTap: () {
                  if (appStore.isLoggedIn) {
                    snap.data!.serviceDetail!.bookingAddressId = selectedBookingAddressId;
                    BookServiceScreen(data: snap.data!).launch(context).then((value) {
                      setStatusBarColor(transparentColor);
                    });
                  } else {
                    SignInScreen(isFromServiceBooking: true).launch(context).then((value) {
                      if (appStore.isLoggedIn) {
                        snap.data!.serviceDetail!.bookingAddressId = selectedBookingAddressId;
                        BookServiceScreen(data: snap.data!).launch(context).then((value) {
                          setStatusBarColor(transparentColor);
                        });
                      }
                    });
                  }
                },
                color: context.primaryColor,
                text: language.lblBookNow,
                width: context.width(),
                textColor: Colors.white,
              ),
            )
          ],
        );
      }
      return LoaderWidget().center();
    }

    return FutureBuilder<ServiceDetailResponse>(
      future: future,
      builder: (context, snap) {
        return Scaffold(
          body: buildBodyWidget(snap),
          floatingActionButton: (snap.hasData && snap.data!.serviceDetail!.isFeatured.validate(value: 0) == 1)
              ? FloatingActionButton(
                  onPressed: () {
                    toast(language.lblFeaturedProduct);
                  },
                  child: ic_featured.iconImage(color: Colors.white),
                ).paddingBottom(60)
              : Offstage(),
        );
      },
    );
  }
}
