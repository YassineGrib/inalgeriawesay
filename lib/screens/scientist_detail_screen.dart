import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/scientist.dart';

class ScientistDetailScreen extends StatefulWidget {
  final Scientist scientist;
  final String initialLanguage;

  const ScientistDetailScreen({
    super.key,
    required this.scientist,
    this.initialLanguage = 'english',
  });

  @override
  State<ScientistDetailScreen> createState() => _ScientistDetailScreenState();
}

class _ScientistDetailScreenState extends State<ScientistDetailScreen> {
  late String _currentLanguage;

  @override
  void initState() {
    super.initState();
    _currentLanguage = widget.initialLanguage;
  }

  String _getScientistName() {
    switch (_currentLanguage.toLowerCase()) {
      case 'arabic':
        return widget.scientist.nameArabic;
      case 'amazigh':
        return widget.scientist.nameAmazigh;
      default:
        return widget.scientist.name;
    }
  }

  String _getScientistBio() {
    switch (_currentLanguage.toLowerCase()) {
      case 'arabic':
        return widget.scientist.bioArabic;
      case 'amazigh':
        return widget.scientist.bioAmazigh;
      default:
        return widget.scientist.bio;
    }
  }

  List<String> _getAchievements() {
    switch (_currentLanguage.toLowerCase()) {
      case 'arabic':
        return widget.scientist.achievementsArabic;
      case 'amazigh':
        return widget.scientist.achievementsAmazigh;
      default:
        return widget.scientist.achievements;
    }
  }

  void _changeLanguage(String language) {
    setState(() {
      _currentLanguage = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          // App Bar with photo
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.algerianGreen,
            foregroundColor: AppColors.algerianWhite,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                _getScientistName(),
                style: const TextStyle(
                  color: AppColors.algerianWhite,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 3,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.algerianGreen,
                      AppColors.algerianGreen.withValues(alpha: 0.7),
                    ],
                  ),
                ),
                child: widget.scientist.photoUrl.isNotEmpty
                    ? Image.asset(
                        'assets/images/${widget.scientist.photoUrl}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholderPhoto();
                        },
                      )
                    : _buildPlaceholderPhoto(),
              ),
            ),
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.language),
                onSelected: _changeLanguage,
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'english',
                    child: Row(
                      children: [
                        Icon(Icons.language, color: AppColors.algerianGreen),
                        SizedBox(width: 8),
                        Text('English'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'arabic',
                    child: Row(
                      children: [
                        Icon(Icons.language, color: AppColors.algerianRed),
                        SizedBox(width: 8),
                        Text('العربية'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'amazigh',
                    child: Row(
                      children: [
                        Icon(Icons.language, color: AppColors.goldAccent),
                        SizedBox(width: 8),
                        Text('ⵜⴰⵎⴰⵣⵉⵖⵜ'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Basic Info Card
                  _buildInfoCard(),
                  
                  const SizedBox(height: 24),
                  
                  // Biography Section
                  _buildBiographySection(),
                  
                  const SizedBox(height: 24),
                  
                  // Achievements Section
                  _buildAchievementsSection(),
                  
                  const SizedBox(height: 24),
                  
                  // Tags Section
                  if (widget.scientist.tags != null && widget.scientist.tags!.isNotEmpty)
                    _buildTagsSection(),
                  
                  const SizedBox(height: 24),
                  
                  // External Link
                  if (widget.scientist.wikipediaUrl != null)
                    _buildExternalLinkSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderPhoto() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.algerianGreen,
            AppColors.algerianRed.withValues(alpha: 0.8),
          ],
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.person,
          size: 120,
          color: AppColors.algerianWhite,
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.algerianGreen,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Basic Information',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.algerianGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Field', widget.scientist.field, Icons.work),
            _buildInfoRow('Birth Year', widget.scientist.birthYear, Icons.cake),
            if (widget.scientist.deathYear != null && widget.scientist.deathYear!.isNotEmpty)
              _buildInfoRow('Death Year', widget.scientist.deathYear!, Icons.event),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBiographySection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person_outline,
                  color: AppColors.algerianRed,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Biography',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.algerianRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              _getScientistBio(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textPrimary,
                height: 1.6,
              ),
              textDirection: _currentLanguage == 'arabic' ? TextDirection.rtl : TextDirection.ltr,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsSection() {
    final achievements = _getAchievements();
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.star_outline,
                  color: AppColors.goldAccent,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Major Achievements',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.goldAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...achievements.map((achievement) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.goldAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      achievement,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                        height: 1.4,
                      ),
                      textDirection: _currentLanguage == 'arabic' ? TextDirection.rtl : TextDirection.ltr,
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildTagsSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.label_outline,
                  color: AppColors.algerianGreen,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Related Topics',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.algerianGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.scientist.tags!.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.algerianGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.algerianGreen.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    tag,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.algerianGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExternalLinkSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.link,
                  color: AppColors.algerianRed,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Learn More',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.algerianRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Open Wikipedia URL
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('External links will open in browser'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(Icons.open_in_new),
              label: const Text('View on Wikipedia'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.algerianRed,
                foregroundColor: AppColors.algerianWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
