import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../constants/app_colors.dart';

class CultureGuideWidget extends StatefulWidget {
  final String guideType;
  final Map<String, dynamic> category;
  final String currentTopic;

  const CultureGuideWidget({
    super.key,
    required this.guideType,
    required this.category,
    required this.currentTopic,
  });

  @override
  State<CultureGuideWidget> createState() => _CultureGuideWidgetState();
}

class _CultureGuideWidgetState extends State<CultureGuideWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _bounceAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isElderFemale = widget.guideType == 'elder_female';

    return Column(
      children: [
        // Guide character avatar
        ScaleTransition(
          scale: _bounceAnimation,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.white.withValues(alpha: 0.9),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipOval(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isElderFemale
                        ? [
                            const Color(0xFFE91E63),
                            const Color(0xFFAD1457),
                          ]
                        : [
                            const Color(0xFF8D6E63),
                            const Color(0xFF5D4037),
                          ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Background pattern
                    Positioned.fill(
                      child: CustomPaint(
                        painter: TraditionalPatternPainter(
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                    // Character icon
                    Center(
                      child: Icon(
                        isElderFemale ? Icons.elderly_woman : Icons.elderly,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Guide name and title
        Text(
          isElderFemale ? 'Hajja Fatima' : 'Hajj Mohammed',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isElderFemale ? 'Women\'s Heritage Expert' : 'Storyteller & Cultural Guide',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.9),
            fontStyle: FontStyle.italic,
          ),
        ),

        const SizedBox(height: 20),

        // Speech bubble with wisdom/information
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.format_quote,
                    color: widget.category['color'] as Color,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.currentTopic,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                _getGuideMessage(widget.currentTopic, isElderFemale),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (widget.category['color'] as Color).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: widget.category['color'] as Color,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _getWisdom(widget.currentTopic, isElderFemale),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: widget.category['color'] as Color,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getGuideMessage(String topic, bool isElderFemale) {
    // Sample messages based on topic and guide type
    final messages = {
      'The Casbah - Algiers': isElderFemale
          ? 'The Casbah, my dear, is the beating heart of Algeria, filled with history and stories from ancient times. Every stone tells a tale.'
          : 'The Casbah, my child, is the jewel of Algeria, built by the Ottomans and inhabited by Algerians for centuries. You get lost in it and find yourself in history.',
      'Algerian Kaftan': isElderFemale
          ? 'The Kaftan, my dear, is the dress of authenticity and beauty. Each region has its own way of embroidery and colors.'
          : 'The Kaftan is a beautiful traditional dress. Women wear it on special occasions, and each region has its own style.',
      'Henna Night': isElderFemale
          ? 'Henna Night, my dear, is a night of blessing and joy, where women gather to sing and dance for the bride.'
          : 'Henna Night is a beautiful tradition where women celebrate the bride and apply henna for blessing and beauty.',
      'Timgad - Batna': isElderFemale
          ? 'Timgad is a magnificent Roman city, my dear. It shows how different civilizations lived in our beautiful Algeria.'
          : 'Timgad, my son, is one of the best-preserved Roman cities in the world. It tells the story of ancient civilizations in Algeria.',
      'Friday Market - Algiers': isElderFemale
          ? 'Friday Market is where you find everything, my dear. It\'s the heart of popular life and authentic traditions.'
          : 'Friday Market, my child, is where you experience real Algerian life. Every corner has a story and every vendor has wisdom.',
      'Algerian Couscous': isElderFemale
          ? 'Couscous, my dear, is not just food, it\'s a symbol of family gathering and Algerian hospitality.'
          : 'Couscous, my son, is the king of Algerian cuisine. Each family has its own secret recipe passed down through generations.',
    };

    return messages[topic] ??
        (isElderFemale
            ? 'This is a beautiful topic, my dear, filled with rich heritage and history from our beloved Algeria.'
            : 'This is an important topic, my child, containing much of Algeria\'s rich heritage and ancient history.');
  }

  String _getWisdom(String topic, bool isElderFemale) {
    final wisdoms = [
      'Heritage is an imperishable treasure; those who preserve it preserve their identity',
      'Every stone in Algeria has a story, and every tradition has meaning',
      'Authenticity doesn\'t mean stagnation, but evolution while preserving roots',
      'Those who know their history know their path; those who forget their origins are lost',
      'Traditions are a bridge between the past and present',
      'Culture is the soul of a nation, and traditions are its heartbeat',
      'In every old custom lies the wisdom of generations',
      'The past teaches us, the present challenges us, and traditions guide us',
    ];

    return wisdoms[topic.hashCode % wisdoms.length];
  }
}

class TraditionalPatternPainter extends CustomPainter {
  final Color color;

  TraditionalPatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 3;

    // Draw traditional geometric pattern
    for (int i = 0; i < 8; i++) {
      final angle = (i * 45) * (3.14159 / 180);
      final start = Offset(
        center.dx + (radius * 0.5) * cos(angle),
        center.dy + (radius * 0.5) * sin(angle),
      );
      final end = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      canvas.drawLine(start, end, paint);
    }

    // Draw circles
    canvas.drawCircle(center, radius * 0.3, paint);
    canvas.drawCircle(center, radius * 0.6, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Helper function for trigonometric calculations
double cos(double angle) => math.cos(angle);
double sin(double angle) => math.sin(angle);
