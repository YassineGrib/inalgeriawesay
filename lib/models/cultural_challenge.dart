import 'package:json_annotation/json_annotation.dart';

part 'cultural_challenge.g.dart';

enum ChallengeType {
  @JsonValue('multiple_choice')
  multipleChoice,
  @JsonValue('text_input')
  textInput,
  @JsonValue('scenario')
  scenario,
  @JsonValue('audio_response')
  audioResponse,
}

@JsonSerializable()
class ChallengeOption {
  final String id;
  final String text;
  final String textArabic;
  final String textAmazigh;
  final bool isCorrect;
  final String? explanation;

  const ChallengeOption({
    required this.id,
    required this.text,
    required this.textArabic,
    required this.textAmazigh,
    required this.isCorrect,
    this.explanation,
  });

  factory ChallengeOption.fromJson(Map<String, dynamic> json) =>
      _$ChallengeOptionFromJson(json);

  Map<String, dynamic> toJson() => _$ChallengeOptionToJson(this);
}

@JsonSerializable()
class CulturalChallenge {
  final String id;
  final String title;
  final String titleArabic;
  final String titleAmazigh;
  final String description;
  final String descriptionArabic;
  final String descriptionAmazigh;
  final ChallengeType type;
  final String question;
  final String questionArabic;
  final String questionAmazigh;
  final List<ChallengeOption>? options;
  final String? correctAnswer;
  final String? explanation;
  final String? explanationArabic;
  final String? explanationAmazigh;
  final int points;
  final List<String>? tags;
  final String? imageUrl;
  final String? audioUrl;

  const CulturalChallenge({
    required this.id,
    required this.title,
    required this.titleArabic,
    required this.titleAmazigh,
    required this.description,
    required this.descriptionArabic,
    required this.descriptionAmazigh,
    required this.type,
    required this.question,
    required this.questionArabic,
    required this.questionAmazigh,
    this.options,
    this.correctAnswer,
    this.explanation,
    this.explanationArabic,
    this.explanationAmazigh,
    required this.points,
    this.tags,
    this.imageUrl,
    this.audioUrl,
  });

  factory CulturalChallenge.fromJson(Map<String, dynamic> json) =>
      _$CulturalChallengeFromJson(json);

  Map<String, dynamic> toJson() => _$CulturalChallengeToJson(this);

  @override
  String toString() {
    return 'CulturalChallenge(id: $id, title: $title, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CulturalChallenge &&
        other.id == id &&
        other.title == title &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ type.hashCode;
  }
}
