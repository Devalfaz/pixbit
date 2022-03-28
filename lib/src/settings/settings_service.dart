import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pixbit/src/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async => ThemeMode.system;

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
  }
  Future<String?> token() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
      try {
        String? token = prefs.getString("token");
        return token;
      } catch (e) {
        prefs.clear();
        return null;
      }
    }
    return null;
  }

  Future<void> updateUserToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token == null) {
      prefs.clear();
    } else {
      prefs.setString("token", token);
    }
  }
}
