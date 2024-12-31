import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateVersion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateUpdateVersion();
  }
}

class StateUpdateVersion extends State<UpdateVersion> {
  @override
  Widget build(BuildContext context) {
    // Retrieve arguments from the route
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Extract the arguments with default fallback values
    final latestVersion = arguments?['latestVersion'] ?? '1.0.6';
    final updateLink = arguments?['updateLink'] ?? 'https://google.com';
    final isOutdated = arguments?['isOutdated'] ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text('تحديث التطبيق'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'يوجد إصدار جديد ($latestVersion) متوفر!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'يرجى تحديث التطبيق إلى أحدث إصدار للاستمرار.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // Try to launch the update link
                      if (await canLaunch(updateLink)) {
                        await launch(updateLink);
                        Navigator.of(context).pushReplacementNamed('SplashScreen');
                      } else {
                        // Handle error if the link cannot be launched
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Could not open the update link')),
                        );
                      }
                    },
                    child: Text('تحديث الآن'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Try to launch the update link
                        Navigator.of(context).pushReplacementNamed('SplashScreen');
                    },
                    child: Text('التحقق مرة أخرى'),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
