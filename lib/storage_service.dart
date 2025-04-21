
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'entry_model.dart';

class StorageService {
  static const String key = 'mampfmonitor_entries';

  static Future<void> saveEntries(List<Entry> entries) async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(entries.map((e) => e.toJson()).toList());
    prefs.setString(key, data);
  }

  static Future<List<Entry>> loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    if (raw == null) return [];
    final List decoded = jsonDecode(raw);
    return decoded.map((e) => Entry.fromJson(e)).toList();
  }
}
