import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stillmad/core/constants/app_constants.dart';

class PrivacyService extends ChangeNotifier {
  bool _privacyModeEnabled = true;
  bool _loaded = false;

  bool get privacyModeEnabled => _privacyModeEnabled;
  bool get loaded => _loaded;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _privacyModeEnabled =
        prefs.getBool(AppConstants.privacyModeKey) ?? _privacyModeEnabled;
    _loaded = true;
    notifyListeners();
  }

  Future<void> setPrivacyMode(bool enabled) async {
    _privacyModeEnabled = enabled;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.privacyModeKey, enabled);
  }
}
