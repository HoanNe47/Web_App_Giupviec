import 'package:actcms_spa_flutter/component/image_border_component.dart';
import 'package:actcms_spa_flutter/model/service_detail_response.dart';
import 'package:actcms_spa_flutter/utils/common.dart';
import 'package:actcms_spa_flutter/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      Text(data.customerName.validate(), style: boldTextStyle(size: 14), maxLines: 1, overflow: TextOverflow.ellipsis).flexible(),
                      Row(
                        children: [
                          Image.asset('assets/icons/ic_star_fill.png', height: 14, fit: BoxFit.fitWidth, color: getRatingBarColor(data.rating.validate().toInt())),
                          4.width,
                          Text(data.rating.validate().toStringAsFixed(1).toString(), style: boldTextStyle(color: getRatingBarColor(data.rating.validate().toInt()), size: 14)),
                        ],
                      ),
                    ],
                  ),
                  data.createdAt.validate().isNotEmpty ? Text(formatDate(data.createdAt.validate(), format: DATE_FORMAT_4), style: secondaryTextStyle(size: 14)) : SizedBox(),
                  if (data.review.validate().isNotEmpty) Text(data.review.validate(), style: secondaryTextStyle()).paddingTop(8)
                ],
              ).flexible(),
            ],
          ),
        ],
      ),
    );
  }
}
