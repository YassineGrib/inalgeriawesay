import '../models/cultural_character.dart';
import '../constants/app_colors.dart';

class CharacterService {
  static final CharacterService _instance = CharacterService._internal();
  factory CharacterService() => _instance;
  CharacterService._internal();

  late final List<CulturalCharacter> _characters;
  bool _initialized = false;

  List<CulturalCharacter> get characters {
    if (!_initialized) {
      _initializeCharacters();
    }
    return _characters;
  }

  void _initializeCharacters() {
    _characters = [
      // Elderly Man - Traditional Storyteller
      CulturalCharacter(
        id: 'elderly_man_storyteller',
        name: 'Hadj Ahmed',
        nameArabic: 'الحاج أحمد',
        nameAmazigh: 'Aḥmed Aḥaj',
        type: CharacterType.elderlyMan,
        description: 'A wise elderly man who knows the old stories and traditions of Algeria',
        descriptionArabic: 'رجل مسن حكيم يعرف القصص القديمة وتقاليد الجزائر',
        descriptionAmazigh: 'Argaz ameqqran d amussnaw yessen tiqsitin tiqburin d iẓuran n Lezzayer',
        contexts: [
          CharacterContext.storytelling,
          CharacterContext.educational,
          CharacterContext.religious,
          CharacterContext.general,
        ],
        imageAsset: 'assets/images/elderly_man_traditional.png',
        primaryColor: AppColors.algerianGreen,
        secondaryColor: AppColors.goldAccent,
        specialties: [
          'Traditional stories',
          'Historical knowledge',
          'Religious guidance',
          'Cultural wisdom',
        ],
        greetings: {
          'english': 'Peace be upon you, my child',
          'arabic': 'السلام عليكم يا ولدي',
          'amazigh': 'Azul fell-ak a mmi',
        },
        farewells: {
          'english': 'May Allah protect you',
          'arabic': 'الله يحفظك',
          'amazigh': 'Rebbi ad ak-iḥeṛṛes',
        },
      ),

      // Elderly Woman - Traditional Cook and Wedding Expert
      CulturalCharacter(
        id: 'elderly_woman_cook',
        name: 'Lalla Fatima',
        nameArabic: 'لالة فاطمة',
        nameAmazigh: 'Lalla Faṭima',
        type: CharacterType.elderlyWoman,
        description: 'A traditional cook and wedding ceremony expert who preserves culinary heritage',
        descriptionArabic: 'طباخة تقليدية وخبيرة في حفلات الزفاف تحافظ على التراث الطبخي',
        descriptionAmazigh: 'Tanebbaḥt taẓurant d tmussnawt n tmeɣriwin i yettḥeṛṛsen azref n useksu',
        contexts: [
          CharacterContext.cooking,
          CharacterContext.wedding,
          CharacterContext.educational,
          CharacterContext.general,
        ],
        imageAsset: 'assets/images/elderly_woman_traditional.png',
        primaryColor: AppColors.algerianRed,
        secondaryColor: AppColors.goldAccent,
        specialties: [
          'Traditional cooking',
          'Wedding ceremonies',
          'Family traditions',
          'Herbal remedies',
        ],
        greetings: {
          'english': 'Welcome, dear one',
          'arabic': 'أهلاً وسهلاً يا عزيزي',
          'amazigh': 'Ansuf yis-ek a aziz',
        },
        farewells: {
          'english': 'Go in safety',
          'arabic': 'روح بالسلامة',
          'amazigh': 'Ruḥ s taslamt',
        },
      ),

      // Young Scholar - Modern Educator
      CulturalCharacter(
        id: 'young_scholar',
        name: 'Youssef',
        nameArabic: 'يوسف',
        nameAmazigh: 'Yusuf',
        type: CharacterType.scholar,
        description: 'A young scholar bridging traditional knowledge with modern education',
        descriptionArabic: 'عالم شاب يربط بين المعرفة التقليدية والتعليم الحديث',
        descriptionAmazigh: 'Amussnaw ameẓyan i yesdukklen tamusni taqburt d usegmi amaynut',
        contexts: [
          CharacterContext.educational,
          CharacterContext.general,
          CharacterContext.storytelling,
        ],
        imageAsset: 'assets/images/young_scholar.png',
        primaryColor: AppColors.algerianGreen,
        secondaryColor: AppColors.lightGreen,
        specialties: [
          'Language teaching',
          'Cultural education',
          'Modern technology',
          'Youth guidance',
        ],
        greetings: {
          'english': 'Hello! Ready to learn?',
          'arabic': 'مرحباً! مستعد للتعلم؟',
          'amazigh': 'Azul! Theggaḍ i ulmad?',
        },
        farewells: {
          'english': 'Keep learning!',
          'arabic': 'واصل التعلم!',
          'amazigh': 'Kemmel almad!',
        },
      ),

      // Artisan - Traditional Craftsperson
      CulturalCharacter(
        id: 'artisan_craftsman',
        name: 'Maître Hassan',
        nameArabic: 'المعلم حسان',
        nameAmazigh: 'Amusnaw Ḥasan',
        type: CharacterType.artisan,
        description: 'A master craftsman specializing in traditional Algerian arts and crafts',
        descriptionArabic: 'حرفي ماهر متخصص في الفنون والحرف التقليدية الجزائرية',
        descriptionAmazigh: 'Amasnay ameqqran deg tẓurigin d teẓrigin tiẓuranin tizayriyin',
        contexts: [
          CharacterContext.crafts,
          CharacterContext.educational,
          CharacterContext.market,
          CharacterContext.general,
        ],
        imageAsset: 'assets/images/artisan_craftsman.png',
        primaryColor: AppColors.goldAccent,
        secondaryColor: AppColors.desertOrange,
        specialties: [
          'Traditional crafts',
          'Pottery making',
          'Carpet weaving',
          'Metalwork',
        ],
        greetings: {
          'english': 'Welcome to my workshop',
          'arabic': 'أهلاً بك في ورشتي',
          'amazigh': 'Ansuf ɣer uxxam n umahil-iw',
        },
        farewells: {
          'english': 'Come back anytime',
          'arabic': 'تعال في أي وقت',
          'amazigh': 'As-d melmi tebɣiḍ',
        },
      ),

      // Merchant - Market Expert
      CulturalCharacter(
        id: 'merchant_trader',
        name: 'Si Omar',
        nameArabic: 'سي عمر',
        nameAmazigh: 'Si Ɛumer',
        type: CharacterType.merchant,
        description: 'An experienced merchant who knows the ins and outs of traditional markets',
        descriptionArabic: 'تاجر خبير يعرف خبايا الأسواق التقليدية',
        descriptionAmazigh: 'Aneggar ilan tamusni meqqren ɣef yisuggen iqburin',
        contexts: [
          CharacterContext.market,
          CharacterContext.general,
          CharacterContext.educational,
        ],
        imageAsset: 'assets/images/merchant_trader.png',
        primaryColor: AppColors.algerianRed,
        secondaryColor: AppColors.lightRed,
        specialties: [
          'Market navigation',
          'Bargaining skills',
          'Product knowledge',
          'Business etiquette',
        ],
        greetings: {
          'english': 'What can I help you find today?',
          'arabic': 'شنو نقدر نعاونك تلقاه اليوم؟',
          'amazigh': 'D acu ara ak-ɛawneɣ ad t-tafeḍ ass-a?',
        },
        farewells: {
          'english': 'Thank you for your business',
          'arabic': 'شكراً لك على التعامل',
          'amazigh': 'Tanemmirt ɣef umsawal',
        },
      ),

      // Nomad Guide - Desert and Southern Culture
      CulturalCharacter(
        id: 'nomad_guide',
        name: 'Amellal',
        nameArabic: 'أمللال',
        nameAmazigh: 'Amellal',
        type: CharacterType.nomad,
        description: 'A Tuareg guide who knows the desert and southern Algerian traditions',
        descriptionArabic: 'دليل طارقي يعرف الصحراء وتقاليد جنوب الجزائر',
        descriptionAmazigh: 'Anmeggi Atargi yessen tiniri d iẓuran n unẓul n Lezzayer',
        contexts: [
          CharacterContext.storytelling,
          CharacterContext.educational,
          CharacterContext.music,
          CharacterContext.general,
        ],
        imageAsset: 'assets/images/nomad_guide.png',
        primaryColor: AppColors.desertOrange,
        secondaryColor: AppColors.sandBeige,
        specialties: [
          'Desert navigation',
          'Tuareg culture',
          'Traditional music',
          'Survival skills',
        ],
        greetings: {
          'english': 'The desert welcomes you',
          'arabic': 'الصحراء ترحب بك',
          'amazigh': 'Tiniri ak-tessufuɣ',
        },
        farewells: {
          'english': 'May your journey be safe',
          'arabic': 'رحلة آمنة',
          'amazigh': 'Abrid n taslamt',
        },
      ),
    ];

    _initialized = true;
  }

  /// Get character by ID
  CulturalCharacter? getCharacterById(String id) {
    try {
      return characters.firstWhere((character) => character.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get characters appropriate for a specific context
  List<CulturalCharacter> getCharactersForContext(CharacterContext context) {
    return characters
        .where((character) => character.isAppropriateForContext(context))
        .toList();
  }

  /// Get characters by type
  List<CulturalCharacter> getCharactersByType(CharacterType type) {
    return characters.where((character) => character.type == type).toList();
  }

  /// Get a random character for a context
  CulturalCharacter? getRandomCharacterForContext(CharacterContext context) {
    final appropriateCharacters = getCharactersForContext(context);
    if (appropriateCharacters.isEmpty) return null;
    
    appropriateCharacters.shuffle();
    return appropriateCharacters.first;
  }

  /// Get character recommendation based on dialogue content
  CulturalCharacter? getCharacterForDialogue(String dialogueTitle, String scenario) {
    final titleLower = dialogueTitle.toLowerCase();
    final scenarioLower = scenario.toLowerCase();

    // Market scenarios
    if (titleLower.contains('market') || scenarioLower.contains('market') ||
        titleLower.contains('shop') || scenarioLower.contains('buy')) {
      return getRandomCharacterForContext(CharacterContext.market);
    }

    // Wedding scenarios
    if (titleLower.contains('wedding') || scenarioLower.contains('wedding') ||
        titleLower.contains('marriage') || scenarioLower.contains('ceremony')) {
      return getRandomCharacterForContext(CharacterContext.wedding);
    }

    // Cooking scenarios
    if (titleLower.contains('cook') || scenarioLower.contains('cook') ||
        titleLower.contains('food') || scenarioLower.contains('recipe')) {
      return getRandomCharacterForContext(CharacterContext.cooking);
    }

    // Educational scenarios
    if (titleLower.contains('learn') || scenarioLower.contains('teach') ||
        titleLower.contains('school') || scenarioLower.contains('lesson')) {
      return getRandomCharacterForContext(CharacterContext.educational);
    }

    // Religious scenarios
    if (titleLower.contains('mosque') || scenarioLower.contains('prayer') ||
        titleLower.contains('religious') || scenarioLower.contains('islam')) {
      return getRandomCharacterForContext(CharacterContext.religious);
    }

    // Default to general context
    return getRandomCharacterForContext(CharacterContext.general);
  }

  /// Get all available contexts
  List<CharacterContext> getAllContexts() {
    return CharacterContext.values;
  }

  /// Get all available character types
  List<CharacterType> getAllTypes() {
    return CharacterType.values;
  }
}
