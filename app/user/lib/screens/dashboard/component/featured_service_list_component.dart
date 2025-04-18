import 'package:actcms_spa_flutter/component/view_all_label_component.dart';
import 'package:actcms_spa_flutter/main.dart';
import 'package:actcms_spa_flutter/model/service_data_model.dart';
import 'package:actcms_spa_flutter/screens/service/component/service_component.dart';
import 'package:actcms_spa_flutter/screens/service/search_list_screen.dart';
import 'package:actcms_spa_flutter/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class FeaturedServiceListComponent extends StatelessWidget {
  final List<ServiceData> serviceList;

  FeaturedServiceListComponent({required this.serviceList});

  @override
  Widget build(BuildContext context) {
    if (serviceList.isEmpty) return Offstage();

    return Container(
      padding: EdgeInsets.only(bottom: 16),
      width: context.width(),
      decoration: BoxDecoration(
        color: appStore.isDarkMode ? context.cardColor : context.primaryColor.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.height,
          ViewAllLabel(
            label: language.lblFeatured,
            list: serviceList,
            onTap: () {
              SearchListScreen(isFeatured: "1").launch(context);
            },
          ).paddingSymmetric(horizontal: 16),
          if (serviceList.isNotEmpty)
            HorizontalList(
              itemCount: serviceList.length,
              spacing: 16,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemBuilder: (context, index) => ServiceComponent(serviceData: serviceList[index], width: 280, isBorderEnabled: true),
            )
          else
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                children: [
                  Image.asset(notDataFoundImg, height: 126),
                  32.height,
                  Text(language.lblNoServicesFound, style: boldTextStyle()),
                ],
              ),
            ).center(),
        ],
      ),
    );
  }
}
