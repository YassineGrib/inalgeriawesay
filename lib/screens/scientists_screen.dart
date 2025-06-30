import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/scientist.dart';
import '../services/data_service.dart';
import '../widgets/scientist_card_widget.dart';
import 'scientist_detail_screen.dart';

class ScientistsScreen extends StatefulWidget {
  const ScientistsScreen({super.key});

  @override
  State<ScientistsScreen> createState() => _ScientistsScreenState();
}

class _ScientistsScreenState extends State<ScientistsScreen> {
  final DataService _dataService = DataService();
  List<Scientist> _scientists = [];
  List<Scientist> _filteredScientists = [];
  bool _isLoading = true;
  String _selectedField = 'All';
  String _currentLanguage = 'english';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadScientists();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadScientists() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final scientists = await _dataService.loadScientists();
      setState(() {
        _scientists = scientists;
        _filteredScientists = scientists;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading scientists: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _filterScientists() {
    final query = _searchController.text.toLowerCase();
    
    setState(() {
      _filteredScientists = _scientists.where((scientist) {
        // Filter by field
        final fieldMatch = _selectedField == 'All' || 
            scientist.field.toLowerCase().contains(_selectedField.toLowerCase());
        
        // Filter by search query
        final searchMatch = query.isEmpty ||
            scientist.name.toLowerCase().contains(query) ||
            scientist.nameArabic.toLowerCase().contains(query) ||
            scientist.nameAmazigh.toLowerCase().contains(query) ||
            scientist.field.toLowerCase().contains(query);
        
        return fieldMatch && searchMatch;
      }).toList();
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      _currentLanguage = language;
    });
  }

  void _changeField(String field) {
    setState(() {
      _selectedField = field;
    });
    _filterScientists();
  }

  List<String> _getAvailableFields() {
    final fields = _scientists.map((s) => s.field).toSet().toList();
    fields.insert(0, 'All');
    return fields;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Famous Algerian Scientists'),
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
                    Icon(Icons.language, color: AppColors.tealAccent),
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
                          hintText: 'Search scientists...',
                          prefixIcon: const Icon(Icons.search, color: AppColors.algerianGreen),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    _filterScientists();
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
                        onChanged: (value) => _filterScientists(),
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Field filter
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _getAvailableFields().map((field) {
                            final isSelected = _selectedField == field;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilterChip(
                                label: Text(field),
                                selected: isSelected,
                                onSelected: (selected) => _changeField(field),
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

                // Results count
                if (_filteredScientists.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      '${_filteredScientists.length} scientist${_filteredScientists.length == 1 ? '' : 's'} found',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),

                // Scientists grid
                Expanded(
                  child: _filteredScientists.isEmpty
                      ? _buildEmptyState()
                      : Padding(
                          padding: const EdgeInsets.all(16),
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: _filteredScientists.length,
                            itemBuilder: (context, index) {
                              final scientist = _filteredScientists[index];
                              return ScientistCardWidget(
                                scientist: scientist,
                                language: _currentLanguage,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ScientistDetailScreen(
                                        scientist: scientist,
                                        initialLanguage: _currentLanguage,
                                      ),
                                    ),
                                  );
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
            'No scientists found',
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
              _changeField('All');
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
