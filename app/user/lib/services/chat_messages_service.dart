import 'dart:io';

import 'package:actcms_spa_flutter/model/chat_message_model.dart';
import 'package:actcms_spa_flutter/model/contact_model.dart';
import 'package:actcms_spa_flutter/model/user_data_model.dart';
import 'package:actcms_spa_flutter/utils/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path/path.dart';

import 'base_services.dart';

class ChatMessageService extends BaseService {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  CollectionReference? userRef;
  FirebaseStorage _storage = FirebaseStorage.instance;

  ChatMessageService() {
    ref = fireStore.collection(MESSAGES_COLLECTION);
    userRef = fireStore.collection(USER_COLLECTION);
  }

  Query chatMessagesWithPagination({String? senderId, required String receiverUserId}) {
    log('senderId " $senderId');
    log('receiverUserId " $receiverUserId');
    return ref!.doc(senderId).collection(receiverUserId).orderBy("createdAt", descending: true);
  }

  Future<DocumentReference> addMessage(ChatMessageModel data) async {
    var doc = await ref!.doc(data.senderId).collection(data.receiverId!).add(data.toJson());
    doc.update({'id': doc.id});
    return doc;
  }

  Future<void> addMessageToDb({required DocumentReference senderRef, required ChatMessageModel chatData, required UserData sender, UserData? receiverUser, File? image}) async {
    String imageUrl = '';

    if (image != null) {
      String fileName = basename(image.path);
      Reference storageRef = _storage.ref().child("$CHAT_DATA_IMAGES/${getStringAsync(USER_ID)}/$fileName");

      UploadTask uploadTask = storageRef.putFile(image);

      await uploadTask.then((e) async {
        await e.ref.getDownloadURL().then((value) async {
          imageUrl = value;
        }).catchError((e) {
          log(e);
        });
      }).catchError((e) {
        log(e);
      });
    }

    updateChatDocument(senderRef, image: image, imageUrl: imageUrl);

    userRef!.doc(chatData.senderId).update({"lastMessageTime": chatData.createdAt});
    addToContacts(senderId: chatData.senderId, receiverId: chatData.receiverId);

    DocumentReference receiverDoc = await ref!.doc(chatData.receiverId).collection(chatData.senderId!).add(chatData.toJson());

    updateChatDocument(receiverDoc, image: image, imageUrl: imageUrl);

    userRef!.doc(chatData.receiverId).update({"lastMessageTime": chatData.createdAt});
  }

  DocumentReference? updateChatDocument(DocumentReference data, {File? image, String? imageUrl}) {
    Map<String, dynamic> sendData = {'id': data.id};

    if (image != null) {
      sendData.putIfAbsent('photoUrl', () => imageUrl);
    }
    log(sendData);
    data.update(sendData);

    log("Data $sendData");
    return null;
  }

  DocumentReference getContactsDocument({String? of, String? forContact}) {
    return userRef!.doc(of).collection(CONTACT_COLLECTION).doc(forContact);
  }

  addToContacts({String? senderId, String? receiverId}) async {
    Timestamp currentTime = Timestamp.now();

    await addToSenderContacts(senderId, receiverId, currentTime);
    await addToReceiverContacts(senderId, receiverId, currentTime);
  }

  Future<void> addToSenderContacts(String? senderId, String? receiverId, currentTime) async {
    DocumentSnapshot senderSnapshot = await getContactsDocument(of: senderId, forContact: receiverId).get();

    if (!senderSnapshot.exists) {
      //does not exists
      ContactModel receiverContact = ContactModel(
        uid: receiverId,
        addedOn: currentTime,
      );

      await getContactsDocument(of: senderId, forContact: receiverId).set(receiverContact.toJson());
    }
  }

  Future<void> addToReceiverContacts(
    String? senderId,
    String? receiverId,
    currentTime,
  ) async {
    DocumentSnapshot receiverSnapshot = await getContactsDocument(of: receiverId, forContact: senderId).get();

    if (!receiverSnapshot.exists) {
      //does not exists
      ContactModel senderContact = ContactModel(
        uid: senderId,
        addedOn: currentTime,
      );
      await getContactsDocument(of: receiverId, forContact: senderId).set(senderContact.toJson());
    }
  }

  //Fetch User List

  Stream<QuerySnapshot> fetchContacts({String? userId}) {
    return userRef!.doc(userId).collection(CONTACT_COLLECTION).snapshots();
  }

  Stream<UserData> getUserDetailsById({String? id}) {
    return userRef!.where("uid", isEqualTo: id).limit(1).snapshots().map((event) {
      if (event.docs.length == 1) {
        return UserData.fromJson(event.docs.first.data() as Map<String, dynamic>);
      } else {
        throw USER_NOT_FOUND;
      }
    });
  }

  Stream<QuerySnapshot> fetchLastMessageBetween({required String senderId, required String receiverId}) {
    return ref!
        .doc(senderId.toString())
        .collection(receiverId.toString())
        .orderBy(
          "createdAt",
          descending: false,
        )
        .snapshots();
  }

  Future<void> clearAllMessages({String? senderId, required String receiverId}) async {
    final WriteBatch _batch = fireStore.batch();

    ref!.doc(senderId).collection(receiverId).get().then((value) {
      value.docs.forEach((document) {
        _batch.delete(document.reference);
      });

      return _batch.commit();
    }).catchError(log);
  }

  Future<void> deleteChat({String? senderId, required String receiverId}) async {
    ref!.doc(senderId).collection(receiverId).doc().delete();
    userRef!.doc(senderId).collection(CONTACT_COLLECTION).doc(receiverId).delete();
  }

  Future<void> deleteSingleMessage({String? senderId, required String receiverId, String? documentId}) async {
    try {
      ref!.doc(senderId).collection(receiverId).doc(documentId).delete();
    } on Exception catch (e) {
      log(e);
      throw 'Something went wrong';
    }
  }

  Future<void> setUnReadStatusToTrue({required String senderId, required String receiverId, String? documentId}) async {
    ref!.doc(senderId).collection(receiverId).where('isMessageRead', isEqualTo: false).get().then((value) {
      value.docs.forEach((element) {
        element.reference.update({
          'isMessageRead': true,
        });
      });
    });

    ref!.doc(receiverId).collection(senderId).where('isMessageRead', isEqualTo: false).get().then((value) {
      value.docs.forEach((element) {
        element.reference.update({
          'isMessageRead': true,
        });
      });
    });
  }

  Stream<int> getUnReadCount({String? senderId, required String receiverId, String? documentId}) {
    return ref!
        .doc(senderId.toString())
        .collection(receiverId)
        .where('isMessageRead', isEqualTo: false)
        .where('receiverId', isEqualTo: senderId)
        .snapshots()
        .map(
          (event) => event.docs.length,
        )
        .handleError((e) {
      return e;
    });
  }

  Query fetchChatListQuery({String? userId}) {
    log(userId);
    return userRef!.doc(userId).collection(CONTACT_COLLECTION);
  }
}
