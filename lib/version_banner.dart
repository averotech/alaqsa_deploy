// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class VersionBanner extends StatelessWidget {
//   final String latestVersion; // The latest version
//   final String updateLink; // URL for the update
//   final VoidCallback onUpdatePressed; // Callback when update button is pressed
//
//   const VersionBanner({
//     Key? key,
//     required this.latestVersion,
//     required this.updateLink,
//     required this.onUpdatePressed,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       color: Colors.orangeAccent,
//       padding: EdgeInsets.all(10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "A new version ($latestVersion) is available!",
//             style: TextStyle(color: Colors.white, fontSize: 14),
//           ),
//           TextButton(
//             onPressed: onUpdatePressed, // Use the passed callback
//             child: Text(
//               "Update",
//               style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
