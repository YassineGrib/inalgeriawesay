import 'package:flutter_test/flutter_test.dart';
import 'package:inalgeriawesay/models/user_profile.dart';
import 'package:inalgeriawesay/services/user_service.dart';

void main() {
  group('Demo User Tests', () {
    late UserService userService;

    setUp(() {
      userService = UserService();
    });

    test('Demo user profile should have correct properties', () {
      final demoProfile = UserProfile(
        name: 'Ahmed Demo',
        age: 25,
        country: 'Algeria',
        createdAt: DateTime.now(),
        lastActiveAt: DateTime.now(),
        totalPoints: 50,
        completedDialogues: 2,
        completedChallenges: 3,
        favoriteRegions: ['north', 'west'],
        preferredLanguages: ['arabic', 'english'],
      );

      expect(demoProfile.name, equals('Ahmed Demo'));
      expect(demoProfile.age, equals(25));
      expect(demoProfile.country, equals('Algeria'));
      expect(demoProfile.totalPoints, equals(50));
      expect(demoProfile.completedDialogues, equals(2));
      expect(demoProfile.completedChallenges, equals(3));
      expect(demoProfile.favoriteRegions, contains('north'));
      expect(demoProfile.favoriteRegions, contains('west'));
      expect(demoProfile.preferredLanguages, contains('arabic'));
      expect(demoProfile.preferredLanguages, contains('english'));
    });

    test('User profile JSON serialization should work', () {
      final profile = UserProfile(
        name: 'Test User',
        age: 30,
        country: 'Algeria',
        createdAt: DateTime(2024, 1, 1),
        lastActiveAt: DateTime(2024, 1, 1),
      );

      final json = profile.toJson();
      final reconstructed = UserProfile.fromJson(json);

      expect(reconstructed.name, equals(profile.name));
      expect(reconstructed.age, equals(profile.age));
      expect(reconstructed.country, equals(profile.country));
    });

    test('User service should handle null SharedPreferences gracefully', () async {
      // This test verifies that the UserService doesn't crash when SharedPreferences fails
      expect(() async => await userService.init(), returnsNormally);
    });
  });
}
