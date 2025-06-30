import 'package:json_annotation/json_annotation.dart';

part 'dialogue_line.g.dart';

@JsonSerializable()
class DialogueLine {
  final String character;
  final String text;
  final String translation;
  final String? culturalNote;
  final String? audioFile;

  const DialogueLine({
    required this.character,
    required this.text,
    required this.translation,
    this.culturalNote,
    this.audioFile,
  });

  factory DialogueLine.fromJson(Map<String, dynamic> json) =>
      _$DialogueLineFromJson(json);

  Map<String, dynamic> toJson() => _$DialogueLineToJson(this);

  @override
  String toString() {
    return 'DialogueLine(character: $character, text: $text, translation: $translation)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DialogueLine &&
        other.character == character &&
        other.text == text &&
        other.translation == translation &&
        other.culturalNote == culturalNote &&
        other.audioFile == audioFile;
  }

  @override
  int get hashCode {
    return character.hashCode ^
        text.hashCode ^
        translation.hashCode ^
        culturalNote.hashCode ^
        audioFile.hashCode;
  }
}
