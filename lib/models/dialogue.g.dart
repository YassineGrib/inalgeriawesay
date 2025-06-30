// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialogue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dialogue _$DialogueFromJson(Map<String, dynamic> json) => Dialogue(
  id: json['id'] as String,
  level: $enumDecode(_$DifficultyLevelEnumMap, json['level']),
  language: $enumDecode(_$LanguageEnumMap, json['language']),
  region: $enumDecodeNullable(_$RegionEnumMap, json['region']),
  title: json['title'] as String,
  description: json['description'] as String,
  scenario: json['scenario'] as String,
  dialogue: (json['dialogue'] as List<dynamic>)
      .map((e) => DialogueLine.fromJson(e as Map<String, dynamic>))
      .toList(),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  backgroundImage: json['backgroundImage'] as String?,
);

Map<String, dynamic> _$DialogueToJson(Dialogue instance) => <String, dynamic>{
  'id': instance.id,
  'level': _$DifficultyLevelEnumMap[instance.level]!,
  'language': _$LanguageEnumMap[instance.language]!,
  'region': _$RegionEnumMap[instance.region],
  'title': instance.title,
  'description': instance.description,
  'scenario': instance.scenario,
  'dialogue': instance.dialogue,
  'tags': instance.tags,
  'backgroundImage': instance.backgroundImage,
};

const _$DifficultyLevelEnumMap = {
  DifficultyLevel.beginner: 'beginner',
  DifficultyLevel.intermediate: 'intermediate',
  DifficultyLevel.advanced: 'advanced',
};

const _$LanguageEnumMap = {
  Language.standardArabic: 'standard_arabic',
  Language.amazigh: 'amazigh',
  Language.easternDialect: 'eastern_dialect',
  Language.westernDialect: 'western_dialect',
  Language.northernDialect: 'northern_dialect',
  Language.southernDialect: 'southern_dialect',
};

const _$RegionEnumMap = {
  Region.north: 'north',
  Region.east: 'east',
  Region.west: 'west',
  Region.south: 'south',
};
