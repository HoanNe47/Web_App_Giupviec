import 'package:actcms_spa_flutter/app_theme.dart';
import 'package:actcms_spa_flutter/component/custom_stepper.dart';
import 'package:actcms_spa_flutter/component/loader_widget.dart';
import 'package:actcms_spa_flutter/main.dart';
import 'package:actcms_spa_flutter/model/service_detail_response.dart';
import 'package:actcms_spa_flutter/screens/map/map_screen.dart';
import 'package:actcms_spa_flutter/services/location_service.dart';
import 'package:actcms_spa_flutter/utils/colors.dart';
import 'package:actcms_spa_flutter/utils/common.dart';
import 'package:actcms_spa_flutter/utils/constant.dart';
import 'package:actcms_spa_flutter/utils/images.dart';
import 'package:actcms_spa_flutter/utils/permissions.dart';
import 'package:actcms_spa_flutter/utils/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingServiceStep1 extends StatefulWidget {
  final ServiceDetailResponse data;

  BookingServiceStep1({required this.data});

  @override
  _BookingServiceStep1State createState() => _BookingServiceStep1State();
}

class _BookingServiceStep1State extends State<BookingServiceStep1> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController dateTimeCont = TextEditingController();
  TextEditingController addressCont = TextEditingController();
  TextEditingController descriptionCont = TextEditingController();

  DateTime currentDateTime = DateTime.now();
  DateTime? selectedDate;
  DateTime? finalDate;
  TimeOfDay? pickedTime;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    if (widget.data.serviceDetail!.dateTimeVal != null) {
      dateTimeCont.text = formatDate(widget.data.serviceDetail!.dateTimeVal.validate(), format: DATE_FORMAT_1);
      addressCont.text = widget.data.serviceDetail!.address.validate();
      selectedDate = DateTime.parse(widget.data.serviceDetail!.dateTimeVal.validate());
      pickedTime = TimeOfDay.fromDateTime(selectedDate!);
    }
  }

  void selectDateAndTime(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: selectedDate ?? currentDateTime,
      firstDate: currentDateTime,
      lastDate: currentDateTime.add(30.days),
      locale: Locale(appStore.selectedLanguageCode),
      builder: (_, child) {
        return Theme(
          data: appStore.isDarkMode ? ThemeData.dark() : AppTheme.lightTheme(),
          child: child!,
        );
      },
    ).then((date) async {
      if (date != null) {
        await showTimePicker(
          context: context,
          initialTime: pickedTime ?? TimeOfDay.now(),
          builder: (_, child) {
            return Theme(
              data: appStore.isDarkMode ? ThemeData.dark() : AppTheme.lightTheme(),
              child: child!,
            );
          },
        ).then((time) {
          if (time != null) {
            finalDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);

            DateTime now = DateTime.now().subtract(1.minutes);
            if (date.isToday && finalDate!.millisecondsSinceEpoch < now.millisecondsSinceEpoch) {
              return toast('You cannot select booking time ahead of current time');
            }

            selectedDate = date;
            pickedTime = time;
            widget.data.serviceDetail!.dateTimeVal = finalDate.toString();
            dateTimeCont.text = "${formatDate(selectedDate.toString(), format: DATE_FORMAT_3)} ${pickedTime!.format(context).toString()}";
          }
        }).catchError((e) {
          toast(e.toString());
        });
      }
    });
  }

  void _handleSetLocationClick() {
    Permissions.cameraFilesAndLocationPermissionsGranted().then((value) async {
      await setValue(PERMISSION_STATUS, value);

      if (value) {
        String? res = await MapScreen(latitude: getDoubleAsync(LATITUDE), latLong: getDoubleAsync(LONGITUDE)).launch(context);

        if (res != null) {
          addressCont.text = res;
          setState(() {});
        }
      }
    });
  }

  void _handleCurrentLocationClick() {
    Permissions.cameraFilesAndLocationPermissionsGranted().then((value) async {
      await setValue(PERMISSION_STATUS, value);

      if (value) {
        appStore.setLoading(true);

        await getUserLocation().then((value) {
          addressCont.text = value;
          widget.data.serviceDetail!.address = value.toString();
          setState(() {});
        }).catchError((e) {
          log(e);
          toast(e.toString());
        });

        appStore.setLoading(false);
      }
    }).catchError((e) {
      //
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(language.lblStepper1Title, style: boldTextStyle(size: 20)),
                  32.height,
                  Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Container(
                      decoration: boxDecorationDefault(color: context.cardColor),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(language.lblDateAndTime, style: boldTextStyle()),
                          8.height,
                          AppTextField(
                            textFieldType: TextFieldType.OTHER,
                            controller: dateTimeCont,
                            isValidationRequired: true,
                            validator: (value) {
                              if (value!.isEmpty) return language.lblRequiredValidation;
                              return null;
                            },
                            readOnly: true,
                            onTap: () {
                              selectDateAndTime(context);
                            },
                            decoration: inputDecoration(context, prefixIcon: ic_calendar.iconImage(size: 10).paddingAll(14)).copyWith(
                              fillColor: context.scaffoldBackgroundColor,
                              filled: true,
                              hintText: language.lblEnterDateAndTime,
                              hintStyle: secondaryTextStyle(),
                            ),
                          ),
                          20.height,
                          Text(language.lblYourAddress, style: boldTextStyle()),
                          8.height,
                          AppTextField(
                            textFieldType: TextFieldType.MULTILINE,
                            controller: addressCont,
                            maxLines: 2,
                            onChanged: (s) {
                              log(s);
                            },
                            // minLines: 4,
                            onFieldSubmitted: (s) {
                              widget.data.serviceDetail!.address = s;
                            },
                            validator: (value) {
                              if (value!.isEmpty) return language.lblRequiredValidation;
                              return null;
                            },
                            isValidationRequired: true,
                            decoration: inputDecoration(
                              context,
                              prefixIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ic_location.iconImage(size: 22).paddingOnly(top: 8),
                                ],
                              ),
                            ).copyWith(
                              fillColor: context.scaffoldBackgroundColor,
                              filled: true,
                              hintText: language.lblEnterYourAddress,
                              hintStyle: secondaryTextStyle(),
                            ),
                          ),
                          8.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                child: Text(language.lblChooseFromMap, style: boldTextStyle(color: primaryColor, size: 13)),
                                onPressed: () {
                                  _handleSetLocationClick();
                                },
                              ).flexible(),
                              TextButton(
                                onPressed: _handleCurrentLocationClick,
                                child: Text(language.lblUseCurrentLocation, style: boldTextStyle(color: primaryColor, size: 13)),
                              ).flexible(),
                            ],
                          ),
                          16.height,
                          Text("${language.lblDescription}:", style: boldTextStyle()),
                          8.height,
                          AppTextField(
                            textFieldType: TextFieldType.MULTILINE,
                            controller: descriptionCont,
                            maxLines: 10,
                            minLines: 4,
                            onFieldSubmitted: (s) {
                              widget.data.serviceDetail!.bookingDescription = s;
                            },
                            decoration: inputDecoration(context).copyWith(
                              fillColor: context.scaffoldBackgroundColor,
                              filled: true,
                              hintText: language.lblEnterDescription,
                              hintStyle: secondaryTextStyle(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  16.height,
                  AppButton(
                    onTap: () {
                      hideKeyboard(context);
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        widget.data.provider!.description = descriptionCont.text;
                        widget.data.serviceDetail!.address = addressCont.text;
                        customStepperController.nextPage(duration: 200.milliseconds, curve: Curves.easeOut);
                      }
                    },
                    text: language.btnNext,
                    textColor: Colors.white,
                    width: context.width(),
                    color: context.primaryColor,
                  )
                ],
              ),
            ),
            Observer(builder: (context) => LoaderWidget().visible(appStore.isLoading))
          ],
        ),
      ),
    );
  }
}
