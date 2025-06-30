import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'culture_guide_screen.dart';

class CultureScreen extends StatefulWidget {
  const CultureScreen({super.key});

  @override
  State<CultureScreen> createState() => _CultureScreenState();
}

class _CultureScreenState extends State<CultureScreen> {
  final List<Map<String, dynamic>> _cultureCategories = [
    {
      'id': 'historic_places',
      'title': 'Historic Places',
      'subtitle': 'Discover Algerian historical landmarks',
      'icon': Icons.account_balance,
      'color': AppColors.algerianGreen,
      'guide_type': 'elder_male',
      'topics': [
        'The Casbah - Algiers',
        'Timgad - Batna',
        'Djémila - Setif',
        'Qal\'a of Beni Hammad - M\'Sila',
        'Tipaza - Blida',
      ],
    },
    {
      'id': 'traditional_markets',
      'title': 'Traditional Markets',
      'subtitle': 'Tour of popular souks',
      'icon': Icons.store,
      'color': AppColors.goldAccent,
      'guide_type': 'elder_male',
      'topics': [
        'Friday Market - Algiers',
        'Blacksmiths Market - Constantine',
        'Goldsmiths Market - Tlemcen',
        'Vegetable Market - Oran',
        'Crafts Market - Ghardaia',
      ],
    },
    {
      'id': 'traditional_clothing',
      'title': 'Traditional Clothing',
      'subtitle': 'Discover Algerian fashion',
      'icon': Icons.checkroom,
      'color': AppColors.algerianRed,
      'guide_type': 'elder_female',
      'topics': [
        'Algerian Kaftan',
        'Traditional Haik',
        'Burnous',
        'Kabyle Dress',
        'Saharan Melahfa',
      ],
    },
    {
      'id': 'wedding_traditions',
      'title': 'Wedding Traditions',
      'subtitle': 'Marriage customs in Algeria',
      'icon': Icons.favorite,
      'color': AppColors.purpleAccent,
      'guide_type': 'elder_female',
      'topics': [
        'Henna Night',
        'Algerian Wedding Rituals',
        'Traditional Wedding Foods',
        'Music and Dance',
        'Gifts and Dowry',
      ],
    },
    {
      'id': 'traditional_food',
      'title': 'Traditional Cuisine',
      'subtitle': 'Discover Algerian kitchen',
      'icon': Icons.restaurant,
      'color': AppColors.tealAccent,
      'guide_type': 'elder_female',
      'topics': [
        'Algerian Couscous',
        'Chakhchoukha',
        'Bourak',
        'Mahajeb',
        'Traditional Sweets',
      ],
    },
    {
      'id': 'festivals_celebrations',
      'title': 'Festivals & Celebrations',
      'subtitle': 'Algerian cultural events',
      'icon': Icons.celebration,
      'color': AppColors.desertOrange,
      'guide_type': 'elder_male',
      'topics': [
        'Timgad Festival',
        'Sahara Festival',
        'Amazigh New Year (Yennayer)',
        'Prophet\'s Birthday',
        'Independence Day',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text(
          'Algerian Culture',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.algerianGreen,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: CustomScrollView(
        slivers: [
          // Header section
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.algerianGreen,
                    AppColors.algerianGreen.withValues(alpha: 0.8),
                    AppColors.backgroundLight,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.location_city,
                      size: 80,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Discover Algerian Heritage',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Learn about famous places, customs and Algerian traditions with our cultural guides',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          // Categories grid
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 3.5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final category = _cultureCategories[index];
                  return _buildCategoryCard(context, category);
                },
                childCount: _cultureCategories.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CultureGuideScreen(
              category: category,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              category['color'] as Color,
              (category['color'] as Color).withValues(alpha: 0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: (category['color'] as Color).withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  category['icon'] as IconData,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      category['title'] as String,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category['subtitle'] as String,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white.withValues(alpha: 0.8),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
