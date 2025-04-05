import 'package:actcms_spa_flutter/component/loader_widget.dart';
import 'package:actcms_spa_flutter/main.dart';
import 'package:actcms_spa_flutter/model/dashboard_model.dart';
import 'package:actcms_spa_flutter/network/rest_apis.dart';
import 'package:actcms_spa_flutter/screens/dashboard/component/category_component.dart';
import 'package:actcms_spa_flutter/screens/dashboard/component/customer_ratings_component.dart';
import 'package:actcms_spa_flutter/screens/dashboard/component/featured_service_list_component.dart';
import 'package:actcms_spa_flutter/screens/dashboard/component/service_list_component.dart';
import 'package:actcms_spa_flutter/screens/dashboard/component/slider_and_location_component.dart';
import 'package:actcms_spa_flutter/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardFragment extends StatefulWidget {
  @override
  _DashboardFragmentState createState() => _DashboardFragmentState();
}

class _DashboardFragmentState extends State<DashboardFragment> {
  Future<DashboardResponse>? future;

  @override
  void initState() {
    super.initState();
    init();

    setStatusBarColor(transparentColor, delayInMilliSeconds: 1000);

    LiveStream().on(LIVESTREAM_UPDATE_DASHBOARD, (p0) {
      setState(() {});
    });
  }

  void init() async {
    future = userDashboard(isCurrentLocation: appStore.isCurrentLocation, lat: getDoubleAsync(LATITUDE), long: getDoubleAsync(LONGITUDE));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
    LiveStream().dispose(LIVESTREAM_UPDATE_DASHBOARD);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          init();
          setState(() {});
          return await 2.seconds.delay;
        },
        child: Stack(
          children: [
            FutureBuilder<DashboardResponse>(
              future: future,
              builder: (context, snap) {
                if (snap.hasData) {
                  return AnimatedScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    listAnimationType: ListAnimationType.FadeIn,
                    children: [
                      SliderLocationComponent(
                        sliderList: snap.data!.slider.validate(),
                        notificationReadCount: snap.data!.notificationUnreadCount.validate(),
                        callback: () async {
                          init();
                          await 300.milliseconds.delay;
                          setState(() {});
                        },
                      ),
                      32.height,
                      CategoryComponent(categoryList: snap.data!.category.validate()),
                      24.height,
                      FeaturedServiceListComponent(serviceList: snap.data!.featuredServices.validate()),
                      ServiceListComponent(serviceList: snap.data!.service.validate()),
                      16.height,
                      CustomerRatingsComponent(reviewData: snap.data!.dashboardCustomerReview.validate()),
                    ],
                  );
                }
                return snapWidgetHelper(snap, loadingWidget: Offstage());
              },
            ),
            Observer(builder: (context) => LoaderWidget().visible(appStore.isLoading)),
          ],
        ),
      ),
    );
  }
}
