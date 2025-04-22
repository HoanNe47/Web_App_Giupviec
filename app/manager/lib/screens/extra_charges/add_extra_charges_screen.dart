import 'package:flutter/material.dart';
import 'package:spa_manager_flutter/components/back_widget.dart';
import 'package:spa_manager_flutter/components/price_widget.dart';
import 'package:spa_manager_flutter/main.dart';
import 'package:spa_manager_flutter/models/add_extra_charges_model.dart';
import 'package:spa_manager_flutter/screens/extra_charges/components/add_extra_charge_dialog.dart';
import 'package:spa_manager_flutter/utils/extensions/context_ext.dart';
import 'package:nb_utils/nb_utils.dart';

class AddExtraChargesScreen extends StatefulWidget {
  @override
  _AddExtraChargesScreenState createState() => _AddExtraChargesScreenState();
}

class _AddExtraChargesScreenState extends State<AddExtraChargesScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    afterBuildCreated(() async {
      bool? res = await showInDialog(
        context,
        contentPadding: EdgeInsets.zero,
        barrierDismissible: false,
        builder: (_) {
          return AddExtraChargesDialog();
        },
      );

      if (res ?? false) {
        setState(() {});
      }
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        context.translate.lblAddExtraCharges,
        backWidget: BackWidget(),
        showBack: true,
        textColor: white,
        color: context.primaryColor,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: white),
            onPressed: () async {
              bool? res = await showInDialog(
                context,
                contentPadding: EdgeInsets.zero,
                barrierDismissible: false,
                builder: (_) {
                  return AddExtraChargesDialog();
                },
              );

              if (res ?? false) {
                setState(() {});
              }
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: chargesList.length,
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        itemBuilder: (_, i) {
          AddExtraChargesModel data = chargesList[i];

          return Container(
            padding: EdgeInsets.all(12),
            decoration: boxDecorationRoundedWithShadow(16, backgroundColor: context.cardColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(context.translate.lblChargeName, style: secondaryTextStyle()),
                    Text(data.title.validate(), style: boldTextStyle()),
                  ],
                ),
                8.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(context.translate.lblPrice, style: secondaryTextStyle()),
                    Text(data.price.toString().validate(), style: boldTextStyle()),
                  ],
                ),
                8.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(context.translate.lblQuantity, style: secondaryTextStyle()),
                    Text(data.qty.toString().validate(), style: boldTextStyle()),
                  ],
                ),
                8.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(context.translate.lblTotalCharges, style: secondaryTextStyle()),
                    PriceWidget(price: '${data.price.validate() * data.qty.validate()}'.toDouble(), size: 18, color: textPrimaryColorGlobal, isBoldText: true),
                  ],
                ),
                8.height,
              ],
            ),
          ).paddingBottom(16);
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: AppButton(
          text: context.translate.lblAdd,
          color: context.primaryColor,
          onTap: () {
            if (chargesList.isNotEmpty) {
              toast(context.translate.lblSuccessFullyAddExtraCharges);
              finish(context, true);
            }
          },
        ),
      ),
    );
  }
}
