import 'package:flutter/material.dart';
import 'package:spa_manager_flutter/components/spin_kit_chasing_dots.dart';
import 'package:spa_manager_flutter/models/booking_list_response.dart';
import 'package:spa_manager_flutter/utils/common.dart';
import 'package:spa_manager_flutter/utils/configs.dart';
import 'package:spa_manager_flutter/utils/constant.dart';
import 'package:spa_manager_flutter/utils/extensions/context_ext.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

Widget placeHolderWidget({String? placeHolderImage, double? height, double? width, BoxFit? fit, AlignmentGeometry? alignment}) {
  return PlaceHolderWidget(
    height: height,
    width: width,
    alignment: alignment ?? Alignment.center,
  );
}

String commonPrice(num price) {
  var formatter = NumberFormat('#,##,000.00');
  return formatter.format(price);
}

class LoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitChasingDots(color: primaryColor);
  }
}

Widget aboutCustomerWidget({BuildContext? context, BookingData? bookingDetail}) {
  return Row(
    children: [
      //AboutCustomer
      Text(context!.translate.lblAboutCustomer, style: boldTextStyle(size: LABEL_TEXT_SIZE)).expand(),
      Align(
        alignment: Alignment.topRight,
        child: OutlinedButton(
          child: Text(context.translate.lblGetDirection, style: boldTextStyle(color: primaryColor)),
          onPressed: () {
            commonLaunchUrl('$GOOGLE_MAP_PREFIX${Uri.encodeFull(bookingDetail!.address.validate())}', launchMode: LaunchMode.externalApplication);
          },
        ),
      ),
    ],
  );
}
