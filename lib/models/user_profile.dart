import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
  final String name;
  final int age;
  final String country;
  final DateTime createdAt;
  final DateTime? lastActiveAt;
  final int totalPoints;
  final int completedDialogues;
  final int completedChallenges;
  final List<String> favoriteRegions;
  final List<String> preferredLanguages;

  const UserProfile({
    required this.name,
    required this.age,
    required this.country,
    required this.createdAt,
    this.lastActiveAt,
    this.totalPoints = 0,
    this.completedDialogues = 0,
    this.completedChallenges = 0,
    this.favoriteRegions = const [],
    this.preferredLanguages = const [],
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  UserProfile copyWith({
    String? name,
    int? age,
    String? country,
    DateTime? createdAt,
    DateTime? lastActiveAt,
    int? totalPoints,
    int? completedDialogues,
    int? completedChallenges,
    List<String>? favoriteRegions,
    List<String>? preferredLanguages,
  }) {
    return UserProfile(
      name: name ?? this.name,
      age: age ?? this.age,
      country: country ?? this.country,
      createdAt: createdAt ?? this.createdAt,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      totalPoints: totalPoints ?? this.totalPoints,
      completedDialogues: completedDialogues ?? this.completedDialogues,
      completedChallenges: completedChallenges ?? this.completedChallenges,
      favoriteRegions: favoriteRegions ?? this.favoriteRegions,
      preferredLanguages: preferredLanguages ?? this.preferredLanguages,
    );
  }

  @override
  String toString() {
    return 'UserProfile(name: $name, age: $age, country: $country, totalPoints: $totalPoints)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserProfile &&
        other.name == name &&
        other.age == age &&
        other.country == country;
  }

  @override
  int get hashCode {
    return name.hashCode ^ age.hashCode ^ country.hashCode;
  }
}
