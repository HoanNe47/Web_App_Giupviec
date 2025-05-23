import 'package:giup_viec_nha_app_user_flutter/component/cached_image_widget.dart';
import 'package:giup_viec_nha_app_user_flutter/main.dart';
import 'package:giup_viec_nha_app_user_flutter/model/user_data_model.dart';
import 'package:giup_viec_nha_app_user_flutter/screens/chat/user_chat_screen.dart';
import 'package:giup_viec_nha_app_user_flutter/screens/chat/widget/last_messege_chat.dart';
import 'package:giup_viec_nha_app_user_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class UserItemWidget extends StatefulWidget {
  final String userUid;

  UserItemWidget({required this.userUid});

  @override
  State<UserItemWidget> createState() => _UserItemWidgetState();
}

class _UserItemWidgetState extends State<UserItemWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
      stream: userService.singleUser(widget.userUid),
      builder: (context, snap) {
        if (snap.hasData) {
          UserData data = snap.data!;

          return InkWell(
            onTap: () {
              UserChatScreen(receiverUser: data).launch(context, pageRouteAnimation: PageRouteAnimation.Fade, duration: 300.milliseconds);
            },
            child: Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  if (data.profileImage.validate().isEmpty)
                    Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(6),
                      color: context.primaryColor.withValues(alpha:0.2),
                      child: Text(data.displayName.validate()[0].validate().toUpperCase(), style: boldTextStyle(color: context.primaryColor)).center().fit(),
                    ).cornerRadiusWithClipRRect(50)
                  else
                    CachedImageWidget(url: data.profileImage.validate(), height: 40, circle: true, fit: BoxFit.cover),
                  16.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.firstName.validate() + " " + data.lastName.validate(),
                            style: boldTextStyle(),
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                          StreamBuilder<int>(
                            stream: chatServices.getUnReadCount(senderId: appStore.uid.validate(), receiverId: data.uid.validate()),
                            builder: (context, snap) {
                              if (snap.hasData) {
                                if (snap.data != 0) {
                                  return Container(
                                    height: 18,
                                    width: 18,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: primaryColor),
                                    child: Text(
                                      snap.data.validate().toString(),
                                      style: secondaryTextStyle(color: white),
                                      textAlign: TextAlign.center,
                                    ).center(),
                                  );
                                }
                              }
                              return Offstage();
                            },
                          ),
                        ],
                      ),
                      LastMessageChat(stream: chatServices.fetchLastMessageBetween(senderId: appStore.uid.validate(), receiverId: widget.userUid)),
                    ],
                  ).expand()
                ],
              ),
            ),
          );
        }
        if (snap.hasError) {
          return Offstage();
        }
        return Container(
          padding: EdgeInsets.all(16),
          child: Text(language.loadingChats, style: primaryTextStyle()),
        );
      },
    );
  }
}
