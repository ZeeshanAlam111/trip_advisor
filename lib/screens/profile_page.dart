// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ProfilePage extends StatefulWidget {
//   final String userId;
//
//   ProfilePage({required this.userId});
//
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   late Stream<DocumentSnapshot<Map<String, dynamic>>> _userDataStream;
//
//   @override
//   void initState() {
//     super.initState();
//     _userDataStream = FirebaseFirestore.instance
//         .collection('users')
//         .doc(widget.userId)
//         .snapshots();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//       stream: _userDataStream,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         }
//         if (!snapshot.hasData) {
//           return Text('No user data found.');
//         }
//
//         final userData = snapshot.data!.data();
//         final personalInfo = userData['personalInfo'];
//         final wishlist = userData['wishlist'];
//
//         return Scaffold(
//           appBar: AppBar(
//             title: Text('Profile Page'),
//           ),
//           body: Column(
//             children: [
//               ListTile(
//                 leading: Icon(Icons.person),
//                 title: Text(personalInfo['name']),
//               ),
//               ListTile(
//                 leading: Icon(Icons.email),
//                 title: Text(personalInfo['email']),
//               ),
//               ListTile(
//                 leading: Icon(Icons.location_on),
//                 title: Text(personalInfo['location']),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Wishlist',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: wishlist.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       leading: Icon(Icons.favorite),
//                       title: Text(wishlist[index]),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
