import 'package:flutter/material.dart';
import 'package:spa_manager_flutter/components/back_widget.dart';
import 'package:spa_manager_flutter/components/google_place_picker_dialog.dart';
import 'package:spa_manager_flutter/main.dart';
import 'package:spa_manager_flutter/networks/rest_apis.dart';
import 'package:spa_manager_flutter/utils/common.dart';
import 'package:spa_manager_flutter/utils/configs.dart';
import 'package:spa_manager_flutter/utils/model_keys.dart';
import 'package:nb_utils/nb_utils.dart';

class AddServiceAddressScreen extends StatefulWidget {
  @override
  _AddServiceAddressScreenState createState() => _AddServiceAddressScreenState();
}

class _AddServiceAddressScreenState extends State<AddServiceAddressScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController addressNameCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void saveAddress() async {
    appStore.setLoading(true);

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      hideKeyboard(context);
      Map req = {
        AddAddressKey.id: '',
        AddAddressKey.providerId: appStore.userId,
        AddAddressKey.status: '1',
        AddAddressKey.address: addressNameCont.text,
      };
      await getLatLongFromAddress(address: addressNameCont.text).then((value) async {
        req.putIfAbsent(AddAddressKey.latitude, () => value.latitude.toString());
        req.putIfAbsent(AddAddressKey.longitude, () => value.longitude.toString());
      }).catchError((e) {
        toast(e.toString());
      });

      log(req);

      await addAddresses(req).then((value) {
        appStore.setLoading(false);

        finish(context);
      }).catchError((e) {
        appStore.setLoading(false);
        toast(e.toString(), print: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        languages!.lblServiceAddress,
        textColor: white,
        showBack: true,
        backWidget: BackWidget(),
        color: context.primaryColor,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextField(
                    textFieldType: TextFieldType.MULTILINE,
                    controller: addressNameCont,
                    validator: (s) {
                      if (s!.isEmpty)
                        return errorThisFieldRequired;
                      else
                        return null;
                    },
                    maxLines: 5,
                    readOnly: true,
                    onTap: () {
                      showInDialog(context, builder: (_) => GooglePlacePickerDialog()).then((value) {
                        if (value != null) {
                          addressNameCont.text = value.toString().trim();
                        }
                      });
                    },
                    minLines: 2,
                    decoration: inputDecoration(context, hint: languages!.hintAddress),
                  ),
                  24.height,
                  AppButton(
                    text: languages!.hintAdd,
                    height: 40,
                    color: primaryColor,
                    textStyle: primaryTextStyle(color: white),
                    width: context.width() - context.navigationBarHeight,
                    onTap: () async {
                      saveAddress(); /*
                      ifNotTester(context, () {
                        saveAddress();
                      });*/
                    },
                  ),
                ],
              ).paddingSymmetric(horizontal: 16, vertical: 24),
            ),
          ),
        ],
      ),
    );
  }
}
