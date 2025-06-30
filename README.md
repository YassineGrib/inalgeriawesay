# In Algeria We Say 🇩🇿

A comprehensive Flutter application for learning Algerian Arabic dialects and exploring Algerian culture. This app provides interactive conversations, cultural guides, and immersive learning experiences across multiple regional dialects.

## 📱 Features

### 🗣️ **Multi-Dialect Conversations**
- **8 Levels** of conversation scenarios (40+ categories)
- **Standard Arabic** and **Amazigh (Tamazight)** support
- **4 Regional Algerian Dialects**: North, West, East, South
- Real-life scenarios: meetings, travel, shopping, healthcare, education
- **Progressive Learning**: From basic greetings to complex cultural interactions

### 🏛️ **Cultural Heritage Guide**
- **Interactive Cultural Guides**: Hajj Mohammed & Hajja Fatima
- **6 Cultural Categories**:
  - **Historic Places**: Casbah, Timgad, Djémila, Qal'a of Beni Hammad, Tipaza
  - **Traditional Markets**: Friday Market, Blacksmiths Market, Goldsmiths Market
  - **Traditional Clothing**: Kaftan, Haik, Burnous, Kabyle Dress, Saharan Melahfa
  - **Wedding Traditions**: Henna Night, Rituals, Traditional Foods, Music & Dance
  - **Traditional Cuisine**: Couscous, Chakhchoukha, Bourak, Mahajeb, Traditional Sweets
  - **Festivals & Celebrations**: Timgad Festival, Sahara Festival, Yennayer, Independence Day

### 👤 **User Profile & Progress**
- **Level System** with points and achievements
- **Progress Tracking** across conversations and challenges
- **Achievement Badges** for learning milestones
- **Statistics Dashboard** with detailed activity summaries
- **Personalized Experience** with favorite regions and languages

### 🎨 **Modern UI/UX**
- **Algerian-themed** color palette (Green #1B5E20, Red #C62828, White)
- **Responsive Design** optimized for all screen sizes
- **Smooth Animations** and intuitive transitions
- **Offline-first Architecture** with local data storage
- **Cultural Authenticity** in design and content

### 💾 **Technical Excellence**
- **100% Offline**: No internet connection required
- **Local JSON Storage**: Organized data structure in assets/data/
- **SharedPreferences**: User progress and preferences
- **Flutter Hooks + Provider**: Modern state management
- **Optimized Performance**: No overflow errors, smooth scrolling

## 🎯 Conversation Levels

### Level 1: Basic Interactions
- **Meetings**: First meetings, acquaintance reunions
- **Greetings**: Morning, evening, farewell, phone greetings
- **Self Introduction**: Name, origin, profession, age

### Level 2: Travel & Transportation
- **Airport**: Check-in, security, boarding procedures
- **Taxi**: Booking, directions, fare payment
- **Hotel**: Reservations, check-in, room services
- **Accommodation**: Searching, inquiring, booking

### Level 3: Public Transportation
- **Bus Station**: Schedules, destinations, ticket purchasing
- **Metro Station**: Navigation, tickets, directions
- **Restaurant**: Ordering food, preferences, payment

### Level 4: Daily Services
- **Street Help**: Asking for directions (finding Hamma Park)
- **Job Interview**: Professional conversations and interviews
- **Post Office**: Mail services, money transfers, residence permits

### Level 5: Healthcare & Safety
- **Hospital**: Booking appointments, medical consultations
- **Pharmacy**: Buying medicine, prescriptions
- **Police Station**: Reporting incidents (lost wallet)
- **Traditional Market**: Buying handmade carpets

### Level 6: Shopping
- **Grocery/Fruit Store**: Fresh produce shopping
- **Supermarket/Mall**: General shopping experiences
- **Butcher Shop**: Meat selection and purchasing
- **Bakery/Sweets**: Traditional treats and pastries

### Level 7: Education & Recreation
- **School**: Education system explanations
- **University**: Exchange student registration
- **Gym**: Monthly membership, facilities
- **Library**: Book borrowing, research services
- **Mosque**: Cultural and religious visits

### Level 8: Cultural Experiences
- **Traditional Hammam**: Spa and wellness experiences
- **Barber Shop**: Grooming and traditional services
- **Cinema**: Entertainment, movie tickets
- **Park**: Recreation and outdoor activities

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Android/iOS device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/inalgeriawesay.git
   cd inalgeriawesay
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── user_profile.dart
│   ├── conversation.dart
│   └── culture_content.dart
├── screens/                  # UI screens
│   ├── home_screen.dart
│   ├── profile_screen.dart
│   ├── conversation_screen.dart
│   ├── culture_screen.dart
│   └── user_info_screen.dart
├── services/                 # Business logic
│   ├── user_service.dart
│   ├── conversation_service.dart
│   └── culture_service.dart
├── widgets/                  # Reusable components
│   ├── conversation_card.dart
│   ├── culture_guide.dart
│   └── progress_indicator.dart
├── utils/                    # Utilities
│   ├── app_colors.dart
│   └── constants.dart
└── assets/                   # Static assets
    └── data/                 # JSON data files
        ├── conversations/    # 8 levels of dialogues
        └── culture/          # Cultural content
```

## 🎭 Demo User Feature

For quick testing and demonstration purposes, the app includes a **Quick Demo Login** feature:

### How to Use Demo User
1. Launch the app
2. On the user info screen, click **"Quick Demo Login"** button
3. This creates a demo user with:
   - **Name**: Ahmed Benali
   - **Age**: 25
   - **Country**: Algeria
   - **Pre-loaded Progress**: 50 points, 2 completed dialogues, 3 completed challenges
   - **Preferences**: Arabic & English languages, North & West regions

### Demo User Benefits
- ✅ Skip manual profile creation
- ✅ Experience app with existing progress
- ✅ Test all features immediately
- ✅ Perfect for demonstrations and testing

## 🏛️ Cultural Guide Features

### 👨‍🦳 Hajj Mohammed (Male Elder Guide)
- **Specialization**: Historic places, traditional markets, festivals
- **Role**: Cultural storyteller and historical expert
- **Wisdom**: Traditional sayings and cultural insights
- **Topics**: Casbah stories, market traditions, festival celebrations

### 👵 Hajja Fatima (Female Elder Guide)
- **Specialization**: Traditional clothing, wedding traditions, cuisine
- **Role**: Women's heritage expert and cultural keeper
- **Knowledge**: Traditional practices, family customs, cooking secrets
- **Topics**: Fashion heritage, wedding rituals, culinary traditions

## 🛠️ Technical Stack

- **Framework**: Flutter 3.x
- **Language**: Dart
- **State Management**: Provider + flutter_hooks
- **Local Storage**: SharedPreferences
- **Data Format**: JSON files in assets/data/
- **Architecture**: Offline-first with local assets
- **UI**: Material Design with Algerian cultural themes

## 🎨 Design System

### Color Palette
- **Primary Green**: `#1B5E20` (Algerian flag green)
- **Accent Red**: `#C62828` (Algerian flag red)
- **Background**: `#F5F5F5` (Light gray)
- **Text Primary**: `#212121` (Dark gray)
- **Text Secondary**: `#757575` (Medium gray)

### Typography
- **Headers**: Bold, 18-24px
- **Body Text**: Regular, 14-16px
- **Captions**: Light, 12px

## 🧪 Testing

Run tests with:
```bash
flutter test
```

Test coverage includes:
- Unit tests for services and models
- Widget tests for UI components
- Integration tests for user flows

## 📱 Supported Platforms

- ✅ Android (API 21+)
- ✅ iOS (iOS 11+)
- 🔄 Web (In development)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Algerian cultural experts for authentic content
- Flutter community for excellent packages
- Traditional storytellers for cultural wisdom
- Regional dialect speakers for authentic conversations

## 📞 Contact

- **Email**: contact@inalgeriawesay.com
- **Website**: [www.inalgeriawesay.com](https://www.inalgeriawesay.com)
- **GitHub**: [github.com/inalgeriawesay](https://github.com/inalgeriawesay)

---

**Made with ❤️ for preserving and sharing Algerian culture and language** 🇩🇿
