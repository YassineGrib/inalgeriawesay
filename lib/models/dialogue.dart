import 'package:json_annotation/json_annotation.dart';
import 'dialogue_line.dart';

part 'dialogue.g.dart';

enum DifficultyLevel {
  @JsonValue('beginner')
  beginner,
  @JsonValue('intermediate')
  intermediate,
  @JsonValue('advanced')
  advanced,
}

enum Language {
  @JsonValue('standard_arabic')
  standardArabic,
  @JsonValue('amazigh')
  amazigh,
  @JsonValue('eastern_dialect')
  easternDialect,
  @JsonValue('western_dialect')
  westernDialect,
  @JsonValue('northern_dialect')
  northernDialect,
  @JsonValue('southern_dialect')
  southernDialect,
}

enum Region {
  @JsonValue('north')
  north,
  @JsonValue('east')
  east,
  @JsonValue('west')
  west,
  @JsonValue('south')
  south,
}

@JsonSerializable()
class Dialogue {
  final String id;
  final DifficultyLevel level;
  final Language language;
  final Region? region;
  final String title;
  final String description;
  final String scenario;
  final List<DialogueLine> dialogue;
  final List<String>? tags;
  final String? backgroundImage;

  const Dialogue({
    required this.id,
    required this.level,
    required this.language,
    this.region,
    required this.title,
    required this.description,
    required this.scenario,
    required this.dialogue,
    this.tags,
    this.backgroundImage,
  });

  factory Dialogue.fromJson(Map<String, dynamic> json) =>
      _$DialogueFromJson(json);

  Map<String, dynamic> toJson() => _$DialogueToJson(this);

  @override
  String toString() {
    return 'Dialogue(id: $id, title: $title, level: $level, language: $language, region: $region)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Dialogue &&
        other.id == id &&
        other.level == level &&
        other.language == language &&
        other.region == region &&
        other.title == title;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        level.hashCode ^
        language.hashCode ^
        region.hashCode ^
        title.hashCode;
  }
}
