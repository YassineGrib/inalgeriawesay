// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scientist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scientist _$ScientistFromJson(Map<String, dynamic> json) => Scientist(
  id: json['id'] as String,
  name: json['name'] as String,
  nameArabic: json['nameArabic'] as String,
  nameAmazigh: json['nameAmazigh'] as String,
  bio: json['bio'] as String,
  bioArabic: json['bioArabic'] as String,
  bioAmazigh: json['bioAmazigh'] as String,
  field: json['field'] as String,
  birthYear: json['birthYear'] as String,
  deathYear: json['deathYear'] as String?,
  photoUrl: json['photoUrl'] as String,
  achievements: (json['achievements'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  achievementsArabic: (json['achievementsArabic'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  achievementsAmazigh: (json['achievementsAmazigh'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  wikipediaUrl: json['wikipediaUrl'] as String?,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$ScientistToJson(Scientist instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'nameArabic': instance.nameArabic,
  'nameAmazigh': instance.nameAmazigh,
  'bio': instance.bio,
  'bioArabic': instance.bioArabic,
  'bioAmazigh': instance.bioAmazigh,
  'field': instance.field,
  'birthYear': instance.birthYear,
  'deathYear': instance.deathYear,
  'photoUrl': instance.photoUrl,
  'achievements': instance.achievements,
  'achievementsArabic': instance.achievementsArabic,
  'achievementsAmazigh': instance.achievementsAmazigh,
  'wikipediaUrl': instance.wikipediaUrl,
  'tags': instance.tags,
};
