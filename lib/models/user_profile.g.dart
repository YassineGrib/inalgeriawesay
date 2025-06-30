// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
  name: json['name'] as String,
  age: (json['age'] as num).toInt(),
  country: json['country'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  lastActiveAt: json['lastActiveAt'] == null
      ? null
      : DateTime.parse(json['lastActiveAt'] as String),
  totalPoints: (json['totalPoints'] as num?)?.toInt() ?? 0,
  completedDialogues: (json['completedDialogues'] as num?)?.toInt() ?? 0,
  completedChallenges: (json['completedChallenges'] as num?)?.toInt() ?? 0,
  favoriteRegions:
      (json['favoriteRegions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  preferredLanguages:
      (json['preferredLanguages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'country': instance.country,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastActiveAt': instance.lastActiveAt?.toIso8601String(),
      'totalPoints': instance.totalPoints,
      'completedDialogues': instance.completedDialogues,
      'completedChallenges': instance.completedChallenges,
      'favoriteRegions': instance.favoriteRegions,
      'preferredLanguages': instance.preferredLanguages,
    };
