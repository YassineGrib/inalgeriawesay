import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/dialogue.dart';

class ConversationService {
  static const String _baseAssetPath = 'assets/data/conversations';

  /// تحميل محادثة محددة من مجلد معين حسب اللغة
  static Future<Dialogue?> loadConversationByPath({
    required String folderPath,
    required Language language,
  }) async {
    try {
      // تحديد اسم الملف حسب المجلد
      String fileName = _getFileNameFromPath(folderPath);
      
      // بناء المسار الكامل للملف
      final fullPath = '$folderPath/$fileName.json';
      
      // تحميل الملف
      final String jsonString = await rootBundle.loadString(fullPath);
      final List<dynamic> jsonList = json.decode(jsonString);
      
      // البحث عن المحادثة المناسبة للغة المختارة
      for (final json in jsonList) {
        final dialogue = Dialogue.fromJson(json as Map<String, dynamic>);
        if (dialogue.language == language) {
          return dialogue;
        }
      }
      
      return null;
    } catch (e) {
      print('Error loading conversation from $folderPath: $e');
      return null;
    }
  }

  /// تحديد اسم الملف حسب مسار المجلد
  static String _getFileNameFromPath(String folderPath) {
    if (folderPath.contains('first_meetings')) {
      return 'first_meeting';
    } else if (folderPath.contains('acquaintance_reunions')) {
      return 'acquaintance_reunion';
    } else if (folderPath.contains('morning')) {
      return 'morning_greeting';
    } else if (folderPath.contains('evening')) {
      return 'evening_greeting';
    } else if (folderPath.contains('farewell')) {
      return 'farewell_greeting';
    } else if (folderPath.contains('phone')) {
      return 'phone_greeting';
    } else if (folderPath.contains('self_introduction')) {
      return 'self_introduction';
    } else if (folderPath.contains('airport')) {
      return 'airport_conversation';
    } else if (folderPath.contains('taxi')) {
      return 'taxi_ride';
    } else if (folderPath.contains('hotel_booking')) {
      return 'hotel_booking_conversation';
    } else if (folderPath.contains('accommodation_search')) {
      return 'accommodation_search_conversation';
    } else if (folderPath.contains('bus_station')) {
      return 'bus_station_conversation';
    } else if (folderPath.contains('metro_station')) {
      return 'metro_travel';
    } else if (folderPath.contains('restaurant')) {
      return 'restaurant_dining';
    } else if (folderPath.contains('street_help')) {
      return 'street_directions';
    } else if (folderPath.contains('job_interview')) {
      return 'job_application';
    } else if (folderPath.contains('post_office')) {
      return 'postal_services';
    } else if (folderPath.contains('hospital')) {
      return 'hospital_consultation';
    } else if (folderPath.contains('pharmacy')) {
      return 'pharmacy_medicine';
    } else if (folderPath.contains('police_station')) {
      return 'police_report';
    } else if (folderPath.contains('traditional_market')) {
      return 'market_shopping';
    } else if (folderPath.contains('grocery_store')) {
      return 'grocery_shopping';
    } else if (folderPath.contains('supermarket')) {
      return 'supermarket_shopping';
    } else if (folderPath.contains('butcher_shop')) {
      return 'meat_shopping';
    } else if (folderPath.contains('bakery')) {
      return 'bakery_shopping';
    } else if (folderPath.contains('school')) {
      return 'school_education';
    } else if (folderPath.contains('university')) {
      return 'university_life';
    } else if (folderPath.contains('gym')) {
      return 'gym_membership';
    } else if (folderPath.contains('library')) {
      return 'library_services';
    } else if (folderPath.contains('mosque')) {
      return 'mosque_visit';
    } else if (folderPath.contains('hammam')) {
      return 'hammam_experience';
    } else if (folderPath.contains('barber')) {
      return 'barber_services';
    } else if (folderPath.contains('cinema')) {
      return 'cinema_tickets';
    } else if (folderPath.contains('park')) {
      return 'park_conversation';
    } else {
      throw Exception('Unknown folder path: $folderPath');
    }
  }

  /// تحميل جميع المحادثات المتاحة من مجلد معين
  static Future<List<Dialogue>> loadAllConversationsFromPath(String folderPath) async {
    try {
      String fileName = _getFileNameFromPath(folderPath);
      final fullPath = '$folderPath/$fileName.json';
      
      final String jsonString = await rootBundle.loadString(fullPath);
      final List<dynamic> jsonList = json.decode(jsonString);
      
      return jsonList
          .map((json) => Dialogue.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error loading conversations from $folderPath: $e');
      return [];
    }
  }

  /// الحصول على قائمة اللغات المتاحة في مجلد معين
  static Future<List<Language>> getAvailableLanguages(String folderPath) async {
    try {
      final conversations = await loadAllConversationsFromPath(folderPath);
      return conversations.map((c) => c.language).toSet().toList();
    } catch (e) {
      print('Error getting available languages from $folderPath: $e');
      return [];
    }
  }
}
