import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/dialogue.dart';
import '../models/scientist.dart';
import '../models/cultural_challenge.dart';

class DataService {
  static const String _dialogueIndexPath = 'assets/data/dialogues/dialogue_index.json';
  static const String _scientistsPath = 'assets/data/scientists.json';
  static const String _challengesPath = 'assets/data/cultural_challenges.json';

  // Cache for loaded data
  List<Dialogue>? _dialogues;
  List<Scientist>? _scientists;
  List<CulturalChallenge>? _challenges;

  /// Load all dialogues from JSON files
  Future<List<Dialogue>> loadDialogues() async {
    if (_dialogues != null) {
      return _dialogues!;
    }

    try {
      // Load dialogue index
      final String indexString = await rootBundle.loadString(_dialogueIndexPath);
      final Map<String, dynamic> indexData = json.decode(indexString);

      List<Dialogue> allDialogues = [];

      // Load dialogues from each category and subcategory
      final categories = indexData['categories'] as List<dynamic>;
      for (final category in categories) {
        // Check if category has subcategories
        if (category.containsKey('subcategories')) {
          final subcategories = category['subcategories'] as List<dynamic>;
          for (final subcategory in subcategories) {
            final files = subcategory['files'] as List<dynamic>;
            for (final fileName in files) {
              final filePath = 'assets/data/dialogues/$fileName';
              try {
                final String jsonString = await rootBundle.loadString(filePath);
                final List<dynamic> jsonList = json.decode(jsonString);

                final dialogues = jsonList
                    .map((json) => Dialogue.fromJson(json as Map<String, dynamic>))
                    .toList();

                allDialogues.addAll(dialogues);
              } catch (e) {
                debugPrint('Warning: Failed to load dialogue file $fileName: $e');
                // Continue loading other files even if one fails
              }
            }
          }
        } else {
          // Legacy support: load files directly from category
          final files = category['files'] as List<dynamic>?;
          if (files != null) {
            for (final fileName in files) {
              final filePath = 'assets/data/dialogues/$fileName';
              try {
                final String jsonString = await rootBundle.loadString(filePath);
                final List<dynamic> jsonList = json.decode(jsonString);

                final dialogues = jsonList
                    .map((json) => Dialogue.fromJson(json as Map<String, dynamic>))
                    .toList();

                allDialogues.addAll(dialogues);
              } catch (e) {
                debugPrint('Warning: Failed to load dialogue file $fileName: $e');
                // Continue loading other files even if one fails
              }
            }
          }
        }
      }

      _dialogues = allDialogues;
      return _dialogues!;
    } catch (e) {
      debugPrint('Error loading dialogues: $e');
      // Return empty list if loading fails
      _dialogues = <Dialogue>[];
      return _dialogues!;
    }
  }

  /// Load all scientists from JSON file
  Future<List<Scientist>> loadScientists() async {
    if (_scientists != null) {
      return _scientists!;
    }

    try {
      final String jsonString = await rootBundle.loadString(_scientistsPath);
      final List<dynamic> jsonList = json.decode(jsonString);
      
      _scientists = jsonList
          .map((json) => Scientist.fromJson(json as Map<String, dynamic>))
          .toList();
      
      return _scientists!;
    } catch (e) {
      throw Exception('Failed to load scientists: $e');
    }
  }

  /// Load all cultural challenges from JSON file
  Future<List<CulturalChallenge>> loadChallenges() async {
    if (_challenges != null) {
      return _challenges!;
    }

    try {
      final String jsonString = await rootBundle.loadString(_challengesPath);
      final List<dynamic> jsonList = json.decode(jsonString);
      
      _challenges = jsonList
          .map((json) => CulturalChallenge.fromJson(json as Map<String, dynamic>))
          .toList();
      
      return _challenges!;
    } catch (e) {
      throw Exception('Failed to load challenges: $e');
    }
  }

  /// Get dialogues filtered by criteria
  Future<List<Dialogue>> getDialogues({
    DifficultyLevel? level,
    Language? language,
    Region? region,
    List<String>? tags,
  }) async {
    final dialogues = await loadDialogues();
    
    return dialogues.where((dialogue) {
      if (level != null && dialogue.level != level) return false;
      if (language != null && dialogue.language != language) return false;
      if (region != null && dialogue.region != region) return false;
      if (tags != null && tags.isNotEmpty) {
        final dialogueTags = dialogue.tags ?? [];
        if (!tags.any((tag) => dialogueTags.contains(tag))) return false;
      }
      return true;
    }).toList();
  }

  /// Get scientists filtered by field or tags
  Future<List<Scientist>> getScientists({
    String? field,
    List<String>? tags,
  }) async {
    final scientists = await loadScientists();
    
    return scientists.where((scientist) {
      if (field != null && !scientist.field.toLowerCase().contains(field.toLowerCase())) {
        return false;
      }
      if (tags != null && tags.isNotEmpty) {
        final scientistTags = scientist.tags ?? [];
        if (!tags.any((tag) => scientistTags.contains(tag))) return false;
      }
      return true;
    }).toList();
  }

  /// Get challenges filtered by type or tags
  Future<List<CulturalChallenge>> getChallenges({
    ChallengeType? type,
    List<String>? tags,
    int? minPoints,
    int? maxPoints,
  }) async {
    final challenges = await loadChallenges();
    
    return challenges.where((challenge) {
      if (type != null && challenge.type != type) return false;
      if (minPoints != null && challenge.points < minPoints) return false;
      if (maxPoints != null && challenge.points > maxPoints) return false;
      if (tags != null && tags.isNotEmpty) {
        final challengeTags = challenge.tags ?? [];
        if (!tags.any((tag) => challengeTags.contains(tag))) return false;
      }
      return true;
    }).toList();
  }

  /// Get a random dialogue based on criteria
  Future<Dialogue?> getRandomDialogue({
    DifficultyLevel? level,
    Language? language,
    Region? region,
  }) async {
    final dialogues = await getDialogues(
      level: level,
      language: language,
      region: region,
    );
    
    if (dialogues.isEmpty) return null;
    
    dialogues.shuffle();
    return dialogues.first;
  }

  /// Get a random challenge
  Future<CulturalChallenge?> getRandomChallenge({
    ChallengeType? type,
    List<String>? tags,
  }) async {
    final challenges = await getChallenges(type: type, tags: tags);
    
    if (challenges.isEmpty) return null;
    
    challenges.shuffle();
    return challenges.first;
  }

  /// Clear cache and reload data
  Future<void> refreshData() async {
    _dialogues = null;
    _scientists = null;
    _challenges = null;
    
    // Preload all data
    await Future.wait([
      loadDialogues(),
      loadScientists(),
      loadChallenges(),
    ]);
  }

  /// Get dialogue by ID
  Future<Dialogue?> getDialogueById(String id) async {
    final dialogues = await loadDialogues();
    try {
      return dialogues.firstWhere((dialogue) => dialogue.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get scientist by ID
  Future<Scientist?> getScientistById(String id) async {
    final scientists = await loadScientists();
    try {
      return scientists.firstWhere((scientist) => scientist.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get challenge by ID
  Future<CulturalChallenge?> getChallengeById(String id) async {
    final challenges = await loadChallenges();
    try {
      return challenges.firstWhere((challenge) => challenge.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get available regions from dialogues
  Future<List<Region>> getAvailableRegions() async {
    final dialogues = await loadDialogues();
    final regions = dialogues
        .where((d) => d.region != null)
        .map((d) => d.region!)
        .toSet()
        .toList();
    return regions;
  }

  /// Get available languages from dialogues
  Future<List<Language>> getAvailableLanguages() async {
    final dialogues = await loadDialogues();
    final languages = dialogues.map((d) => d.language).toSet().toList();
    return languages;
  }

  /// Get available difficulty levels from dialogues
  Future<List<DifficultyLevel>> getAvailableLevels() async {
    final dialogues = await loadDialogues();
    final levels = dialogues.map((d) => d.level).toSet().toList();
    return levels;
  }
}
