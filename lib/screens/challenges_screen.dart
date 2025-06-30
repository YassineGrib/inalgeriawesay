import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/cultural_challenge.dart';
import '../services/data_service.dart';
import '../services/user_service.dart';
import '../widgets/challenge_card_widget.dart';
import 'challenge_screen.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  final DataService _dataService = DataService();
  final UserService _userService = UserService();
  
  List<CulturalChallenge> _challenges = [];
  List<CulturalChallenge> _filteredChallenges = [];
  List<String> _completedChallenges = [];
  bool _isLoading = true;
  String _selectedType = 'All';
  String _currentLanguage = 'english';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final challenges = await _dataService.loadChallenges();
      final completed = await _userService.getCompletedChallenges();
      
      setState(() {
        _challenges = challenges;
        _filteredChallenges = challenges;
        _completedChallenges = completed;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading challenges: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _filterChallenges() {
    final query = _searchController.text.toLowerCase();
    
    setState(() {
      _filteredChallenges = _challenges.where((challenge) {
        // Filter by type
        final typeMatch = _selectedType == 'All' || 
            challenge.type.name.toLowerCase() == _selectedType.toLowerCase();
        
        // Filter by search query
        final searchMatch = query.isEmpty ||
            challenge.title.toLowerCase().contains(query) ||
            challenge.description.toLowerCase().contains(query) ||
            (challenge.tags?.any((tag) => tag.toLowerCase().contains(query)) ?? false);
        
        return typeMatch && searchMatch;
      }).toList();
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      _currentLanguage = language;
    });
  }

  void _changeType(String type) {
    setState(() {
      _selectedType = type;
    });
    _filterChallenges();
  }

  List<String> _getAvailableTypes() {
    final types = _challenges.map((c) => c.type.name).toSet().toList();
    types.insert(0, 'All');
    return types;
  }

  bool _isChallengeCompleted(String challengeId) {
    return _completedChallenges.contains(challengeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Cultural Challenges'),
        backgroundColor: AppColors.algerianGreen,
        foregroundColor: AppColors.algerianWhite,
        elevation: 0,
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.algerianGreen),
            )
          : Column(
              children: [
                // Search and filter section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.algerianWhite,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.algerianGreen.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Search bar
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search challenges...',
                          prefixIcon: const Icon(Icons.search, color: AppColors.algerianGreen),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    _filterChallenges();
                                  },
                                )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.algerianGreen),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.algerianGreen, width: 2),
                          ),
                        ),
                        onChanged: (value) => _filterChallenges(),
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Type filter
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _getAvailableTypes().map((type) {
                            final isSelected = _selectedType == type;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilterChip(
                                label: Text(type),
                                selected: isSelected,
                                onSelected: (selected) => _changeType(type),
                                selectedColor: AppColors.algerianGreen.withValues(alpha: 0.2),
                                checkmarkColor: AppColors.algerianGreen,
                                side: BorderSide(
                                  color: isSelected 
                                      ? AppColors.algerianGreen 
                                      : AppColors.textSecondary,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),

                // Progress summary
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.algerianGreen.withValues(alpha: 0.1),
                        AppColors.goldAccent.withValues(alpha: 0.1),
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        color: AppColors.goldAccent,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Completed: ${_completedChallenges.length}/${_challenges.length}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.algerianGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      if (_filteredChallenges.isNotEmpty)
                        Text(
                          '${_filteredChallenges.length} challenge${_filteredChallenges.length == 1 ? '' : 's'} shown',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                    ],
                  ),
                ),

                // Challenges grid
                Expanded(
                  child: _filteredChallenges.isEmpty
                      ? _buildEmptyState()
                      : Padding(
                          padding: const EdgeInsets.all(16),
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 1.8,
                            ),
                            itemCount: _filteredChallenges.length,
                            itemBuilder: (context, index) {
                              final challenge = _filteredChallenges[index];
                              final isCompleted = _isChallengeCompleted(challenge.id);
                              
                              return ChallengeCardWidget(
                                challenge: challenge,
                                language: _currentLanguage,
                                isCompleted: isCompleted,
                                onTap: () async {
                                  final result = await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ChallengeScreen(
                                        challenge: challenge,
                                        language: _currentLanguage,
                                      ),
                                    ),
                                  );
                                  
                                  // Refresh completed challenges after returning
                                  if (result != null) {
                                    _loadData();
                                  }
                                },
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: AppColors.textSecondary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No challenges found',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filter criteria',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _searchController.clear();
              _changeType('All');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.algerianGreen,
              foregroundColor: AppColors.algerianWhite,
            ),
            child: const Text('Clear Filters'),
          ),
        ],
      ),
    );
  }
}
