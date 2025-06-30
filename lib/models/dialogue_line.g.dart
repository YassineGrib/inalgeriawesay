// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialogue_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DialogueLine _$DialogueLineFromJson(Map<String, dynamic> json) => DialogueLine(
  character: json['character'] as String,
  text: json['text'] as String,
  translation: json['translation'] as String,
  culturalNote: json['culturalNote'] as String?,
  audioFile: json['audioFile'] as String?,
);

Map<String, dynamic> _$DialogueLineToJson(DialogueLine instance) =>
    <String, dynamic>{
      'character': instance.character,
      'text': instance.text,
      'translation': instance.translation,
      'culturalNote': instance.culturalNote,
      'audioFile': instance.audioFile,
    };
