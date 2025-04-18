import 'package:actcms_spa_flutter/main.dart';
import 'package:actcms_spa_flutter/model/booking_detail_model.dart';
import 'package:actcms_spa_flutter/screens/booking/component/booking_history_list_widget.dart';
import 'package:actcms_spa_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingHistoryComponent extends StatefulWidget {
  final List<BookingActivity>? data;
  final ScrollController scrollController;

  BookingHistoryComponent({this.data, required this.scrollController});

  @override
  BookingHistoryComponentState createState() => BookingHistoryComponentState();
}

class BookingHistoryComponentState extends State<BookingHistoryComponent> {
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
      decoration: boxDecorationWithRoundedCorners(borderRadius: radius(20), backgroundColor: context.cardColor),
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        controller: widget.scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            8.height,
            Container(width: 40, height: 2, color: gray.withOpacity(0.3)).center(),
            24.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(language.bookingHistory, style: boldTextStyle(size: 18)),
                Row(
                  children: [
                    Text('${language.lblID}:', style: boldTextStyle(color: primaryColor)),
                    4.width,
                    Text(' #' + widget.data![0].bookingId.validate().toString(), style: boldTextStyle(color: primaryColor, size: 18)),
                  ],
                )
              ],
            ),
            16.height,
            Divider(),
            16.height,
            widget.data!.length != 0
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.data!.length,
                    itemBuilder: (_, i) {
                      BookingActivity data = widget.data![i];
                      return BookingHistoryListWidget(data: data, index: i, length: widget.data!.length.validate());
                    },
                  )
                : Text(language.noDataAvailable).center().paddingAll(16),
          ],
        ),
      ),
    );
  }
}
