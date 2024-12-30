import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateScreen extends StatelessWidget {
  final String latestVersion;

  const UpdateScreen({Key? key, required this.latestVersion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Required")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Show the version banner
          VersionBanner(
            latestVersion: latestVersion,
            updateLink: 'https://example.com/update', // Set the actual update URL
            onUpdatePressed: () async {
              // Open the update link in the browser
              if (await canLaunch('https://example.com/update')) {
                await launch('https://example.com/update');
              } else {
                throw 'Could not launch update URL';
              }
            },
          ),
        ],
      ),
    );
  }
}

class VersionBanner extends StatelessWidget {
  final String latestVersion;
  final String updateLink;
  final VoidCallback onUpdatePressed;

  const VersionBanner({
    Key? key,
    required this.latestVersion,
    required this.updateLink,
    required this.onUpdatePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.orangeAccent,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "A new version ($latestVersion) is available!",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          TextButton(
            onPressed: onUpdatePressed, // Use the passed callback
            child: Text(
              "Update",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
