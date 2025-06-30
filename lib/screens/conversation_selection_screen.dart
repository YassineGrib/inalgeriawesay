import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/dialogue.dart';
import '../models/conversation_category.dart';
import '../services/conversation_service.dart';
import 'dialogue_screen.dart';

class ConversationSelectionScreen extends StatefulWidget {
  final ConversationSubcategory subcategory;
  final String? categoryTitle;

  const ConversationSelectionScreen({
    super.key,
    required this.subcategory,
    this.categoryTitle,
  });

  @override
  State<ConversationSelectionScreen> createState() => _ConversationSelectionScreenState();
}

class _ConversationSelectionScreenState extends State<ConversationSelectionScreen> {
  Language? _selectedLanguage;
  bool _isLoading = false;
  List<Language> _availableLanguages = [];

  @override
  void initState() {
    super.initState();
    _loadAvailableLanguages();
  }

  Future<void> _loadAvailableLanguages() async {
    if (widget.subcategory.filePath == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final languages = await ConversationService.getAvailableLanguages(
        widget.subcategory.filePath!,
      );

      setState(() {
        _availableLanguages = languages;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _availableLanguages = [];
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في تحميل اللغات المتاحة: $e'),
            backgroundColor: AppColors.algerianRed,
          ),
        );
      }
    }
  }

  // Temporarily disabled - no dialogue data available
  // Future<void> _loadAvailableOptions() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     await _dataService.loadDialogues();
  //     await _updateAvailableDialogues();
  //   } catch (e) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Error loading dialogues: $e'),
  //           backgroundColor: AppColors.error,
  //         ),
  //       );
  //     }
  //   } finally {
  //     if (mounted) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   }
  // }

  // Future<void> _updateAvailableDialogues() async {
  //   // Temporarily return empty list - no dialogue data available
  //   setState(() {
  //     _availableDialogues = [];
  //   });
  // }

  Future<void> _startDirectDialogue() async {
    if (_selectedLanguage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى اختيار لغة أولاً'),
          backgroundColor: AppColors.algerianRed,
        ),
      );
      return;
    }

    if (widget.subcategory.filePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('مسار الملف غير محدد'),
          backgroundColor: AppColors.algerianRed,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final dialogue = await ConversationService.loadConversationByPath(
        folderPath: widget.subcategory.filePath!,
        language: _selectedLanguage!,
      );

      setState(() {
        _isLoading = false;
      });

      if (dialogue == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('لا توجد محادثة متاحة للغة المختارة'),
              backgroundColor: AppColors.algerianRed,
            ),
          );
        }
        return;
      }

      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DialogueScreen(dialogue: dialogue),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في تحميل المحادثة: $e'),
            backgroundColor: AppColors.algerianRed,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(widget.categoryTitle ?? 'اختيار المحادثة'),
        backgroundColor: AppColors.algerianGreen,
        foregroundColor: AppColors.algerianWhite,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.algerianGreen),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Scenario Header
                  if (widget.categoryTitle != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.algerianGreen,
                            AppColors.algerianGreen.withValues(alpha: 0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                color: AppColors.algerianWhite,
                                size: 28,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'السيناريو المختار:',
                                  style: const TextStyle(
                                    color: AppColors.algerianWhite,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.categoryTitle!,
                            style: const TextStyle(
                              color: AppColors.algerianWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Language Selection Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.algerianGreen.withValues(alpha: 0.1),
                          AppColors.algerianRed.withValues(alpha: 0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.algerianGreen.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 48,
                          color: AppColors.algerianGreen,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Select Your Learning Preferences',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppColors.algerianGreen,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Choose language to find the perfect conversation for you',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Standard Arabic Section
                  _buildSectionTitle('العربية الفصحى'),
                  const SizedBox(height: 12),
                  _buildStandardArabicSelector(),

                  const SizedBox(height: 24),

                  // Amazigh Section
                  _buildSectionTitle('الأمازيغية'),
                  const SizedBox(height: 12),
                  _buildAmazighSelector(),

                  const SizedBox(height: 24),

                  // Dialects Section
                  _buildSectionTitle('اللهجات الجزائرية'),
                  const SizedBox(height: 12),
                  _buildDialectsSelector(),

                  const SizedBox(height: 32),

                  // Available languages count
                  if (_availableLanguages.isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.success.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: AppColors.success,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '${_availableLanguages.length} لغة متاحة',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  const SizedBox(height: 32),

                  // Start button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _selectedLanguage != null && _availableLanguages.contains(_selectedLanguage)
                          ? _startDirectDialogue
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.algerianRed,
                        foregroundColor: AppColors.algerianWhite,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: AppColors.algerianWhite,
                                strokeWidth: 2,
                              ),
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'بدء المحادثة',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.play_arrow, size: 24),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: AppColors.algerianGreen,
        fontWeight: FontWeight.bold,
      ),
    );
  }



  Widget _buildStandardArabicSelector() {
    final isSelected = _selectedLanguage == Language.standardArabic;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = isSelected ? null : Language.standardArabic;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.algerianGreen : AppColors.algerianWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.algerianGreen,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.algerianGreen.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.algerianWhite.withValues(alpha: 0.2) : AppColors.algerianGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.menu_book,
                color: isSelected ? AppColors.algerianWhite : AppColors.algerianGreen,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'العربية الفصحى',
                    style: TextStyle(
                      color: isSelected ? AppColors.algerianWhite : AppColors.algerianGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Standard Arabic',
                    style: TextStyle(
                      color: isSelected ? AppColors.algerianWhite.withValues(alpha: 0.8) : AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.algerianWhite,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmazighSelector() {
    final isSelected = _selectedLanguage == Language.amazigh;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = isSelected ? null : Language.amazigh;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.algerianRed : AppColors.algerianWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.algerianRed,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.algerianRed.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.algerianWhite.withValues(alpha: 0.2) : AppColors.algerianRed.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.star,
                color: isSelected ? AppColors.algerianWhite : AppColors.algerianRed,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الأمازيغية',
                    style: TextStyle(
                      color: isSelected ? AppColors.algerianWhite : AppColors.algerianRed,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Amazigh (Tamazight)',
                    style: TextStyle(
                      color: isSelected ? AppColors.algerianWhite.withValues(alpha: 0.8) : AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.algerianWhite,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDialectsSelector() {
    final dialects = [
      Language.easternDialect,
      Language.westernDialect,
      Language.northernDialect,
      Language.southernDialect,
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: dialects.map((dialect) {
        final isSelected = _selectedLanguage == dialect;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedLanguage = isSelected ? null : dialect;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.algerianRed : AppColors.algerianWhite,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.algerianRed,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.algerianRed.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.algerianWhite.withValues(alpha: 0.2) : AppColors.algerianRed.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    _getDialectIcon(dialect),
                    color: isSelected ? AppColors.algerianWhite : AppColors.algerianRed,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _getDialectLabel(dialect),
                      style: TextStyle(
                        color: isSelected ? AppColors.algerianWhite : AppColors.algerianRed,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      _getDialectEnglishLabel(dialect),
                      style: TextStyle(
                        color: isSelected ? AppColors.algerianWhite.withValues(alpha: 0.8) : AppColors.textSecondary,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                if (isSelected) ...[
                  const SizedBox(width: 8),
                  Icon(
                    Icons.check_circle,
                    color: AppColors.algerianWhite,
                    size: 16,
                  ),
                ],
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  IconData _getDialectIcon(Language dialect) {
    switch (dialect) {
      case Language.easternDialect:
        return Icons.wb_sunny; // شمس للشرق
      case Language.westernDialect:
        return Icons.waves; // أمواج للغرب (البحر)
      case Language.northernDialect:
        return Icons.landscape; // جبال للشمال
      case Language.southernDialect:
        return Icons.terrain; // صحراء للجنوب
      case Language.standardArabic:
        return Icons.menu_book; // كتاب للفصحى
      case Language.amazigh:
        return Icons.star; // نجمة للأمازيغية
    }
  }

  String _getDialectLabel(Language dialect) {
    switch (dialect) {
      case Language.easternDialect:
        return 'اللهجة الشرقية';
      case Language.westernDialect:
        return 'اللهجة الغربية';
      case Language.northernDialect:
        return 'اللهجة الشمالية';
      case Language.southernDialect:
        return 'اللهجة الجنوبية';
      case Language.standardArabic:
        return 'العربية الفصحى';
      case Language.amazigh:
        return 'الأمازيغية';
    }
  }

  String _getDialectEnglishLabel(Language dialect) {
    switch (dialect) {
      case Language.easternDialect:
        return 'Eastern Dialect';
      case Language.westernDialect:
        return 'Western Dialect';
      case Language.northernDialect:
        return 'Northern Dialect';
      case Language.southernDialect:
        return 'Southern Dialect';
      case Language.standardArabic:
        return 'Standard Arabic';
      case Language.amazigh:
        return 'Amazigh (Berber)';
    }
  }


}
