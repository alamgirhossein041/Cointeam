import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coinsnap/v1/data/model/firestore/firestore_get_user_data.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

abstract class IFirestoreGetUserDataRepository {
  // Future<List<BinanceSellCoinModel>> binanceSellCoin();
  // Future firestoreGetUserData();
  Future<Map> firestoreGetUserData();
}

class FirestoreGetUserDataRepositoryImpl implements IFirestoreGetUserDataRepository {

  @override
  Future<Map> firestoreGetUserData() async {
    FirestoreGetUserDataModel firestoreGetUserDataModel;
    log("hello? firestoreGetUserData1");

    final firestoreInstance = FirebaseFirestore.instance;
    final firebaseUser = FirebaseAuth.instance.currentUser;
    log("hello? firestoreGetUserData2");

    var querySnapshot = await firestoreInstance.collection("Users")
      .doc('Wtf2')
      .get();
      // .then((querySnapshot) {
    log("hello? firestoreGetUserData3");
    
    // log("hello? firestoreGetUserData4");
    // log(result.data.toString());
    Map<String, dynamic> data = querySnapshot.data();
    firestoreGetUserDataModel = FirestoreGetUserDataModel.fromJson(data);
    log(firestoreGetUserDataModel.portfolioMap.toString());
    return firestoreGetUserDataModel.portfolioMap;
      
    // return firestoreGetUserDataModel.portfolioMap;
  }
}