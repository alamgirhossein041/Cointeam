// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:coinsnap/data/model/firestore/firestore_get_user_data.dart';
// import 'package:crypto/crypto.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:developer';

// abstract class IFirestoreGetUserDataHiveRepository<FirestoreGetUserDataModel> {
//   void firestoreGetUserData();
// }

// class FirestoreGetUserDataHiveRepositoryImpl implements IFirestoreGetUserDataHiveRepository<FirestoreGetUserDataModel> {
//   final IFirestoreGetUserDataHiveRepository<FirestoreGetUserDataModel> source;
//   final IFirestoreGetUserDataHiveRepository<FirestoreGetUserDataModel> cache;
//   final bool Function() hasConnection;
//   FirestoreGetUserDataHiveRepositoryImpl({
//     @required this.source,
//     @required this.cache,
//     @required this.hasConnection,
//   });

//   @override
//   Future<FirestoreGetUserDataModel> get(dynamic portfolioMap) async {
//     final cachedUser = await this.cache.firestoreGetUserData();

//     if (cachedUser != null) {
//       return cachedUser;
//     }

//     if (!this.hasConnection()) {
//       throw NoConnectionException();
//     }

//     final remoteUser = await this.source.firestoreGetUserData();
//     this.cache.add(remoteUser);

//     return remoteUser;
//   }

//   @override
//   Future<void> add(FirestoreGetUserDataModel object) async {
//     if (!this.hasConnection()) {
//       throw NoConnectionException();
//     }

//     await this.source.add(object);
//     await this.cache.add(object);
//   }


//   @override
//   firestoreGetUserData() {
//     log("hello? firestoreGetUserData1");

//     final firestoreInstance = FirebaseFirestore.instance;
//     final firebaseUser = FirebaseAuth.instance.currentUser;
//     log("hello? firestoreGetUserData2");

//     firestoreInstance.collection("Users")
//       .doc('Wtf2')
//       .get()
//       .then((querySnapshot) {
//         log("hello? firestoreGetUserData3");
        
//         log("hello? firestoreGetUserData4");
//         // log(result.data.toString());
//         Map<String, dynamic> data = querySnapshot.data();
//         // log(data.toString());
//         FirestoreGetUserDataModel firestoreGetUserDataModel = FirestoreGetUserDataModel.fromJson(data);
//         log(firestoreGetUserDataModel.portfolioMap.toString());
//       });

//   }
// }