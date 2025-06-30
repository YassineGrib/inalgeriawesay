// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cultural_challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChallengeOption _$ChallengeOptionFromJson(Map<String, dynamic> json) =>
    ChallengeOption(
      id: json['id'] as String,
      text: json['text'] as String,
      textArabic: json['textArabic'] as String,
      textAmazigh: json['textAmazigh'] as String,
      isCorrect: json['isCorrect'] as bool,
      explanation: json['explanation'] as String?,
    );

Map<String, dynamic> _$ChallengeOptionToJson(ChallengeOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'textArabic': instance.textArabic,
      'textAmazigh': instance.textAmazigh,
      'isCorrect': instance.isCorrect,
      'explanation': instance.explanation,
    };

CulturalChallenge _$CulturalChallengeFromJson(Map<String, dynamic> json) =>
    CulturalChallenge(
      id: json['id'] as String,
      title: json['title'] as String,
      titleArabic: json['titleArabic'] as String,
      titleAmazigh: json['titleAmazigh'] as String,
      description: json['description'] as String,
      descriptionArabic: json['descriptionArabic'] as String,
      descriptionAmazigh: json['descriptionAmazigh'] as String,
      type: $enumDecode(_$ChallengeTypeEnumMap, json['type']),
      question: json['question'] as String,
      questionArabic: json['questionArabic'] as String,
      questionAmazigh: json['questionAmazigh'] as String,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => ChallengeOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      correctAnswer: json['correctAnswer'] as String?,
      explanation: json['explanation'] as String?,
      explanationArabic: json['explanationArabic'] as String?,
      explanationAmazigh: json['explanationAmazigh'] as String?,
      points: (json['points'] as num).toInt(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      imageUrl: json['imageUrl'] as String?,
      audioUrl: json['audioUrl'] as String?,
    );

Map<String, dynamic> _$CulturalChallengeToJson(CulturalChallenge instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'titleArabic': instance.titleArabic,
      'titleAmazigh': instance.titleAmazigh,
      'description': instance.description,
      'descriptionArabic': instance.descriptionArabic,
      'descriptionAmazigh': instance.descriptionAmazigh,
      'type': _$ChallengeTypeEnumMap[instance.type]!,
      'question': instance.question,
      'questionArabic': instance.questionArabic,
      'questionAmazigh': instance.questionAmazigh,
      'options': instance.options,
      'correctAnswer': instance.correctAnswer,
      'explanation': instance.explanation,
      'explanationArabic': instance.explanationArabic,
      'explanationAmazigh': instance.explanationAmazigh,
      'points': instance.points,
      'tags': instance.tags,
      'imageUrl': instance.imageUrl,
      'audioUrl': instance.audioUrl,
    };

const _$ChallengeTypeEnumMap = {
  ChallengeType.multipleChoice: 'multiple_choice',
  ChallengeType.textInput: 'text_input',
  ChallengeType.scenario: 'scenario',
  ChallengeType.audioResponse: 'audio_response',
};
