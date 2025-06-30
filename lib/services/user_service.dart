import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';

class UserService {
  static const String _userProfileKey = 'user_profile';
  static const String _completedDialoguesKey = 'completed_dialogues';
  static const String _completedChallengesKey = 'completed_challenges';
  static const String _userPointsKey = 'user_points';
  static const String _firstLaunchKey = 'first_launch';

  SharedPreferences? _prefs;

  /// Initialize SharedPreferences
  Future<void> init() async {
    try {
      _prefs ??= await SharedPreferences.getInstance();
    } catch (e) {
      // Handle SharedPreferences initialization error
      print('SharedPreferences initialization error: $e');
      // For now, we'll continue without SharedPreferences
      // In a production app, you might want to show an error dialog
    }
  }

  /// Save user profile
  Future<void> saveUserProfile(UserProfile profile) async {
    await init();
    if (_prefs == null) return;
    final jsonString = json.encode(profile.toJson());
    await _prefs!.setString(_userProfileKey, jsonString);
  }

  /// Load user profile
  Future<UserProfile?> loadUserProfile() async {
    await init();
    if (_prefs == null) return null;
    final jsonString = _prefs!.getString(_userProfileKey);

    if (jsonString == null) return null;

    try {
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return UserProfile.fromJson(jsonMap);
    } catch (e) {
      return null;
    }
  }

  /// Check if this is the first app launch
  Future<bool> isFirstLaunch() async {
    await init();
    if (_prefs == null) return true;
    return _prefs!.getBool(_firstLaunchKey) ?? true;
  }

  /// Mark that the app has been launched
  Future<void> setFirstLaunchComplete() async {
    await init();
    if (_prefs == null) return;
    await _prefs!.setBool(_firstLaunchKey, false);
  }

  /// Add completed dialogue
  Future<void> addCompletedDialogue(String dialogueId) async {
    await init();
    final completed = await getCompletedDialogues();
    if (!completed.contains(dialogueId)) {
      completed.add(dialogueId);
      await _prefs!.setStringList(_completedDialoguesKey, completed);
      
      // Update user profile
      final profile = await loadUserProfile();
      if (profile != null) {
        final updatedProfile = profile.copyWith(
          completedDialogues: completed.length,
          lastActiveAt: DateTime.now(),
        );
        await saveUserProfile(updatedProfile);
      }
    }
  }

  /// Get completed dialogues
  Future<List<String>> getCompletedDialogues() async {
    await init();
    return _prefs!.getStringList(_completedDialoguesKey) ?? [];
  }

  /// Add completed challenge
  Future<void> addCompletedChallenge(String challengeId, int points) async {
    await init();
    final completed = await getCompletedChallenges();
    if (!completed.contains(challengeId)) {
      completed.add(challengeId);
      await _prefs!.setStringList(_completedChallengesKey, completed);
      
      // Add points
      await addPoints(points);
      
      // Update user profile
      final profile = await loadUserProfile();
      if (profile != null) {
        final updatedProfile = profile.copyWith(
          completedChallenges: completed.length,
          lastActiveAt: DateTime.now(),
        );
        await saveUserProfile(updatedProfile);
      }
    }
  }

  /// Get completed challenges
  Future<List<String>> getCompletedChallenges() async {
    await init();
    return _prefs!.getStringList(_completedChallengesKey) ?? [];
  }

  /// Add points to user's total
  Future<void> addPoints(int points) async {
    await init();
    final currentPoints = await getTotalPoints();
    final newTotal = currentPoints + points;
    await _prefs!.setInt(_userPointsKey, newTotal);
    
    // Update user profile
    final profile = await loadUserProfile();
    if (profile != null) {
      final updatedProfile = profile.copyWith(
        totalPoints: newTotal,
        lastActiveAt: DateTime.now(),
      );
      await saveUserProfile(updatedProfile);
    }
  }

  /// Get total points
  Future<int> getTotalPoints() async {
    await init();
    return _prefs!.getInt(_userPointsKey) ?? 0;
  }

  /// Check if dialogue is completed
  Future<bool> isDialogueCompleted(String dialogueId) async {
    final completed = await getCompletedDialogues();
    return completed.contains(dialogueId);
  }

  /// Check if challenge is completed
  Future<bool> isChallengeCompleted(String challengeId) async {
    final completed = await getCompletedChallenges();
    return completed.contains(challengeId);
  }

  /// Get user progress statistics
  Future<Map<String, dynamic>> getUserStats() async {
    final profile = await loadUserProfile();
    final totalPoints = await getTotalPoints();
    final completedDialogues = await getCompletedDialogues();
    final completedChallenges = await getCompletedChallenges();
    
    return {
      'profile': profile,
      'totalPoints': totalPoints,
      'completedDialogues': completedDialogues.length,
      'completedChallenges': completedChallenges.length,
      'completedDialogueIds': completedDialogues,
      'completedChallengeIds': completedChallenges,
    };
  }

  /// Reset all user data
  Future<void> resetUserData() async {
    await init();
    await _prefs!.remove(_userProfileKey);
    await _prefs!.remove(_completedDialoguesKey);
    await _prefs!.remove(_completedChallengesKey);
    await _prefs!.remove(_userPointsKey);
    await _prefs!.setBool(_firstLaunchKey, true);
  }

  /// Update user's last active time
  Future<void> updateLastActive() async {
    final profile = await loadUserProfile();
    if (profile != null) {
      final updatedProfile = profile.copyWith(
        lastActiveAt: DateTime.now(),
      );
      await saveUserProfile(updatedProfile);
    }
  }

  /// Add favorite region
  Future<void> addFavoriteRegion(String region) async {
    final profile = await loadUserProfile();
    if (profile != null) {
      final favorites = List<String>.from(profile.favoriteRegions);
      if (!favorites.contains(region)) {
        favorites.add(region);
        final updatedProfile = profile.copyWith(favoriteRegions: favorites);
        await saveUserProfile(updatedProfile);
      }
    }
  }

  /// Remove favorite region
  Future<void> removeFavoriteRegion(String region) async {
    final profile = await loadUserProfile();
    if (profile != null) {
      final favorites = List<String>.from(profile.favoriteRegions);
      favorites.remove(region);
      final updatedProfile = profile.copyWith(favoriteRegions: favorites);
      await saveUserProfile(updatedProfile);
    }
  }

  /// Add preferred language
  Future<void> addPreferredLanguage(String language) async {
    final profile = await loadUserProfile();
    if (profile != null) {
      final preferred = List<String>.from(profile.preferredLanguages);
      if (!preferred.contains(language)) {
        preferred.add(language);
        final updatedProfile = profile.copyWith(preferredLanguages: preferred);
        await saveUserProfile(updatedProfile);
      }
    }
  }

  /// Remove preferred language
  Future<void> removePreferredLanguage(String language) async {
    final profile = await loadUserProfile();
    if (profile != null) {
      final preferred = List<String>.from(profile.preferredLanguages);
      preferred.remove(language);
      final updatedProfile = profile.copyWith(preferredLanguages: preferred);
      await saveUserProfile(updatedProfile);
    }
  }
}
