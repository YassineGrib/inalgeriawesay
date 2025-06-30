import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../constants/app_colors.dart';
import 'main_menu_screen.dart';

class PromotionalVideoScreen extends StatefulWidget {
  const PromotionalVideoScreen({super.key});

  @override
  State<PromotionalVideoScreen> createState() => _PromotionalVideoScreenState();
}

class _PromotionalVideoScreenState extends State<PromotionalVideoScreen> {
  late VideoPlayerController _videoController;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _videoController = VideoPlayerController.asset('assets/videos/alg.mp4')
      ..initialize().then((_) {
        setState(() {
          _isPlayerReady = true;
        });
        _videoController.play();
        _videoController.setLooping(true);
      });

    _videoController.addListener(() {
      if (_videoController.value.position >= _videoController.value.duration) {
        // Video ended, continue to app
        _continueToApp();
      }
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _continueToApp() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainMenuScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Welcome to Algeria'),
        backgroundColor: AppColors.algerianGreen,
        foregroundColor: AppColors.algerianWhite,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _continueToApp,
            child: const Text(
              'Skip',
              style: TextStyle(
                color: AppColors.algerianWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Video section
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.algerianWhite,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.algerianGreen.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: _buildVideoContent(),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Description section
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      'Discover Algeria',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.algerianGreen,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Experience the rich culture, diverse dialects, and beautiful traditions of Algeria through interactive conversations and immersive learning.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _continueToApp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.algerianRed,
                    foregroundColor: AppColors.algerianWhite,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Start Exploring',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.explore, size: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoContent() {
    if (!_isPlayerReady) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColors.algerianRed,
          ),
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: _videoController.value.aspectRatio,
          child: VideoPlayer(_videoController),
        ),
        // Video controls overlay
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Play/Pause button
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_videoController.value.isPlaying) {
                      _videoController.pause();
                    } else {
                      _videoController.play();
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: AppColors.algerianWhite,
                    size: 24,
                  ),
                ),
              ),
              // Progress indicator
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: VideoProgressIndicator(
                    _videoController,
                    allowScrubbing: true,
                    colors: const VideoProgressColors(
                      playedColor: AppColors.algerianRed,
                      bufferedColor: AppColors.algerianGreen,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
} 