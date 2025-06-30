import 'package:flutter/material.dart';

class ConversationCategory {
  final String id;
  final String titleEn;
  final String titleAr;
  final String description;
  final IconData icon;
  final Color color;
  final int level; // Level 1-5
  final List<ConversationSubcategory> subcategories;

  const ConversationCategory({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.description,
    required this.icon,
    required this.color,
    required this.level,
    required this.subcategories,
  });
}

class ConversationSubcategory {
  final String id;
  final String titleEn;
  final String titleAr;
  final String description;
  final IconData icon;
  final List<String> tags; // Tags to match with dialogue tags
  final String scenario;
  final String? filePath; // مسار المجلد الذي يحتوي على ملفات هذا السيناريو

  const ConversationSubcategory({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.description,
    required this.icon,
    required this.tags,
    required this.scenario,
    this.filePath,
  });
}

class ConversationCategories {
  static List<ConversationCategory> get allCategories => [
    // LEVEL 1 - اللقاءات
    const ConversationCategory(
      id: 'meetings',
      titleEn: 'Meetings',
      titleAr: 'اللقاءات',
      description: 'Different types of meetings and encounters',
      icon: Icons.handshake,
      color: Color(0xFF2E7D32), // Green
      level: 1,
      subcategories: [
        ConversationSubcategory(
          id: 'first_meeting',
          titleEn: 'Meeting someone for the first time',
          titleAr: 'لقاء مع شخصية لأول مرة',
          description: 'Initial introductions with strangers',
          icon: Icons.person_add,
          tags: ['first_meeting', 'introduction', 'stranger'],
          scenario: 'You are meeting someone for the first time in a social setting',
          filePath: 'assets/data/conversations/meetings/first_meetings',
        ),
        ConversationSubcategory(
          id: 'acquaintance_meeting',
          titleEn: 'Meeting between two people who know each other',
          titleAr: 'لقاء بين شخصيتين يعرفان بعض',
          description: 'Reuniting with acquaintances',
          icon: Icons.people,
          tags: ['acquaintance', 'reunion', 'friends'],
          scenario: 'You are meeting someone you know after some time',
          filePath: 'assets/data/conversations/meetings/acquaintance_reunions',
        ),
      ],
    ),

    // LEVEL 1 - التحيات
    const ConversationCategory(
      id: 'greetings',
      titleEn: 'Greetings',
      titleAr: 'التحيات',
      description: 'Various types of greetings and farewells',
      icon: Icons.waving_hand,
      color: Color(0xFF1976D2), // Blue
      level: 1,
      subcategories: [
        ConversationSubcategory(
          id: 'morning_greeting',
          titleEn: 'Morning greeting',
          titleAr: 'تحية الصباح',
          description: 'Morning greetings and pleasantries',
          icon: Icons.wb_sunny,
          tags: ['morning', 'greeting', 'good_morning'],
          scenario: 'You are greeting someone in the morning',
          filePath: 'assets/data/conversations/greetings/morning',
        ),
        ConversationSubcategory(
          id: 'evening_greeting',
          titleEn: 'Evening greeting',
          titleAr: 'تحية المساء',
          description: 'Evening greetings and conversations',
          icon: Icons.nights_stay,
          tags: ['evening', 'greeting', 'good_evening'],
          scenario: 'You are greeting someone in the evening',
          filePath: 'assets/data/conversations/greetings/evening',
        ),
        ConversationSubcategory(
          id: 'farewell_greeting',
          titleEn: 'Farewell greeting',
          titleAr: 'تحية الوداع',
          description: 'Saying goodbye and farewell greetings',
          icon: Icons.waving_hand,
          tags: ['farewell', 'goodbye', 'leaving'],
          scenario: 'You are saying goodbye to someone',
          filePath: 'assets/data/conversations/greetings/farewell',
        ),
        ConversationSubcategory(
          id: 'phone_greeting',
          titleEn: 'Phone greeting',
          titleAr: 'التحية عبر الهاتف',
          description: 'Greetings and conversations over the phone',
          icon: Icons.phone,
          tags: ['phone', 'call', 'telephone'],
          scenario: 'You are greeting someone over the phone',
          filePath: 'assets/data/conversations/greetings/phone',
        ),
      ],
    ),

    // LEVEL 1 - التعريف بالنفس
    const ConversationCategory(
      id: 'introductions',
      titleEn: 'Self Introduction',
      titleAr: 'التعريف بالنفس',
      description: 'Introducing yourself and personal information',
      icon: Icons.person,
      color: Color(0xFF9C27B0), // Purple
      level: 1,
      subcategories: [
        ConversationSubcategory(
          id: 'self_introduction',
          titleEn: 'Self introduction',
          titleAr: 'التعريف بالنفس',
          description: 'Introducing yourself to new people',
          icon: Icons.person_outline,
          tags: ['self_introduction', 'personal_info', 'meeting'],
          scenario: 'You are introducing yourself to someone new',
          filePath: 'assets/data/conversations/introductions/self_introduction',
        ),
      ],
    ),

    // LEVEL 2 - السفر
    const ConversationCategory(
      id: 'airport',
      titleEn: 'At the Airport',
      titleAr: 'في المطار',
      description: 'Airport conversations and procedures',
      icon: Icons.flight,
      color: Color(0xFF1976D2), // Blue
      level: 2,
      subcategories: [
        ConversationSubcategory(
          id: 'airport_checkin',
          titleEn: 'Airport check-in and procedures',
          titleAr: 'إجراءات المطار والتسجيل',
          description: 'Check-in, security, and boarding procedures',
          icon: Icons.flight_takeoff,
          tags: ['airport', 'checkin', 'travel'],
          scenario: 'You are at the airport going through check-in and security',
          filePath: 'assets/data/conversations/travel/airport',
        ),
      ],
    ),

    const ConversationCategory(
      id: 'taxi',
      titleEn: 'Taking a Taxi',
      titleAr: 'توقيف سيارة أجرة',
      description: 'Taxi conversations and negotiations',
      icon: Icons.local_taxi,
      color: Color(0xFFFF9800), // Orange
      level: 2,
      subcategories: [
        ConversationSubcategory(
          id: 'taxi_ride',
          titleEn: 'Taking a taxi ride',
          titleAr: 'ركوب سيارة أجرة',
          description: 'Hailing a taxi and giving directions',
          icon: Icons.directions_car,
          tags: ['taxi', 'transportation', 'directions'],
          scenario: 'You need to take a taxi to your destination',
          filePath: 'assets/data/conversations/travel/taxi',
        ),
      ],
    ),

    const ConversationCategory(
      id: 'hotel_booking',
      titleEn: 'Hotel Booking',
      titleAr: 'الحجز في فندق',
      description: 'Hotel reservation and check-in conversations',
      icon: Icons.hotel,
      color: Color(0xFF4CAF50), // Green
      level: 2,
      subcategories: [
        ConversationSubcategory(
          id: 'hotel_reservation',
          titleEn: 'Hotel reservation and check-in',
          titleAr: 'حجز الفندق والتسجيل',
          description: 'Making hotel reservations and checking in',
          icon: Icons.bed,
          tags: ['hotel', 'booking', 'accommodation'],
          scenario: 'You are booking a hotel room and checking in',
          filePath: 'assets/data/conversations/travel/hotel_booking',
        ),
      ],
    ),

    const ConversationCategory(
      id: 'accommodation_search',
      titleEn: 'Finding Accommodation',
      titleAr: 'البحث عن سكن',
      description: 'Searching for places to stay',
      icon: Icons.home_work,
      color: Color(0xFF9C27B0), // Purple
      level: 2,
      subcategories: [
        ConversationSubcategory(
          id: 'accommodation_inquiry',
          titleEn: 'Searching for accommodation',
          titleAr: 'البحث عن سكن',
          description: 'Looking for apartments, hostels, or other accommodation',
          icon: Icons.search,
          tags: ['accommodation', 'housing', 'search'],
          scenario: 'You are looking for a place to stay',
          filePath: 'assets/data/conversations/travel/accommodation_search',
        ),
      ],
    ),

    // LEVEL 3 - المواصلات والمطاعم
    const ConversationCategory(
      id: 'bus_station',
      titleEn: 'At the Bus Station',
      titleAr: 'في محطة الحافلات',
      description: 'Bus station conversations and ticket purchasing',
      icon: Icons.directions_bus,
      color: Color(0xFFE91E63), // Pink
      level: 3,
      subcategories: [
        ConversationSubcategory(
          id: 'bus_ticket',
          titleEn: 'Bus ticket and travel',
          titleAr: 'تذكرة الحافلة والسفر',
          description: 'Buying bus tickets and asking for information',
          icon: Icons.confirmation_number,
          tags: ['bus', 'ticket', 'travel'],
          scenario: 'You are at the bus station buying a ticket',
          filePath: 'assets/data/conversations/level3/bus_station',
        ),
      ],
    ),

    const ConversationCategory(
      id: 'metro_station',
      titleEn: 'At the Metro Station',
      titleAr: 'في محطة الميترو',
      description: 'Metro station conversations and navigation',
      icon: Icons.train,
      color: Color(0xFF607D8B), // Blue Grey
      level: 3,
      subcategories: [
        ConversationSubcategory(
          id: 'metro_navigation',
          titleEn: 'Metro navigation and tickets',
          titleAr: 'التنقل في الميترو والتذاكر',
          description: 'Using the metro system and buying tickets',
          icon: Icons.map,
          tags: ['metro', 'navigation', 'tickets'],
          scenario: 'You are at the metro station trying to navigate',
          filePath: 'assets/data/conversations/level3/metro_station',
        ),
      ],
    ),

    const ConversationCategory(
      id: 'restaurant',
      titleEn: 'At the Restaurant',
      titleAr: 'في المطعم',
      description: 'Restaurant conversations and ordering food',
      icon: Icons.restaurant,
      color: Color(0xFFFF5722), // Deep Orange
      level: 3,
      subcategories: [
        ConversationSubcategory(
          id: 'restaurant_order',
          titleEn: 'Ordering food at restaurant',
          titleAr: 'طلب الطعام في المطعم',
          description: 'Ordering food and drinks at a restaurant',
          icon: Icons.restaurant_menu,
          tags: ['restaurant', 'food', 'ordering'],
          scenario: 'You are at a restaurant ordering food',
          filePath: 'assets/data/conversations/level3/restaurant',
        ),
      ],
    ),

    // LEVEL 4 - المواقف المتقدمة والخدمات
    const ConversationCategory(
      id: 'street_help',
      titleEn: 'Asking for Help in the Street',
      titleAr: 'طلب المساعدة في الشارع',
      description: 'Asking for directions and help from strangers',
      icon: Icons.help_outline,
      color: Color(0xFF9C27B0), // Purple
      level: 4,
      subcategories: [
        ConversationSubcategory(
          id: 'street_directions',
          titleEn: 'Getting directions and help',
          titleAr: 'الحصول على الاتجاهات والمساعدة',
          description: 'Asking strangers for directions and assistance',
          icon: Icons.directions_walk,
          tags: ['street', 'help', 'directions'],
          scenario: 'You are lost and need to ask for directions',
          filePath: 'assets/data/conversations/level4/street_help',
        ),
      ],
    ),

    const ConversationCategory(
      id: 'job_interview',
      titleEn: 'Job Interview',
      titleAr: 'مقابلة عمل',
      description: 'Professional job interview conversations',
      icon: Icons.work,
      color: Color(0xFF795548), // Brown
      level: 4,
      subcategories: [
        ConversationSubcategory(
          id: 'interview_process',
          titleEn: 'Job interview process',
          titleAr: 'عملية مقابلة العمل',
          description: 'Professional interview questions and answers',
          icon: Icons.business_center,
          tags: ['job', 'interview', 'professional'],
          scenario: 'You are in a job interview',
          filePath: 'assets/data/conversations/level4/job_interview',
        ),
      ],
    ),

    const ConversationCategory(
      id: 'post_office',
      titleEn: 'At the Post Office',
      titleAr: 'في مكتب البريد',
      description: 'Post office services and mail handling',
      icon: Icons.local_post_office,
      color: Color(0xFF607D8B), // Blue Grey
      level: 4,
      subcategories: [
        ConversationSubcategory(
          id: 'postal_services',
          titleEn: 'Postal services and mail',
          titleAr: 'الخدمات البريدية والبريد',
          description: 'Sending mail and using postal services',
          icon: Icons.mail,
          tags: ['post', 'mail', 'services'],
          scenario: 'You are at the post office sending mail',
          filePath: 'assets/data/conversations/level4/post_office',
        ),
      ],
    ),

    // LEVEL 5 - الخدمات المتخصصة والأسواق التقليدية
    const ConversationCategory(
      id: 'hospital',
      titleEn: 'At the Hospital',
      titleAr: 'في المستشفى',
      description: 'Medical appointments and consultations',
      icon: Icons.local_hospital,
      color: Color(0xFFE91E63), // Pink
      level: 5,
      subcategories: [
        ConversationSubcategory(
          id: 'medical_appointment',
          titleEn: 'Medical appointment and consultation',
          titleAr: 'موعد طبي واستشارة',
          description: 'Booking appointments and consulting with doctors',
          icon: Icons.medical_services,
          tags: ['hospital', 'doctor', 'appointment'],
          scenario: 'You need to book a medical appointment',
          filePath: 'assets/data/conversations/level5/hospital',
        ),
      ],
    ),

    const ConversationCategory(
      id: 'pharmacy',
      titleEn: 'At the Pharmacy',
      titleAr: 'في الصيدلية',
      description: 'Buying medicine and pharmaceutical services',
      icon: Icons.local_pharmacy,
      color: Color(0xFF4CAF50), // Green
      level: 5,
      subcategories: [
        ConversationSubcategory(
          id: 'buying_medicine',
          titleEn: 'Buying medicine',
          titleAr: 'شراء الدواء',
          description: 'Purchasing medication and getting advice',
          icon: Icons.medication,
          tags: ['pharmacy', 'medicine', 'health'],
          scenario: 'You need to buy medicine for headache',
          filePath: 'assets/data/conversations/level5/pharmacy',
        ),
      ],
    ),

    const ConversationCategory(
      id: 'police_station',
      titleEn: 'At the Police Station',
      titleAr: 'في مركز الشرطة',
      description: 'Reporting incidents and police services',
      icon: Icons.local_police,
      color: Color(0xFF3F51B5), // Indigo
      level: 5,
      subcategories: [
        ConversationSubcategory(
          id: 'reporting_incident',
          titleEn: 'Reporting a lost item',
          titleAr: 'الإبلاغ عن فقدان شيء',
          description: 'Filing a report for lost belongings',
          icon: Icons.report_problem,
          tags: ['police', 'report', 'lost'],
          scenario: 'You need to report a lost wallet',
          filePath: 'assets/data/conversations/level5/police_station',
        ),
      ],
    ),

    const ConversationCategory(
      id: 'traditional_market',
      titleEn: 'Traditional Market',
      titleAr: 'في الحي التقليدي',
      description: 'Shopping in traditional markets and bargaining',
      icon: Icons.store,
      color: Color(0xFFFF9800), // Orange
      level: 5,
      subcategories: [
        ConversationSubcategory(
          id: 'market_shopping',
          titleEn: 'Shopping and bargaining',
          titleAr: 'التسوق والمساومة',
          description: 'Buying traditional items and negotiating prices',
          icon: Icons.shopping_bag,
          tags: ['market', 'shopping', 'bargaining'],
          scenario: 'You want to buy a traditional carpet',
          filePath: 'assets/data/conversations/level5/traditional_market',
        ),
      ],
    ),

    // LEVEL 6 - التسوق والمتاجر المتخصصة
    const ConversationCategory(
      id: 'grocery_store',
      titleEn: 'Grocery Store',
      titleAr: 'متجر الخضر والفواكه',
      description: 'Shopping for fruits and vegetables',
      icon: Icons.local_grocery_store,
      color: Color(0xFF4CAF50), // Green
      level: 6,
      subcategories: [
        ConversationSubcategory(
          id: 'fruit_vegetable_shopping',
          titleEn: 'Buying fruits and vegetables',
          titleAr: 'شراء الخضر والفواكه',
          description: 'Shopping for fresh produce and local specialties',
          icon: Icons.eco,
          tags: ['grocery', 'fruits', 'vegetables'],
          scenario: 'You are buying vegetables and trying local dates',
          filePath: 'assets/data/conversations/level6/grocery_store',
        ),
      ],
    ),

    const ConversationCategory(
      id: 'supermarket',
      titleEn: 'Supermarket',
      titleAr: 'السوبرماركت',
      description: 'Shopping in supermarkets and malls',
      icon: Icons.shopping_cart,
      color: Color(0xFF2196F3), // Blue
      level: 6,
      subcategories: [
        ConversationSubcategory(
          id: 'supermarket_shopping',
          titleEn: 'Supermarket shopping',
          titleAr: 'التسوق في السوبرماركت',
          description: 'Finding items in supermarkets and asking for directions',
          icon: Icons.store,
          tags: ['supermarket', 'shopping', 'directions'],
          scenario: 'You are looking for dairy products and drinks',
          filePath: 'assets/data/conversations/level6/supermarket',
        ),
      ],
    ),

    const ConversationCategory(
      id: 'butcher_shop',
      titleEn: 'Butcher Shop',
      titleAr: 'محل بيع اللحوم',
      description: 'Buying meat and learning about local varieties',
      icon: Icons.restaurant,
      color: Color(0xFFFF5722), // Deep Orange
      level: 6,
      subcategories: [
        ConversationSubcategory(
          id: 'meat_shopping',
          titleEn: 'Buying meat',
          titleAr: 'شراء اللحوم',
          description: 'Purchasing fresh meat and learning about local breeds',
          icon: Icons.dining,
          tags: ['butcher', 'meat', 'local'],
          scenario: 'You are buying fresh meat and learning about local varieties',
          filePath: 'assets/data/conversations/level6/butcher_shop',
        ),
      ],
    ),

    const ConversationCategory(
      id: 'bakery',
      titleEn: 'Bakery',
      titleAr: 'المخبزة ومحل الحلويات',
      description: 'Buying bread and traditional sweets',
      icon: Icons.bakery_dining,
      color: Color(0xFFFF9800), // Orange
      level: 6,
      subcategories: [
        ConversationSubcategory(
          id: 'bread_sweets_shopping',
          titleEn: 'Buying bread and sweets',
          titleAr: 'شراء الخبز والحلويات',
          description: 'Purchasing fresh bread and traditional Algerian sweets',
          icon: Icons.cake,
          tags: ['bakery', 'bread', 'sweets'],
          scenario: 'You are buying fresh bread and trying traditional sweets',
          filePath: 'assets/data/conversations/level6/bakery',
        ),
      ],
    ),

    // LEVEL 7 - التعليم والمؤسسات الثقافية والدينية
    const ConversationCategory(
      id: 'school',
      titleEn: 'At School',
      titleAr: 'في المدرسة',
      description: 'School system and student enrollment',
      icon: Icons.school,
      color: Color(0xFF3F51B5), // Indigo
      level: 7,
      subcategories: [
        ConversationSubcategory(
          id: 'school_enrollment',
          titleEn: 'School enrollment and education system',
          titleAr: 'التسجيل المدرسي ونظام التعليم',
          description: 'Learning about the Algerian education system and enrolling students',
          icon: Icons.assignment,
          tags: ['school', 'education', 'enrollment'],
          scenario: 'You want to learn about the education system and enroll your child',
          filePath: 'assets/data/conversations/level7/school',
        ),
      ],
    ),

    const ConversationCategory(
      id: 'university',
      titleEn: 'At University',
      titleAr: 'في الجامعة',
      description: 'University life and academic procedures',
      icon: Icons.account_balance,
      color: Color(0xFF9C27B0), // Purple
      level: 7,
      subcategories: [
        ConversationSubcategory(
          id: 'university_life',
          titleEn: 'University enrollment and campus life',
          titleAr: 'التسجيل الجامعي والحياة الجامعية',
          description: 'Exchange student enrollment and campus orientation',
          icon: Icons.library_books,
          tags: ['university', 'student', 'campus'],
          scenario: 'You are an exchange student enrolling at university',
          filePath: 'assets/data/conversations/level7/university',
        ),
      ],
    ),

    const ConversationCategory(
      id: 'gym',
      titleEn: 'At the Gym',
      titleAr: 'في قاعة الرياضة',
      description: 'Gym membership and fitness activities',
      icon: Icons.fitness_center,
      color: Color(0xFFFF5722), // Deep Orange
      level: 7,
      subcategories: [
        ConversationSubcategory(
          id: 'gym_membership',
          titleEn: 'Gym membership and facilities',
          titleAr: 'عضوية النادي الرياضي والمرافق',
          description: 'Signing up for gym membership and using facilities',
          icon: Icons.sports_gymnastics,
          tags: ['gym', 'fitness', 'membership'],
          scenario: 'You want to join a gym and learn about facilities',
          filePath: 'assets/data/conversations/level7/gym',
        ),
      ],
    ),

    const ConversationCategory(
      id: 'library',
      titleEn: 'At the Library',
      titleAr: 'في المكتبة العامة',
      description: 'Library services and book borrowing',
      icon: Icons.local_library,
      color: Color(0xFF795548), // Brown
      level: 7,
      subcategories: [
        ConversationSubcategory(
          id: 'library_services',
          titleEn: 'Library card and book borrowing',
          titleAr: 'بطاقة المكتبة واستعارة الكتب',
          description: 'Getting a library card and borrowing books',
          icon: Icons.menu_book,
          tags: ['library', 'books', 'card'],
          scenario: 'You want to borrow books from the public library',
          filePath: 'assets/data/conversations/level7/library',
        ),
      ],
    ),

    const ConversationCategory(
      id: 'mosque',
      titleEn: 'At the Mosque',
      titleAr: 'في المسجد',
      description: 'Mosque etiquette and Islamic culture',
      icon: Icons.mosque,
      color: Color(0xFF4CAF50), // Green
      level: 7,
      subcategories: [
        ConversationSubcategory(
          id: 'mosque_visit',
          titleEn: 'Visiting mosque and learning about Islam',
          titleAr: 'زيارة المسجد والتعرف على الإسلام',
          description: 'Learning about mosque etiquette and Islamic values',
          icon: Icons.location_city,
          tags: ['mosque', 'islam', 'culture'],
          scenario: 'You are visiting a mosque and learning about Islamic culture',
          filePath: 'assets/data/conversations/level7/mosque',
        ),
      ],
    ),

    // LEVEL 8 - الترفيه والخدمات الشخصية والتجارب الثقافية
    const ConversationCategory(
      id: 'hammam',
      titleEn: 'At the Traditional Hammam',
      titleAr: 'في الحمام التقليدي',
      description: 'Traditional Algerian hammam experience',
      icon: Icons.hot_tub,
      color: Color(0xFF00BCD4), // Cyan
      level: 8,
      subcategories: [
        ConversationSubcategory(
          id: 'hammam_experience',
          titleEn: 'Traditional hammam experience',
          titleAr: 'تجربة الحمام التقليدي الجزائري',
          description: 'Experiencing the traditional Algerian hammam and spa culture',
          icon: Icons.spa,
          tags: ['hammam', 'traditional', 'spa'],
          scenario: 'You want to experience the traditional Algerian hammam',
          filePath: 'assets/data/conversations/level8/hammam',
        ),
      ],
    ),

    const ConversationCategory(
      id: 'barber',
      titleEn: 'At the Barber',
      titleAr: 'عند الحلاق',
      description: 'Haircut and grooming services',
      icon: Icons.content_cut,
      color: Color(0xFF8BC34A), // Light Green
      level: 8,
      subcategories: [
        ConversationSubcategory(
          id: 'barber_services',
          titleEn: 'Haircut and beard trimming',
          titleAr: 'قص الشعر وتهذيب اللحية',
          description: 'Getting a haircut and beard trimming at the barber',
          icon: Icons.face_retouching_natural,
          tags: ['barber', 'haircut', 'grooming'],
          scenario: 'You need a haircut and beard trimming',
          filePath: 'assets/data/conversations/level8/barber',
        ),
      ],
    ),

    const ConversationCategory(
      id: 'cinema',
      titleEn: 'At the Cinema',
      titleAr: 'في السينما',
      description: 'Movie tickets and Algerian cinema',
      icon: Icons.movie,
      color: Color(0xFFE91E63), // Pink
      level: 8,
      subcategories: [
        ConversationSubcategory(
          id: 'cinema_tickets',
          titleEn: 'Movie tickets and Algerian films',
          titleAr: 'تذاكر السينما والأفلام الجزائرية',
          description: 'Buying movie tickets and watching Algerian cinema',
          icon: Icons.local_movies,
          tags: ['cinema', 'movies', 'culture'],
          scenario: 'You want to watch an Algerian movie at the cinema',
          filePath: 'assets/data/conversations/level8/cinema',
        ),
      ],
    ),

    const ConversationCategory(
      id: 'park',
      titleEn: 'In the Park',
      titleAr: 'في الحديقة',
      description: 'Casual conversations in public spaces',
      icon: Icons.park,
      color: Color(0xFF4CAF50), // Green
      level: 8,
      subcategories: [
        ConversationSubcategory(
          id: 'park_conversation',
          titleEn: 'Casual conversation in the park',
          titleAr: 'محادثة عادية في الحديقة',
          description: 'Casual conversation with locals in the park',
          icon: Icons.nature_people,
          tags: ['park', 'casual', 'social'],
          scenario: 'You meet a local person in the park for casual conversation',
          filePath: 'assets/data/conversations/level8/park',
        ),
      ],
    ),
  ];

  static List<ConversationCategory> getCategoriesByLevel(int level) {
    return allCategories.where((category) => category.level == level).toList();
  }

  static ConversationCategory? getCategoryById(String id) {
    try {
      return allCategories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  static ConversationSubcategory? getSubcategoryById(String categoryId, String subcategoryId) {
    final category = getCategoryById(categoryId);
    if (category == null) return null;

    try {
      return category.subcategories.firstWhere((sub) => sub.id == subcategoryId);
    } catch (e) {
      return null;
    }
  }

  static List<int> get availableLevels => [1, 2, 3, 4, 5, 6, 7, 8];

  static String getLevelTitle(int level) {
    switch (level) {
      case 1:
        return 'Level 1 - Basic Interactions';
      case 2:
        return 'Level 2 - Intermediate Conversations';
      case 3:
        return 'Level 3 - Advanced Discussions';
      case 4:
        return 'Level 4 - Cultural Exchanges';
      case 5:
        return 'Level 5 - Expert Communications';
      default:
        return 'Level $level';
    }
  }
}
