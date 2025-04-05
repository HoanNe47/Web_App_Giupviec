import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:spa_manager_flutter/components/app_widgets.dart';
import 'package:spa_manager_flutter/components/back_widget.dart';
import 'package:spa_manager_flutter/components/background_component.dart';
import 'package:spa_manager_flutter/main.dart';
import 'package:spa_manager_flutter/models/provider_subscription_model.dart';
import 'package:spa_manager_flutter/networks/rest_apis.dart';
import 'package:spa_manager_flutter/provider/subscription/components/subscription_widget.dart';
import 'package:spa_manager_flutter/utils/configs.dart';
import 'package:spa_manager_flutter/utils/extensions/context_ext.dart';
import 'package:nb_utils/nb_utils.dart';

class SubscriptionHistoryScreen extends StatefulWidget {
  @override
  _SubscriptionHistoryScreenState createState() => _SubscriptionHistoryScreenState();
}

class _SubscriptionHistoryScreenState extends State<SubscriptionHistoryScreen> {
  ScrollController scrollController = ScrollController();

  Future<List<ProviderSubscriptionModel>>? future;
  List<ProviderSubscriptionModel> subscriptionsList = [];

  int page = 1;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = getSubscriptionHistory(
      page: page,
      providerSubscriptionList: subscriptionsList,
      lastPageCallback: (b) {
        isLastPage = b;
      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context.translate.lblSubscriptionHistory, backWidget: BackWidget(), elevation: 0, color: primaryColor, textColor: Colors.white),
      body: Stack(
        children: [
          SnapHelperWidget<List<ProviderSubscriptionModel>>(
            future: future,
            loadingWidget: LoaderWidget(),
            onSuccess: (snap) {
              if (snap.isEmpty) return BackgroundComponent();
              return AnimatedListView(
                controller: scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(8),
                itemCount: snap.length,
                onNextPage: () {
                  if (!isLastPage) {
                    page++;
                    init();
                    setState(() {});
                  }
                },
                listAnimationType: ListAnimationType.Slide,
                slideConfiguration: SlideConfiguration(verticalOffset: 400),
                disposeScrollController: false,
                itemBuilder: (BuildContext context, index) {
                  return SubscriptionWidget(snap[index]);
                },
              );
            },
          ),
          Observer(
            builder: (context) => LoaderWidget().visible(appStore.isLoading),
          )
        ],
      ),
    );
  }
}
