import 'package:actcms_spa_flutter/component/back_widget.dart';
import 'package:actcms_spa_flutter/component/background_component.dart';
import 'package:actcms_spa_flutter/main.dart';
import 'package:actcms_spa_flutter/model/dashboard_model.dart';
import 'package:actcms_spa_flutter/screens/dashboard/component/customer_rating_widget.dart';
import 'package:actcms_spa_flutter/utils/constant.dart';
import 'package:actcms_spa_flutter/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomerRatingScreen extends StatefulWidget {
  final List<DashboardCustomerReview> reviewData;

  CustomerRatingScreen({required this.reviewData});

  @override
  State<CustomerRatingScreen> createState() => _CustomerRatingScreenState();
}

class _CustomerRatingScreenState extends State<CustomerRatingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(language.lblReviewsOnServices, textColor: Colors.white, color: context.primaryColor, backWidget: BackWidget()),
      body: widget.reviewData.validate().isEmpty
          ? BackgroundComponent(text: language.lblNoRateYet, image: no_rating_bar)
          : AnimatedListView(
              padding: EdgeInsets.fromLTRB(8, 16, 8, 80),
              slideConfiguration: sliderConfigurationGlobal,
              itemCount: widget.reviewData.length,
              itemBuilder: (context, index) {
                return CustomerRatingWidget(
                  data: widget.reviewData[index],
                  onDelete: (data) {
                    widget.reviewData.remove(data);
                    setState(() {});
                  },
                );
              },
            ),
    );
  }
}
