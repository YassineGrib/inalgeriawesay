import 'package:json_annotation/json_annotation.dart';

part 'scientist.g.dart';

@JsonSerializable()
class Scientist {
  final String id;
  final String name;
  final String nameArabic;
  final String nameAmazigh;
  final String bio;
  final String bioArabic;
  final String bioAmazigh;
  final String field;
  final String birthYear;
  final String? deathYear;
  final String photoUrl;
  final List<String> achievements;
  final List<String> achievementsArabic;
  final List<String> achievementsAmazigh;
  final String? wikipediaUrl;
  final List<String>? tags;

  const Scientist({
    required this.id,
    required this.name,
    required this.nameArabic,
    required this.nameAmazigh,
    required this.bio,
    required this.bioArabic,
    required this.bioAmazigh,
    required this.field,
    required this.birthYear,
    this.deathYear,
    required this.photoUrl,
    required this.achievements,
    required this.achievementsArabic,
    required this.achievementsAmazigh,
    this.wikipediaUrl,
    this.tags,
  });

  factory Scientist.fromJson(Map<String, dynamic> json) =>
      _$ScientistFromJson(json);

  Map<String, dynamic> toJson() => _$ScientistToJson(this);

  @override
  String toString() {
    return 'Scientist(id: $id, name: $name, field: $field)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Scientist &&
        other.id == id &&
        other.name == name &&
        other.field == field;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ field.hashCode;
  }
}
