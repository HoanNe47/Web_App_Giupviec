import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spa_manager_flutter/components/app_widgets.dart';
import 'package:spa_manager_flutter/components/back_widget.dart';
import 'package:spa_manager_flutter/main.dart';
import 'package:spa_manager_flutter/models/user_data.dart';
import 'package:spa_manager_flutter/screens/chat/components/user_item_widget.dart';
import 'package:spa_manager_flutter/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        languages!.lblChat,
        textColor: white,
        showBack: Navigator.canPop(context),
        elevation: 3.0,
        backWidget: BackWidget(),
        color: context.primaryColor,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return await 2.seconds.delay;
        },
        child: PaginateFirestore(
          itemBuilder: (context, snap, index) {
            UserData contact = UserData.fromJson(snap[index].data() as Map<String, dynamic>);
            return UserItemWidget(userUid: contact.uid.validate());
          },
          physics: AlwaysScrollableScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 10),
          options: GetOptions(source: Source.serverAndCache),
          isLive: true,
          padding: EdgeInsets.only(left: 0, top: 8, right: 0, bottom: 0),
          itemsPerPage: PER_PAGE_CHAT_LIST_COUNT,
          separator: Divider(height: 0, indent: 82),
          shrinkWrap: true,
          // query: chatServices.fetchChatList(),
          query: chatServices.fetchChatListQuery(userId: appStore.uId.validate()),
          onEmpty: Text(languages!.noDataFound).center(),
          initialLoader: LoaderWidget(),
          itemBuilderType: PaginateBuilderType.listView,
          onError: (e) => Text(languages!.noDataFound).center(),
        ),
      ),
    );
  }
}
