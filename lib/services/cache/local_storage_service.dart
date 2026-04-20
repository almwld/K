import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();

  late SharedPreferences _prefs;
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      _prefs = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  // =========