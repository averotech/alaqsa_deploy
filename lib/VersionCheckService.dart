import 'package:package_info_plus/package_info_plus.dart';

class VersionCheckService {

  Future<bool> isAppOutdated(String latestVersion) async {

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version;
      return currentVersion != latestVersion; // Compare versions
    }
  }
