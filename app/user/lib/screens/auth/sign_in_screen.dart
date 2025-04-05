import 'package:actcms_spa_flutter/component/back_widget.dart';
import 'package:actcms_spa_flutter/component/base_scaffold_body.dart';
import 'package:actcms_spa_flutter/main.dart';
import 'package:actcms_spa_flutter/network/rest_apis.dart';
import 'package:actcms_spa_flutter/screens/auth/forgot_password_screen.dart';
import 'package:actcms_spa_flutter/screens/auth/otp_login_screen.dart';
import 'package:actcms_spa_flutter/screens/auth/sign_up_screen.dart';
import 'package:actcms_spa_flutter/screens/dashboard/dashboard_screen.dart';
import 'package:actcms_spa_flutter/utils/colors.dart';
import 'package:actcms_spa_flutter/utils/common.dart';
import 'package:actcms_spa_flutter/utils/configs.dart';
import 'package:actcms_spa_flutter/utils/constant.dart';
import 'package:actcms_spa_flutter/utils/images.dart';
import 'package:actcms_spa_flutter/utils/model_keys.dart';
import 'package:actcms_spa_flutter/utils/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInScreen extends StatefulWidget {
  final bool? isFromDashboard;
  final bool? isFromServiceBooking;
  final bool returnExpected;

  SignInScreen({this.isFromDashboard, this.isFromServiceBooking, this.returnExpected = false});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  bool isRemember = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    isRemember = getBoolAsync(IS_REMEMBERED, defaultValue: true);
    if (isRemember) {
      emailCont.text = getStringAsync(USER_EMAIL);
      passwordCont.text = getStringAsync(USER_PASSWORD);
    } else {
      if (isIqonicProduct) {
        emailCont.text = DEFAULT_EMAIL;
        passwordCont.text = DEFAULT_PASS;
      }
    }
    afterBuildCreated(() {
      if (getStringAsync(PLAYERID).isEmpty) saveOneSignalPlayerId();
    });
  }

  //region Methods
  void loginUsers() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      hideKeyboard(context);

      await setValue(PLAYERID, '');

      await OneSignal.shared.getDeviceState().then((value) async {
        await setValue(PLAYERID, value!.userId);
      }).catchError(onError);

      var request = {
        UserKeys.email: emailCont.text.trim(),
        UserKeys.password: passwordCont.text.trim(),
        UserKeys.playerId: getStringAsync(PLAYERID, defaultValue: ""),
      };

      log("Login Request $request");

      appStore.setLoading(true);

      await loginUser(request).then((res) async {
        res.data!.password = passwordCont.text.trim();

        await userService.getUser(email: res.data!.email).then((value) async {
          res.data!.uid = value.uid.validate();

          if (res.data!.userType == LOGIN_TYPE_USER) {
            if (res.data != null) await saveUserData(res.data!);

            onLoginSuccessRedirection();
          } else {
            toast(language.cantLogin);
          }
        }).catchError((e) {
          if (e.toString() == USER_NOT_FOUND) {
            authService.registerUserWhenUserNotFound(context, res, passwordCont.text.trim());
          } else {
            appStore.setLoading(false);

            toast(e.toString());
          }
        });
      }).catchError((e) {
        appStore.setLoading(false);
        toast(e.toString());
      });

      appStore.setLoading(false);
    }
  }

  void googleSignIn() async {
    hideKeyboard(context);
    appStore.setLoading(true);

    await authService.signInWithGoogle().then((value) async {
      appStore.setLoading(false);

      onLoginSuccessRedirection();
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString());
    });
  }

  void otpSignIn() async {
    hideKeyboard(context);

    OTPLoginScreen().launch(context);
    /*appStore.setLoading(true);

    await showInDialog(
      context,
      contentPadding: EdgeInsets.zero,
      builder: (p0) => AppCommonDialog(title: language.lblOTPLogin, child: OTPDialog()),
    );

    appStore.setLoading(false);*/
  }

  void appleSign() async {
    appStore.setLoading(true);

    await authService.appleSignIn().then((value) async {
      appStore.setLoading(false);

      onLoginSuccessRedirection();
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString());
    });
  }

  void onLoginSuccessRedirection() {
    TextInput.finishAutofillContext();
    if (widget.isFromServiceBooking.validate() || widget.isFromDashboard.validate() || widget.returnExpected.validate()) {
      if (widget.isFromDashboard.validate()) {
        setStatusBarColor(context.primaryColor);
      }
      finish(context, true);
    } else {
      DashboardScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
    }
  }

  //endregion

  //region Widgets
  Widget _buildTopWidget() {
    return Container(
      child: Column(
        children: [
          Text("${language.lblLoginTitle}!", style: boldTextStyle(size: 24)).center(),
          16.height,
          Text(language.lblLoginSubTitle, style: primaryTextStyle(size: 16), textAlign: TextAlign.center).center().paddingSymmetric(horizontal: 32),
          32.height,
        ],
      ),
    );
  }

  Widget _buildFormWidget() {
    return AutofillGroup(
      child: Column(
        children: [
          AppTextField(
            textFieldType: TextFieldType.EMAIL,
            controller: emailCont,
            focus: emailFocus,
            nextFocus: passwordFocus,
            errorThisFieldRequired: language.requiredText,
            decoration: inputDecoration(context, labelText: language.hintEmailTxt),
            suffix: ic_message.iconImage(size: 10).paddingAll(14),
            autoFillHints: [AutofillHints.email],
          ),
          16.height,
          AppTextField(
            textFieldType: TextFieldType.PASSWORD,
            controller: passwordCont,
            focus: passwordFocus,
            suffixPasswordVisibleWidget: ic_show.iconImage(size: 10).paddingAll(14),
            suffixPasswordInvisibleWidget: ic_hide.iconImage(size: 10).paddingAll(14),
            errorThisFieldRequired: language.requiredText,
            decoration: inputDecoration(context, labelText: language.hintPasswordTxt),
            autoFillHints: [AutofillHints.password],
            onFieldSubmitted: (s) {
              loginUsers();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRememberWidget() {
    return Column(
      children: [
        8.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundedCheckBox(
              borderColor: context.primaryColor,
              checkedColor: context.primaryColor,
              isChecked: isRemember,
              text: language.rememberMe,
              textStyle: secondaryTextStyle(),
              size: 20,
              onTap: (value) async {
                await setValue(IS_REMEMBERED, isRemember);
                isRemember = !isRemember;
                setState(() {});
              },
            ),
            TextButton(
              onPressed: () {
                showInDialog(
                  context,
                  contentPadding: EdgeInsets.zero,
                  dialogAnimation: DialogAnimation.SLIDE_TOP_BOTTOM,
                  builder: (_) => ForgotPasswordScreen(),
                );
              },
              child: Text(
                language.forgotPassword,
                style: boldTextStyle(color: primaryColor, fontStyle: FontStyle.italic),
              ),
            ).flexible(),
          ],
        ),
        24.height,
        AppButton(
          text: language.lblSignInHere,
          color: primaryColor,
          textStyle: boldTextStyle(color: white),
          width: context.width() - context.navigationBarHeight,
          onTap: () {
            loginUsers();
          },
        ),
        16.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(language.doNotHaveAccount, style: secondaryTextStyle()),
            TextButton(
              onPressed: () {
                hideKeyboard(context);
                SignUpScreen().launch(context);
              },
              child: Text(
                language.txtCreateAccount,
                style: boldTextStyle(
                  color: primaryColor,
                  decoration: TextDecoration.underline,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            if (isAndroid) {
              launchUrl(Uri.parse('${getSocialMediaLink(LinkProvider.PLAY_STORE)}$PROVIDER_PACKAGE_NAME'), mode: LaunchMode.externalApplication);
            } else {
              commonLaunchUrl(IOS_LINK_FOR_PARTNER);
            }
          },
          child: Text(language.lblRegisterAsPartner, style: boldTextStyle(color: primaryColor)),
        )
      ],
    );
  }

  Widget _buildSocialWidget() {
    return Column(
      children: [
        20.height,
        Row(
          children: [
            Divider(color: context.dividerColor, thickness: 2).expand(),
            16.width,
            Text(language.lblOrContinueWith, style: secondaryTextStyle()),
            16.width,
            Divider(color: context.dividerColor, thickness: 2).expand(),
          ],
        ),
        24.height,
        AppButton(
          text: '',
          color: context.cardColor,
          padding: EdgeInsets.all(8),
          textStyle: boldTextStyle(),
          width: context.width() - context.navigationBarHeight,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: primaryColor.withOpacity(0.1),
                  boxShape: BoxShape.circle,
                ),
                child: GoogleLogoWidget(size: 18),
              ),
              Text(language.lblSignInWithGoogle, style: boldTextStyle(size: 14), textAlign: TextAlign.center).expand(),
            ],
          ),
          onTap: googleSignIn,
        ),
        16.height,
        AppButton(
          text: '',
          color: context.cardColor,
          padding: EdgeInsets.all(8),
          textStyle: boldTextStyle(),
          width: context.width() - context.navigationBarHeight,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: primaryColor.withOpacity(0.1),
                  boxShape: BoxShape.circle,
                ),
                child: ic_calling.iconImage(size: 20, color: primaryColor).paddingAll(4),
              ),
              Text(language.lblSignInWithOTP, style: boldTextStyle(size: 14), textAlign: TextAlign.center).expand(),
            ],
          ),
          onTap: otpSignIn,
        ),
        16.height,
        if (isIOS)
          AppButton(
            text: '',
            color: context.cardColor,
            padding: EdgeInsets.all(8),
            textStyle: boldTextStyle(),
            width: context.width() - context.navigationBarHeight,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: primaryColor.withOpacity(0.1),
                    boxShape: BoxShape.circle,
                  ),
                  child: Icon(Icons.apple),
                ),
                Text(language.lblSignInWithApple, style: boldTextStyle(size: 14), textAlign: TextAlign.center).expand(),
              ],
            ),
            onTap: appleSign,
          ),
      ],
    );
  }

  //endregion

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    if (widget.isFromServiceBooking.validate()) {
      setStatusBarColor(Colors.transparent, statusBarIconBrightness: Brightness.dark);
    }
    if (widget.isFromDashboard.validate()) {
      setStatusBarColor(Colors.transparent, statusBarIconBrightness: Brightness.dark);
    }
    setStatusBarColor(primaryColor, statusBarIconBrightness: Brightness.light);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.scaffoldBackgroundColor,
        leading: Navigator.of(context).canPop() ? BackWidget(iconColor: context.iconColor) : null,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: appStore.isDarkMode ? Brightness.light : Brightness.dark, statusBarColor: context.scaffoldBackgroundColor),
      ),
      body: Body(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (context.height() * 0.05).toInt().height,
                _buildTopWidget(),
                _buildFormWidget(),
                _buildRememberWidget(),
                if (!getBoolAsync(HAS_IN_REVIEW)) _buildSocialWidget(),
                30.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
