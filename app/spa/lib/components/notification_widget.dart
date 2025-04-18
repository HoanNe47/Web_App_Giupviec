import 'package:flutter/material.dart';
import 'package:spa_manager_flutter/components/image_border_component.dart';
import 'package:spa_manager_flutter/main.dart';
import 'package:spa_manager_flutter/models/notification_list_response.dart';
import 'package:nb_utils/nb_utils.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationData data;

  NotificationWidget({required this.data});

  static String getTime(String inputString, String time) {
    List<String> wordList = inputString.split(" ");

    if (wordList.isNotEmpty) {
      return wordList[0] + ' ' + time;
    } else {
      return ' ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 8),
      decoration: boxDecorationDefault(
        color: data.readAt != null
            ? appStore.isDarkMode
                ? cardDarkColor
                : appStore.isDarkMode
                    ? context.cardColor
                    : context.cardColor
            : context.cardColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageBorder(src: data.profileImage.validate(), height: 60),
          16.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${data.data!.type.validate().split('_').join(' ').capitalizeFirstLetter()}',
                    style: boldTextStyle(size: 14),
                  ).expand(),
                  Text(data.createdAt.validate(), style: secondaryTextStyle(size: 12)),
                ],
              ),
              4.height,
              Text(data.data!.message!, style: secondaryTextStyle(), maxLines: 3, overflow: TextOverflow.ellipsis),
            ],
          ).expand(),
        ],
      ),
    );
  }
}
