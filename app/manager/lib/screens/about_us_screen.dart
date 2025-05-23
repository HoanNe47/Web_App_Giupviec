import 'package:flutter/material.dart';
import 'package:spa_manager_flutter/main.dart';
import 'package:spa_manager_flutter/models/about_model.dart';
import 'package:spa_manager_flutter/utils/common.dart';
import 'package:spa_manager_flutter/utils/data_provider.dart';
import 'package:spa_manager_flutter/utils/extensions/context_ext.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<AboutModel> aboutList = getAboutDataModel(context: context);

    return Scaffold(
      appBar: appBarWidget(
        context.translate.lblAbout,
        textColor: white,
        elevation: 0.0,
        backWidget: IconButton(
          icon: Icon(Icons.chevron_left, color: white, size: 32),
          onPressed: () {
            finish(context);
          },
        ),
        color: context.primaryColor,
      ),
      body: AnimatedWrap(
        spacing: 16,
        runSpacing: 16,
        itemCount: aboutList.length,
        scaleConfiguration: ScaleConfiguration(duration: 400.milliseconds, delay: 50.milliseconds),
        listAnimationType: ListAnimationType.Scale,
        itemBuilder: (context, index) {
          return Container(
            width: context.width() * 0.5 - 26,
            padding: EdgeInsets.all(16),
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: radius(),
              backgroundColor: context.cardColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(aboutList[index].image.toString(), height: 28, width: 28, color: context.iconColor),
                16.height,
                Text(aboutList[index].title.toString(), style: boldTextStyle(size: 18)),
              ],
            ),
          ).onTap(
            () async {
              if (index == 0) {
                checkIfLink(context, appStore.termConditions.validate(), title: context.translate.lblTermsAndConditions);
              } else if (index == 1) {
                checkIfLink(context, appStore.privacyPolicy.validate(), title: context.translate.lblPrivacyPolicy);
              } else if (index == 2) {
                checkIfLink(context, appStore.inquiryEmail.validate(), title: context.translate.lblHelpAndSupport);
              } else if (index == 3) {
                checkIfLink(context, appStore.helplineNumber.validate(), title: context.translate.lblHelpLineNum);
              } else if (index == 4) {
                {
                  String package = '';
                  if (isAndroid) package = await getPackageName();
                  commonLaunchUrl('${isAndroid ? playStoreBaseURL : appStoreBaseURL}$package', launchMode: LaunchMode.externalApplication);
                }
              }
            },
            borderRadius: radius(),
          );
        },
      ).paddingAll(16),
    );
  }
}
