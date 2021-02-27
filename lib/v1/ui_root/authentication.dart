// import 'package:coinsnap/v1/ui_root/template/home/home_view_real.dart';
// import 'package:coinsnap/v2/auth/fireauth.dart';
// import 'package:coinsnap/v2/helpers/colors_helper.dart';
// import 'package:coinsnap/v2/helpers/sizes_helper.dart';
// import 'package:data_connection_checker/data_connection_checker.dart';
// import 'package:flutter/material.dart';

// import 'dart:async';

// class AuthenticationV1 extends StatefulWidget {
//   AuthenticationV1({Key key}) : super(key: key);

//   @override
//   _AuthenticationV1State createState() => _AuthenticationV1State();
// }

// class _AuthenticationV1State extends State<AuthenticationV1> {
//   TextEditingController _emailField = TextEditingController();
//   TextEditingController _passwordField = TextEditingController();
                                                       
//   @override
//   void initState() {
//     super.initState();
//     CheckInternetV1().checkConnection(context);
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: displayWidth(context),
//         height: displayHeight(context),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topRight,
//             end: Alignment.bottomLeft,
//             colors: [appPink, Colors.blue]
//             /// temp colours
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextFormField(
//               controller: _emailField,
//               decoration: InputDecoration(
//                 /// hintText: "Dummy",
//                 hintStyle: TextStyle(
//                   color: Colors.white,
//                 ),
//                 labelText: "Email",
//                 labelStyle: TextStyle(
//                   color: Colors.white,
//                 )
//               ),
//               /// email address
//             ),
//             TextFormField(
//               /// password
//               controller: _passwordField,
//               decoration: InputDecoration(
//                 /// hintText: "No hints",
//                 hintStyle: TextStyle(
//                   color: Colors.white,
//                 ),
//                 labelText: "Password",
//                 labelStyle: TextStyle(
//                   color: Colors.white,
//                 )
//               ),
//               obscureText: true,
//             ),
//             SizedBox(
//               height: displayHeight(context) * 0.1,
//             ),
//             Container(
//               width: displayWidth(context) / 1.4,
//               height: 45,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15.0),
//                 color: Colors.white,
//               ),
//               child: MaterialButton(
//                 onPressed: () async {
//                   bool shouldNavigate = await register(_emailField.text, _passwordField.text);
//                   if(shouldNavigate) {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => HomeViewReal()));
//                   } else {
//                     print("error");
//                   }
//                 },
//                 child: Text("Register"),
//               ),
//             ),
//             SizedBox(
//               height: displayHeight(context) * 0.01,
//             ),
//             Container(
//               width: displayWidth(context) / 1.4,
//               height: 45,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15.0),
//                 color: Colors.white,
//               ),
//               child: MaterialButton(
//                 onPressed: () async {
//                   bool shouldNavigate = await signIn(_emailField.text, _passwordField.text);
//                   if(shouldNavigate) {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => HomeViewReal()));
//                   } else {
//                     print("error");
//                   }
//                 },
//                 child: Text("Login"),
//               ),
//             ),
//           ],
//         )
//       ),
//     );
//   }

//   // @override
//   // void dispose() {
//   //   CheckInternet().listener.cancel();
//   //   super.dispose();
//   // }
// }

// class CheckInternetV1 {

//   StreamSubscription<DataConnectionStatus> listener;
//   var internetStatus = "Unknown";
//   var contentMessage = "Unknown";

//   checkConnection(BuildContext context) async {
//     listener = DataConnectionChecker().onStatusChange.listen((status) {
//       switch (status) {
//         case DataConnectionStatus.connected:
//           // internetStatus = "Connected to the Internet";
//           // contentMessage = "Connected to the Internet";
//           // _showDialog(internetStatus, contentMessage, context);
//           break;
//         case DataConnectionStatus.disconnected:
//           internetStatus = "You are not connected to the Internet";
//           contentMessage = "Please check your connection to the Internet";
//           _showDialog(internetStatus, contentMessage, context);
//           break;
//       }
//     });
//     return await DataConnectionChecker().connectionStatus;
//   }
//   void closeStream() {
//   listener.cancel();
// }
// }

// void _showDialog(String title, String content, BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text("Error"),
//         content: Text(content),
//         actions: <Widget> [
//           FlatButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text("Close")
//           )
//         ]
//       );
//     }
//   );
// }

