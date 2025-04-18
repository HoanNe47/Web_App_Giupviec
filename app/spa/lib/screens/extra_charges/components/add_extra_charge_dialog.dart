import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:spa_manager_flutter/main.dart';
import 'package:spa_manager_flutter/models/add_extra_charges_model.dart';
import 'package:spa_manager_flutter/utils/common.dart';
import 'package:spa_manager_flutter/utils/configs.dart';
import 'package:spa_manager_flutter/utils/extensions/context_ext.dart';
import 'package:nb_utils/nb_utils.dart';

class AddExtraChargesDialog extends StatefulWidget {
  @override
  _AddExtraChargesDialogState createState() => _AddExtraChargesDialogState();
}

class _AddExtraChargesDialogState extends State<AddExtraChargesDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleCont = TextEditingController();
  TextEditingController priceCont = TextEditingController();

  int qty = 1;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  void addCharges() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      AddExtraChargesModel data = AddExtraChargesModel();
      data.title = titleCont.text.validate();
      data.price = priceCont.text.toDouble().validate();
      data.qty = qty.validate();

      chargesList.add(data);
      finish(context, true);
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      color: Colors.transparent,
      child: Container(
        decoration: boxDecorationDefault(color: context.scaffoldBackgroundColor),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.width(),
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                  backgroundColor: primaryColor,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(context.translate.lblAddExtraChargesDetail, style: boldTextStyle(color: white)).paddingOnly(left: 16),
                    CloseButton(color: Colors.white),
                  ],
                ),
              ),
              16.height,
              Container(
                margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                padding: EdgeInsets.all(8),
                alignment: Alignment.bottomCenter,
                decoration: boxDecorationRoundedWithShadow(defaultRadius.toInt(), blurRadius: 0, backgroundColor: context.scaffoldBackgroundColor),
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(
                        textFieldType: TextFieldType.NAME,
                        controller: titleCont,
                        autoFocus: true,
                        validator: (s) {
                          if (s!.isEmpty)
                            return context.translate.lblRequired;
                          else
                            return null;
                        },
                        errorThisFieldRequired: context.translate.hintRequired,
                        decoration: inputDecoration(context, hint: context.translate.lblEnterExtraChargesDetail, fillColor: context.cardColor),
                      ),
                      16.height,
                      AppTextField(
                        textFieldType: TextFieldType.PHONE,
                        controller: priceCont,
                        autoFocus: true,
                        validator: (s) {
                          if (s!.isEmpty)
                            return context.translate.lblRequired;
                          else
                            return null;
                        },
                        errorThisFieldRequired: context.translate.hintRequired,
                        decoration: inputDecoration(context, hint: context.translate.lblEnterAmount, fillColor: context.cardColor),
                      ),
                      16.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(context.translate.lblQuantity, style: boldTextStyle()),
                          Container(
                            height: 40,
                            padding: EdgeInsets.all(8),
                            decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Feather.minus, size: 24).onTap(() {
                                  if (qty > 1) {
                                    qty = qty - 1;
                                  }
                                  setState(() {});
                                }),
                                16.width,
                                Text(qty.toString(), style: primaryTextStyle()),
                                16.width,
                                Icon(Icons.add, size: 24).onTap(() {
                                  qty = qty + 1;
                                  setState(() {});
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                      24.height,
                      AppButton(
                        text: context.translate.lblAdd,
                        color: primaryColor,
                        textStyle: primaryTextStyle(color: white),
                        width: context.width() - context.navigationBarHeight,
                        onTap: () {
                          addCharges();
                        },
                      ),
                      8.height,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
