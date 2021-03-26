// import 'package:flutter/material.dart';

// class DropdownButtonMenu extends StatefulWidget {
//   // DropdownButtonMenu({Key key}) : super(key: key);

//   @override
//   DropdownButtonMenuState createState() => DropdownButtonMenuState();
// }

// class DropdownButtonMenuState extends State<DropdownButtonMenu> {
//   String _selectedValue;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('DropDown'),
//       ),
//       body: Center(
//         child: Container(
//           padding: const EdgeInsets.all(0.0),
//           child: DropdownButton<String>(
//             value: _selectedValue,
//             //elevation: 5,
//             style: TextStyle(color: Colors.black),

//             items: <String>[
//               'Android',
//               'IOS',
//               'Flutter',
//               'Node',
//               'Java',
//               'Python',
//               'PHP',
//             ].map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//             hint: Text(
//               "Please choose a langauage",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600),
//             ),
//             onChanged: (String value) {
//               setState(() {
//                 _selectedValue = value;
//               });
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }