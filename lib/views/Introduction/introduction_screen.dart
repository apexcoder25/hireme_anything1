import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/session_manage/session_user_side_manage.dart';
import 'package:hire_any_thing/views/UserHomePage/user_home_page.dart';

class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  int _currentIndex = 0;
  Key _screenKey = UniqueKey();

  final List<Map<String, dynamic>> slides = [
    {
      'image': 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=75',
      'title': 'Expert Services at Your Fingertips',
      'subtitle': 'Connect with verified professionals for all your service needs',
      'features': [
        {'title': 'Flexible', 'subtitle': 'Available'},
        {'title': 'Best', 'subtitle': 'Quality'},
        {'title': 'Time Saving', 'subtitle': 'Quality'},
      ],
    },
    {
      'image': 'https://images.unsplash.com/photo-1503376780353-7e6692767b70?q=80&w=2070&auto=format&fit=crop',
      'title': 'Professional Tutoring',
      'subtitle': 'Expert tutors for all subjects and levels',
      'features': [
        {'title': '24/7', 'subtitle': 'Available'},
        {'title': '100%', 'subtitle': 'Success'},
        {'title': 'Fast', 'subtitle': 'Response'},
      ],
    },
    {
      'image': 'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?q=80&w=2071&auto=format&fit=crop',
      'title': 'Reliable Transport',
      'subtitle': 'Professional transport for all your moving needs',
      'features': [
        {'title': '24/7', 'subtitle': 'Available'},
        {'title': '100%', 'subtitle': 'Safety'},
        {'title': 'Fast', 'subtitle': 'Response'},
      ],
    },
  ];

  Future<void> _markOnboardingAsSeen() async {
    final sessionManager = SessionManageerUserSide();
    await sessionManager.setHasSeenOnboarding(true);
  }

  void _nextSlide() {
    if (_currentIndex < slides.length - 1) {
      setState(() {
        _currentIndex++;
        _screenKey = UniqueKey();
      });
    } else {
      _markOnboardingAsSeen(); // Mark onboarding as seen
      Get.off(() => UserHomePageScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _screenKey,
      body: SizedBox(
        height: height,
        child: Stack(
          children: [
            CarouselSlider.builder(
              options: CarouselOptions(
                height: height,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                viewportFraction: 1.0,
                initialPage: _currentIndex,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              itemCount: slides.length,
              itemBuilder: (context, index, realIndex) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      slides[index]['image'],
                      fit: BoxFit.cover,
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.3),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          slides[index]['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          slides[index]['subtitle'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: slides[index]['features']
                              .map<Widget>((feature) => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: FeatureBox(
                                      title: feature['title'],
                                      subtitle: feature['subtitle'],
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: slides.asMap().entries.map((entry) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(
                        _currentIndex == entry.key ? 0.9 : 0.4,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Positioned(
              bottom: 40,
              right: 20,
              child: FloatingActionButton(
                onPressed: _nextSlide,
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureBox extends StatelessWidget {
  final String title;
  final String subtitle;

  const FeatureBox({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}