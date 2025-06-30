import 'package:flutter/material.dart';

enum CharacterType {
  elderlyMan,
  elderlyWoman,
  youngMan,
  youngWoman,
  child,
  scholar,
  artisan,
  merchant,
  farmer,
  nomad,
}

enum CharacterContext {
  greeting,
  market,
  wedding,
  religious,
  educational,
  storytelling,
  cooking,
  crafts,
  music,
  general,
}

class CulturalCharacter {
  final String id;
  final String name;
  final String nameArabic;
  final String nameAmazigh;
  final CharacterType type;
  final String description;
  final String descriptionArabic;
  final String descriptionAmazigh;
  final List<CharacterContext> contexts;
  final String? imageAsset;
  final Color primaryColor;
  final Color secondaryColor;
  final List<String> specialties;
  final Map<String, String> greetings;
  final Map<String, String> farewells;

  const CulturalCharacter({
    required this.id,
    required this.name,
    required this.nameArabic,
    required this.nameAmazigh,
    required this.type,
    required this.description,
    required this.descriptionArabic,
    required this.descriptionAmazigh,
    required this.contexts,
    this.imageAsset,
    required this.primaryColor,
    required this.secondaryColor,
    required this.specialties,
    required this.greetings,
    required this.farewells,
  });

  IconData get icon {
    switch (type) {
      case CharacterType.elderlyMan:
        return Icons.elderly;
      case CharacterType.elderlyWoman:
        return Icons.elderly;
      case CharacterType.youngMan:
        return Icons.person;
      case CharacterType.youngWoman:
        return Icons.person;
      case CharacterType.child:
        return Icons.child_care;
      case CharacterType.scholar:
        return Icons.school;
      case CharacterType.artisan:
        return Icons.handyman;
      case CharacterType.merchant:
        return Icons.store;
      case CharacterType.farmer:
        return Icons.agriculture;
      case CharacterType.nomad:
        return Icons.terrain;
    }
  }

  String getGreeting(String language) {
    return greetings[language] ?? greetings['english'] ?? 'Hello';
  }

  String getFarewell(String language) {
    return farewells[language] ?? farewells['english'] ?? 'Goodbye';
  }

  bool isAppropriateForContext(CharacterContext context) {
    return contexts.contains(context);
  }

  String getNameForLanguage(String language) {
    switch (language.toLowerCase()) {
      case 'arabic':
        return nameArabic;
      case 'amazigh':
        return nameAmazigh;
      default:
        return name;
    }
  }

  String getDescriptionForLanguage(String language) {
    switch (language.toLowerCase()) {
      case 'arabic':
        return descriptionArabic;
      case 'amazigh':
        return descriptionAmazigh;
      default:
        return description;
    }
  }

  @override
  String toString() {
    return 'CulturalCharacter(id: $id, name: $name, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CulturalCharacter &&
        other.id == id &&
        other.name == name &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ type.hashCode;
  }
}
