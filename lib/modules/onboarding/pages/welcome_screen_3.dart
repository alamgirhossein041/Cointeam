// import 'package:coinsnap/modules/home/pages/home.dart';
// import 'package:coinsnap/modules/services/firebase_analytics.dart';
// import 'package:coinsnap/modules/widgets/api_link/modal_success.dart';
// import 'package:flutter/material.dart';
// import 'package:localstorage/localstorage.dart';

// class Third extends StatefulWidget {

//   @override
//   _ThirdState createState() => _ThirdState();
// }

// class _ThirdState extends State<Third> {
//   @override
//   void initState() { 
//     super.initState();
//     analytics.logEvent(
//       name: "api_binance"
//     );
//     final localStorage = LocalStorage("settings");
//     localStorage.setItem("currency", "USD");
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0xFF2B064B), Color(0xFF381AA2)]
//           ),
//         ),
//         child: ModalSuccess(
//           // icon: Icon(Icons.done, color: Colors.greenAccent, size: 55),
//           // title: "Binance Linked",
//           // body: Center(
//           //   child: Text(
//           //     "Congratulations!\n\nAll features of this app has been unlocked.",
//           //     style: Theme.of(context).textTheme.bodyText2,
//           //     textAlign: TextAlign.center,
//           //   ),
//           // ),
//           // actionButton: Center(
//           //   child: TextButton(
//           //     onPressed: () => {
//           //       writeStorage("welcome", "true"),
//           //       // future: readStorage("welcome"),
//           //       Navigator.pushReplacementNamed(context, '/home')
//           //     },
//           //     child: Text("Dashboard"),
//           //   ),
//           // )
//         ),
//       )
//     );
//   }
// }