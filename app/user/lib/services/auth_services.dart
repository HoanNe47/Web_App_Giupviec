import 'dart:convert';

import 'package:actcms_spa_flutter/main.dart';
import 'package:actcms_spa_flutter/model/login_model.dart';
import 'package:actcms_spa_flutter/model/user_data_model.dart';
import 'package:actcms_spa_flutter/network/rest_apis.dart';
import 'package:actcms_spa_flutter/utils/constant.dart';
import 'package:actcms_spa_flutter/utils/model_keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthServices {
  //region Google Login
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      //Authentication
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User user = authResult.user!;

      assert(!user.isAnonymous);

      final User currentUser = _auth.currentUser!;
      assert(user.uid == currentUser.uid);

      googleSignIn.signOut();

      String firstName = '';
      String lastName = '';
      if (currentUser.displayName
          .validate()
          .split(' ')
          .length >= 1) firstName = currentUser.displayName.splitBefore(' ');
      if (currentUser.displayName
          .validate()
          .split(' ')
          .length >= 2) lastName = currentUser.displayName.splitAfter(' ');

      Map req = {
        "email": currentUser.email,
        "first_name": firstName,
        "last_name": lastName,
        "username": (firstName + lastName).toLowerCase(),
        "profile_image": currentUser.photoURL,
        "social_image": currentUser.photoURL,
        "accessToken": googleSignInAuthentication.accessToken,
        "login_type": LOGIN_TYPE_GOOGLE,
        "user_type": LOGIN_TYPE_USER,
      };

      log("Google Login Json" + jsonEncode(req));

      await loginUser(req, isSocialLogin: true).then((value) async {
        await loginFromFirebaseUser(currentUser, loginData: value, displayName: currentUser.displayName.validate(), loginType: LOGIN_TYPE_GOOGLE);
      }).catchError((e) {
        log(e.toString());
        throw e;
      });
    } else {
      throw errorSomethingWentWrong;
    }
  }

  Future<void> loginFromFirebaseUser(User currentUser, {LoginResponse? loginData, String? displayName, String? loginType}) async {
    String uid = '';

    if (await userService.isUserExist(loginData!.data!.email)) {
      log("Firebase User Exist");

      await userService.userByEmail(loginData.data!.email).then((user) async {
        await saveUserData(loginData.data!);
      }).catchError((e) {
        log(e);
        throw e;
      });
    } else {
      log("Creating Firebase User");

      loginData.data!.uid = currentUser.uid.validate();
      loginData.data!.userType = LOGIN_TYPE_USER;
      loginData.data!.loginType = loginType;
      loginData.data!.playerId = getStringAsync(PLAYERID);
      if (isIOS) {
        loginData.data!.displayName = displayName;
      }

      await userService.addDocumentWithCustomId(currentUser.uid.validate(), loginData.data!.toJson()).then((value) async {
        log("Firebase User Created");
        await saveUserData(loginData.data!);
      }).catchError((e) {
        throw USER_NOT_CREATED;
      });
    }
  }

  //endregion

  //region Email
  Future<void> signUpWithEmailPassword(context, {required LoginResponse registerResponse, bool? isOTP, bool isLogin = true}) async {
    UserData? registerData = registerResponse.data!;

    UserCredential? userCredential = await _auth.createUserWithEmailAndPassword(email: registerData.email.validate(), password: registerData.password.validate()).catchError((e) async {
      await _auth.signInWithEmailAndPassword(email: registerData.email.validate(), password: registerData.password.validate()).then((value) {
        //
        setRegisterData(
          currentUser: value.user!,
          registerData: registerData,
          userModel: UserData(
            id: registerData.id.validate(),
            uid: value.user!.uid,
            apiToken: registerData.apiToken,
            contactNumber: registerData.contactNumber,
            displayName: registerData.displayName,
            email: registerData.email,
            firstName: registerData.firstName,
            lastName: registerData.lastName,
            userType: registerData.userType,
            username: registerData.username,
            password: registerData.password,
          ),
          isRegister: true,
        );
      }).catchError((e) {
        toast(e.toString());
      });

      log("Err ${e.toString()}");
    });
    if (userCredential.user != null) {
      User currentUser = userCredential.user!;
      String displayName = registerData.firstName.validate() + registerData.lastName.validate();

      UserData userModel = UserData()
        ..id = registerData.id.validate()
        ..apiToken = registerData.apiToken.validate()
        ..uid = currentUser.uid
        ..email = currentUser.email
        ..contactNumber = registerData.contactNumber
        ..firstName = registerData.firstName.validate()
        ..lastName = registerData.lastName.validate()
        ..username = registerData.username.validate()
        ..displayName = displayName
        ..userType = LOGIN_TYPE_USER
        ..loginType = getStringAsync(LOGIN_TYPE)
        ..createdAt = Timestamp.now().toDate().toString()
        ..updatedAt = Timestamp.now().toDate().toString()
        ..playerId = getStringAsync(PLAYERID);

      setRegisterData(currentUser: currentUser, registerData: registerData, userModel: userModel, isRegister: isLogin);
    }
  }

  Future<UserData> signInWithEmailPassword(context, {required UserData userData}) async {
    return await _auth.signInWithEmailAndPassword(email: userData.email.validate(), password: userData.password.validate()).then((value) async {
      final User user = value.user!;

      UserData userModel = await userService.getUser(email: user.email);
      await updateUserData(userModel);

      return userModel;
    }).catchError((e) {
      log(e.toString());

      throw USER_NOT_FOUND;
    });
  }

  //endregion

  //region Change password
  Future<void> changePassword(String newPassword) async {
    await _auth.currentUser!.updatePassword(newPassword).then((value) async {
      await setValue("PASSWORD", newPassword);
    });
  }

  //endregion

  //region Common Methods
  Future<void> updateUserData(UserData user) async {
    userService.updateDocument(
      {
        'player_id': getStringAsync(PLAYERID),
        'updatedAt': Timestamp.now(),
      },
      user.uid,
    );
  }

  Future<void> setRegisterData({required User currentUser, UserData? registerData, required UserData userModel, bool isRegister = true}) async {
    await appStore.setUserProfile(currentUser.photoURL.validate());

    if (isRegister) {
      await userService.addDocumentWithCustomId(currentUser.uid, userModel.toJson()).then((value) async {
        if (registerData != null) {
          // Login Request
          var request = {
            UserKeys.email: registerData.email.validate(),
            UserKeys.password: registerData.password.validate(),
            UserKeys.playerId: getStringAsync(PLAYERID),
          };

          // Calling Login API
          await loginUser(request).then((res) async {
            if (res.data!.userType == LOGIN_TYPE_USER) {
              // When Login is Successfully done and will redirect to HomeScreen.
              await saveUserData(res.data!);

              appStore.setLoggedIn(true);
              appStore.setLoading(false);
            }
          }).catchError((e) {
            toast("Please Login Again");
            appStore.setLoading(false);

            throw USER_CANNOT_LOGIN;
          });
        }
      }).catchError((e) {
        log(e.toString());
        appStore.setLoading(false);

        throw USER_NOT_CREATED;
      });
    } else {
      await saveUserData(userModel);
    }
  }

  //endregion

  //region OTP

  Future<String> loginWithOTP(String phoneNumber, {
    Function(String)? onVerificationIdReceived,
    Function(String)? onVerificationError,
  }) async {
    String id = '';

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        id = credential.verificationId.validate();

        onVerificationIdReceived?.call(id);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          toast('The provided phone number is not valid.');
          onVerificationError?.call('The provided phone number is not valid.');
        } else {
          toast(e.toString());
          onVerificationError?.call(e.toString());
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        id = verificationId;

        onVerificationIdReceived?.call(id);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        id = verificationId;

        onVerificationIdReceived?.call(id);
      },
    );

    return id;
  }

  Future<void> signUpWithOTP(context, UserData data) async {
    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: data.verificationId.validate(),
      smsCode: data.otpCode.validate(),
    );

    await _auth.signInWithCredential(credential).then((result) {
      if (result.user != null) {
        User currentUser = result.user!;
        UserData userModel = UserData();
        var displayName = data.firstName.validate() + data.lastName.validate();

        userModel.uid = currentUser.uid.validate();
        userModel.email = data.email.validate();
        userModel.contactNumber = data.contactNumber.validate();
        userModel.firstName = data.firstName.validate();
        userModel.lastName = data.lastName.validate();
        userModel.username = data.username.validate();
        userModel.displayName = displayName;
        userModel.userType = LOGIN_TYPE_USER;
        userModel.loginType = LOGIN_TYPE_OTP;
        userModel.createdAt = Timestamp.now().toDate().toString();
        userModel.updatedAt = Timestamp.now().toDate().toString();
        userModel.playerId = getStringAsync(PLAYERID);

        log("User ${userModel.toJson()}");

        setRegisterData(currentUser: currentUser, registerData: data, userModel: userModel, isRegister: true);
      }
    });
  }

  void registerUserWhenUserNotFound(BuildContext context, LoginResponse res, String password) async {
    UserData data = UserData(
      id: res.data!.id.validate(),
      apiToken: res.data!.apiToken.validate(),
      contactNumber: res.data!.contactNumber.validate(),
      displayName: res.data!.displayName.validate(),
      email: res.data!.email.validate(),
      firstName: res.data!.firstName.validate(),
      lastName: res.data!.lastName.validate(),
      userType: res.data!.userType.validate(),
      username: res.data!.username.validate(),
      password: password,
    );
    log(data.toJson());

    authService.signUpWithEmailPassword(context, registerResponse: LoginResponse(data: data), isLogin: false).then((value) {
      //
    }).catchError((e) {
      appStore.setLoading(false);

      log(e.toString());
    });
  }

//endregion

  // region Apple Sign
  Future<void> appleSignIn() async {
    if (await TheAppleSignIn.isAvailable()) {
      AuthorizationResult result = await TheAppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      switch (result.status) {
        case AuthorizationStatus.authorized:

          final appleIdCredential = result.credential!;
          final oAuthProvider = OAuthProvider('apple.com');
          final credential = oAuthProvider.credential(
            idToken: String.fromCharCodes(appleIdCredential.identityToken!),
            accessToken: String.fromCharCodes(appleIdCredential.authorizationCode!),
          );

          final authResult = await _auth.signInWithCredential(credential);
          final user = authResult.user!;

          log('User:- $user');

          if (result.credential!.email != null) {
            appStore.setLoading(true);

            await saveAppleData(result).then((value) {
              appStore.setLoading(false);
            }).catchError((e) {
              appStore.setLoading(false);
              throw e;
            });
          }

          await saveAppleDataWithoutEmail(user).then((value) {
            appStore.setLoading(false);
          }).catchError((e) {
            appStore.setLoading(false);
            throw e;
          });

          break;
        case AuthorizationStatus.error:
          throw ("Sign in failed: ${result.error!.localizedDescription}");
        case AuthorizationStatus.cancelled:
          throw ('User cancelled');
      }
    } else {
      throw language.lblAppleSignInNotAvailable;
    }
  }

  Future<void> saveAppleData(AuthorizationResult result) async {
    await setValue(APPLE_EMAIL, result.credential!.email);
    await setValue(APPLE_GIVE_NNAME, result.credential!.fullName!.givenName);
    await setValue(APPLE_FAMILY_NAME, result.credential!.fullName!.familyName);
  }

  Future<void> saveAppleDataWithoutEmail(User user) async {
    log('Email:- ${getStringAsync(APPLE_EMAIL)}');
    log('appleGivenName:- ${getStringAsync(APPLE_GIVE_NNAME)}');
    log('appleFamilyName:- ${getStringAsync(APPLE_FAMILY_NAME)}');

    var req = {
      'email': getStringAsync(APPLE_EMAIL),
      'first_name': getStringAsync(APPLE_GIVE_NNAME),
      'last_name': getStringAsync(APPLE_FAMILY_NAME),
      "username": ('${getStringAsync(APPLE_GIVE_NNAME)}' + '${getStringAsync(APPLE_FAMILY_NAME)}').toLowerCase(),
      "profile_image": '',
      "social_image": '',
      'accessToken': '12345678',
      'login_type': LOGIN_TYPE_APPLE,
      "user_type": LOGIN_TYPE_USER,
    };

    log("Apple Login Json" + jsonEncode(req));

    if (!getStringAsync(APPLE_EMAIL).isEmptyOrNull) {
      await loginUser(req, isSocialLogin: true).then((value) async {
        await loginFromFirebaseUser(user,loginData: value,displayName: value.data!.displayName.validate(),loginType: LOGIN_TYPE_APPLE);
      }).catchError((e) {
        log(e.toString());
        throw e;
      });
    } else {
      throw language.lblAddAppleIdEmail;
    }
  }

//endregion
}