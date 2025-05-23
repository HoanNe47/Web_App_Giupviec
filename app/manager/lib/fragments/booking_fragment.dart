import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:spa_manager_flutter/components/app_widgets.dart';
import 'package:spa_manager_flutter/components/background_component.dart';
import 'package:spa_manager_flutter/components/booking_item_component.dart';
import 'package:spa_manager_flutter/components/booking_status_dropdown.dart';
import 'package:spa_manager_flutter/main.dart';
import 'package:spa_manager_flutter/models/booking_list_response.dart';
import 'package:spa_manager_flutter/models/booking_status_response.dart';
import 'package:spa_manager_flutter/networks/rest_apis.dart';
import 'package:spa_manager_flutter/utils/constant.dart';
import 'package:spa_manager_flutter/utils/model_keys.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class BookingFragment extends StatefulWidget {
  String? statusType;

  BookingFragment({this.statusType});

  @override
  BookingFragmentState createState() => BookingFragmentState();
}

class BookingFragmentState extends State<BookingFragment> with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();

  int page = 1;
  List<BookingData> mainList = [];

  String selectedValue = 'All';
  bool isLastPage = false;
  bool hasError = false;
  bool isApiCalled = false;

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      init();
    });
  }

  void init() async {
    LiveStream().on(LIVESTREAM_HANDY_BOARD, (index) {
      if (index == 1) {
        selectedValue = BookingStatusKeys.accept;
        fetchAllBookingList(status: selectedValue);
      }
    });
    LiveStream().on(LIVESTREAM_HANDYMAN_ALL_BOOKING, (index) {
      if (index == 1) {
        selectedValue = '';
        fetchAllBookingList(status: selectedValue);
      }
    });

    LiveStream().on(LIVESTREAM_UPDATE_BOOKINGS, (p0) {
      page = 1;
      fetchAllBookingList(status: selectedValue);
    });

    if (widget.statusType.validate().isNotEmpty) {
      selectedValue = widget.statusType.validate();
    }

    fetchAllBookingList(status: selectedValue, loading: true);
  }

  Future<void> fetchAllBookingList({required String status, bool loading = true}) async {
    appStore.setLoading(loading);

    await getBookingList(page, status: status).then((value) {
      appStore.setLoading(false);
      isApiCalled = true;

      if (page == 1) {
        mainList.clear();
      }
      mainList.addAll(value.data.validate());
      selectedValue = status;

      isLastPage = value.pagination?.totalPages == page;

      setState(() {});
    }).catchError((e) {
      appStore.setLoading(false);
      isApiCalled = true;

      toast(e.toString(), print: true);
      setState(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    LiveStream().dispose(LIVESTREAM_UPDATE_BOOKINGS);
    LiveStream().dispose(LIVESTREAM_HANDY_BOARD);
    // LiveStream().dispose(LIVESTREAM_HANDYMAN_ALL_BOOKING);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.width(),
        height: context.height(),
        child: Stack(
          children: [
            if (mainList.isNotEmpty)
              AnimatedListView(
                controller: scrollController,
                onSwipeRefresh: () async {
                  page = 1;
                  return await fetchAllBookingList(status: selectedValue, loading: false);
                },
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: mainList.length,
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                slideConfiguration: SlideConfiguration(verticalOffset: 400, delay: 50.milliseconds),
                itemBuilder: (_, index) => BookingItemComponent(bookingData: mainList[index], index: index),
                //disposeScrollController: false,
                onNextPage: () {
                  if (!isLastPage) {
                    page++;
                    fetchAllBookingList(status: selectedValue);
                  }
                },
              ).paddingOnly(left: 0, right: 0, bottom: 0, top: 76),
            Positioned(
              left: 16,
              right: 16,
              top: 16,
              child: BookingStatusDropdown(
                isValidate: false,
                statusType: selectedValue,
                onValueChanged: (BookingStatusResponse value) {
                  page = 1;

                  if (mainList.isNotEmpty) {
                    scrollController.animateTo(0, duration: 1.seconds, curve: Curves.easeOutQuart);
                  } else {
                    scrollController = ScrollController();
                  }
                  fetchAllBookingList(status: value.value.toString(), loading: true);
                },
              ),
            ),
            Observer(
              builder: (_) => BackgroundComponent().center().visible(!appStore.isLoading && mainList.validate().isEmpty && isApiCalled),
            ),
            Observer(
              builder: (context) => LoaderWidget().visible(appStore.isLoading),
            )
          ],
        ),
      ),
    );
  }
}
