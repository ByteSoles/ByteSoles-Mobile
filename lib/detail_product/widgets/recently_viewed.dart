import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

class RecentlyViewedManager {
  static const String _key = 'recently_viewed';
  static const int _maxItems = 4; // Show maximum 4 items

  static Future<void> addItem(int sneakerId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> items = prefs.getStringList(_key) ?? [];

    // Remove if already exists (to move it to the end)
    items.remove(sneakerId.toString());

    // Add to end of list
    items.add(sneakerId.toString());

    // Keep only the last _maxItems
    if (items.length > _maxItems) {
      items = items.sublist(items.length - _maxItems);
    }

    await prefs.setStringList(_key, items);
  }

  static Future<List<int>> getItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> items = prefs.getStringList(_key) ?? [];
    return items.map((e) => int.parse(e)).toList().reversed.toList();
  }

  static Future<void> clearItems() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
