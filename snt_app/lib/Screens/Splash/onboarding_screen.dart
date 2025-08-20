import 'package:flutter/material.dart';
import 'package:snt_app/Screens/login/login_screen.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:snt_app/Theme/text_styles.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  int _currentPage = 0;

  // Onboarding data
  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      image: 'lib/Assets/Images/Splash-screen2.jpg',
      title: 'Discover Science',
      subtitle: 'Explore the fascinating world of scientific discoveries and connect with fellow researchers and enthusiasts.',
    ),
    OnboardingData(
      image: 'lib/Assets/Images/Splash-screen2.jpg',
      title: 'Share Knowledge',
      subtitle: 'Share your scientific insights, research findings, and collaborate with the global scientific community.',
    ),
    OnboardingData(
      image: 'lib/Assets/Images/Splash-screen2.jpg',
      title: 'Join Events',
      subtitle: 'Participate in scientific conferences, workshops, and networking events to expand your horizons.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToHome();
    }
  }

  void _skipOnboarding() {
    _navigateToHome();
  }

  void _navigateToHome() {
    // Replace this with your actual home screen navigation
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(), // Replace with your home screen
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background PageView for images
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_onboardingData[index].image),
                    fit: BoxFit.cover,
                  ),
                ),
                // Dark overlay for better text readability
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.Main600.withOpacity(0.7),
                        AppColors.Main600.withOpacity(0.9),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          
          // Content overlay
          SafeArea(
            child: Column(
              children: [
                // Skip button
                if (_currentPage < _onboardingData.length - 1)
                  Padding(
                    padding: const EdgeInsets.only(top: 16, right: 20),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: _skipOnboarding,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Skip',
                              style: TextStyles.Subtitle.copyWith(
                                color: AppColors.White.withOpacity(0.9),
                                fontFamily: AppFonts.primaryFontFamily,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward,
                              color: AppColors.White.withOpacity(0.9),
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.Main600.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'lib/Assets/Images/logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                
                // Spacer to push content to bottom
                const Spacer(),
                
                // Bottom content section
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo
                     
                      // Title
                      Text(
                        _onboardingData[_currentPage].title,
                        style: TextStyles.Subtitle.copyWith(
                          color: AppColors.White,
                          fontSize: 28,
                          fontFamily: AppFonts.primaryFontFamily,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Subtitle
                      Text(
                        _onboardingData[_currentPage].subtitle,
                        style: TextStyles.EventDesc.copyWith(
                          color: AppColors.White.withOpacity(0.9),
                          fontSize: 16,
                          fontFamily: AppFonts.primaryFontFamily,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Dots indicator and button row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Dots indicator
                          Row(
                            children: List.generate(
                              _onboardingData.length,
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.only(right: 8),
                                width: _currentPage == index ? 24 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _currentPage == index
                                      ? AppColors.Accent500
                                      : AppColors.White.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),

                          // Next/Get Started button
                          
 TextButton(
                         onPressed: _nextPage,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                               _currentPage == _onboardingData.length - 1
                                        ? 'Get Started'
                                        : 'Next',
                              style: TextStyles.Subtitle.copyWith(
                                color: AppColors.White.withOpacity(0.9),
                                fontFamily: AppFonts.primaryFontFamily,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward,
                              color: AppColors.White.withOpacity(0.9),
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                        ],
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Remove the OnboardingPage class as it's no longer needed

class OnboardingData {
  final String image;
  final String title;
  final String subtitle;

  OnboardingData({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

