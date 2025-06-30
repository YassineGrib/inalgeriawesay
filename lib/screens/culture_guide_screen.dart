import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/culture_guide_widget.dart';

class CultureGuideScreen extends StatefulWidget {
  final Map<String, dynamic> category;

  const CultureGuideScreen({
    super.key,
    required this.category,
  });

  @override
  State<CultureGuideScreen> createState() => _CultureGuideScreenState();
}

class _CultureGuideScreenState extends State<CultureGuideScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  int _currentTopicIndex = 0;
  bool _isGuideVisible = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topics = widget.category['topics'] as List<String>;
    final guideType = widget.category['guide_type'] as String;
    final isElderFemale = guideType == 'elder_female';

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          widget.category['title'] as String,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: widget.category['color'] as Color,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(
              _isGuideVisible ? Icons.visibility_off : Icons.visibility,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isGuideVisible = !_isGuideVisible;
              });
            },
            tooltip: _isGuideVisible ? 'Hide Guide' : 'Show Guide',
          ),
        ],
      ),
      body: Column(
        children: [
          // Guide character section
          if (_isGuideVisible)
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        widget.category['color'] as Color,
                        (widget.category['color'] as Color).withValues(alpha: 0.8),
                        AppColors.backgroundLight,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CultureGuideWidget(
                      guideType: guideType,
                      category: widget.category,
                      currentTopic: topics[_currentTopicIndex],
                    ),
                  ),
                ),
              ),
            ),

          // Topics list
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Topics:',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: topics.length,
                      itemBuilder: (context, index) {
                        final isSelected = index == _currentTopicIndex;
                        return _buildTopicCard(
                          context,
                          topics[index],
                          index,
                          isSelected,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Navigation controls
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: _currentTopicIndex > 0
                      ? () {
                          setState(() {
                            _currentTopicIndex--;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Previous'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.algerianGreen,
                    foregroundColor: Colors.white,
                  ),
                ),
                Text(
                  '${_currentTopicIndex + 1} of ${topics.length}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _currentTopicIndex < topics.length - 1
                      ? () {
                          setState(() {
                            _currentTopicIndex++;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Next'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.algerianGreen,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicCard(
    BuildContext context,
    String topic,
    int index,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentTopicIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    widget.category['color'] as Color,
                    (widget.category['color'] as Color).withValues(alpha: 0.8),
                  ],
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? widget.category['color'] as Color
                : Colors.grey.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? (widget.category['color'] as Color).withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.05),
              blurRadius: isSelected ? 8 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.2)
                    : (widget.category['color'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : widget.category['color'] as Color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                topic,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.play_circle_filled,
                color: Colors.white.withValues(alpha: 0.8),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
