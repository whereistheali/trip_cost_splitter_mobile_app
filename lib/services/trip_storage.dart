import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/trip.dart';

class TripStorage {
  static const String _tripsKey = 'trip_history';

  static Future<void> saveTrip(Trip trip) async {
    final prefs = await SharedPreferences.getInstance();
    final trips = await getTrips();
    trips.insert(0, trip);

    final tripsJson = trips.map((t) => t.toJson()).toList();
    await prefs.setString(_tripsKey, jsonEncode(tripsJson));
  }

  static Future<List<Trip>> getTrips() async {
    final prefs = await SharedPreferences.getInstance();
    final tripsString = prefs.getString(_tripsKey);

    if (tripsString == null || tripsString.isEmpty) {
      return [];
    }

    final List<dynamic> tripsJson = jsonDecode(tripsString);
    return tripsJson.map((json) => Trip.fromJson(json)).toList();
  }

  static Future<void> deleteTrip(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final trips = await getTrips();
    trips.removeWhere((trip) => trip.id == id);

    final tripsJson = trips.map((t) => t.toJson()).toList();
    await prefs.setString(_tripsKey, jsonEncode(tripsJson));
  }

  static Future<void> clearAllTrips() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tripsKey);
  }
}
