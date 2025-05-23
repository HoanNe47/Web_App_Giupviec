import 'package:giup_viec_nha_app_user_flutter/component/image_border_component.dart';
import 'package:giup_viec_nha_app_user_flutter/main.dart';
import 'package:giup_viec_nha_app_user_flutter/model/service_detail_response.dart';
import 'package:giup_viec_nha_app_user_flutter/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/images.dart';

class ReviewWidget extends StatelessWidget {
  final RatingData data;
  final bool isCustomer;

  ReviewWidget({required this.data, this.isCustomer = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(16),
      width: context.width(),
      decoration: boxDecorationDefault(color: context.cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ImageBorder(
                src: isCustomer ? data.customerProfileImage.validate() : data.profileImage.validate(),
                height: 50,
              ),
              16.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(data.customerName.validate(), style: boldTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis).flexible(),
                      Container(
                        decoration: BoxDecoration(
                          color: appStore.isDarkMode ? Colors.black : Colors.white,
                          borderRadius: radius(5)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                          child: Row(
                            children: [
                              Image.asset(ic_star_fill, height: 12, fit: BoxFit.fitWidth, color: getRatingBarColor(data.rating.validate().toInt())),
                              4.width,
                              Text(data.rating.validate().toStringAsFixed(1).toString(), style: boldTextStyle(color: getRatingBarColor(data.rating.validate().toInt()), size: 12)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  4.height,
                  data.createdAt.validate().isNotEmpty ? Text(formatDate(data.createdAt.validate()), style: secondaryTextStyle()) : SizedBox(),
                ],
              ).flexible(),
            ],
          ),
          if (data.review.validate().isNotEmpty)
            ReadMoreText(
              data.review.validate(),
              style: secondaryTextStyle(),
              trimLength: 100,
              colorClickableText: context.primaryColor,
            ).paddingTop(8),
        ],
      ),
    );
  }
}
