import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/User_app/views/user_profle/controller/user_profile_controller.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/category_controller.dart';
import 'package:hire_any_thing/data/models/user_side_model/category_model.dart';
import 'package:hire_any_thing/res/routes/routes.dart';
import 'package:hire_any_thing/User_app/views/UserHomePage/categories_icons_widget.dart';
import 'package:hire_any_thing/User_app/views/contactUs_screen/contact_us.dart';

class UserHomePageScreen extends StatefulWidget {
  @override
  _UserHomePageScreenState createState() => _UserHomePageScreenState();
}

class _UserHomePageScreenState extends State<UserHomePageScreen> {
  final CategoryController controller = Get.put(CategoryController());
  final ScrollController _scrollController = ScrollController();
  final UserProfileController profileController = Get.put(UserProfileController());

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      profileController.fetchProfile();
      controller.fetchCategories();
      _startAutoScroll();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    if (_scrollController.hasClients) {
      _scrollController
          .animateTo(
        _scrollController.position.maxScrollExtent,
        duration:const Duration(seconds: 5),
        curve: Curves.fastOutSlowIn,
      )
          .then((value) {
        if (mounted) {
          _scrollController.jumpTo(0);
          _startAutoScroll();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[20],
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: () async {
            await controller.fetchCategories();
            await profileController.fetchProfile();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: Text(
                    'Discover Our Wide Range of Categories',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                CategoriesCarouselScreen(),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'Find Affordable Options from Nearby Service Providers',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                _buildCategoriesCarousel(context, controller.categories),
                const SizedBox(height: 32),
                const Text(
                  'Find Affordable Options from Nearby Rental Providers',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                _buildOfferingsCarousel(context, controller.categories),
                const SizedBox(height: 32),
                _buildCustomPackageSection(context),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCategoriesCarousel(
      BuildContext context, List<CategoryModelss> categories) {
    // Static list of categories with colors and icons
    final List<Map<String, dynamic>> staticCategories = [
      {
        'name': 'Passenger Transport',
        'color': Colors.lightBlue[100],
        'icon': Icons.directions_car,
        'route': UserRoutesName.passengerTransportHireScreen,
      },
      {
        'name': 'Tutor Hire',
        'color': Colors.purple[100],
        'icon': Icons.school,
        'route': UserRoutesName.tutorHireScreen,
      },
      {
        'name': 'Artist Hire',
        'color': Colors.pink[100],
        'icon': Icons.brush,
        'route': UserRoutesName.artistHireScreen,
      },
      {
        'name': 'Automotive and Electric Hire',
        'color': Colors.green[100],
        'icon': Icons.electric_car,
        'route': UserRoutesName.MeetingRoomHireScreen,
      },
      {
        'name': 'Bouncy Castle Hire',
        'color': Colors.purple[200],
        'icon': Icons.toys,
        'route': UserRoutesName.MeetingRoomHireScreen,
      },
      {
        'name': 'Haulage Truck Hire',
        'color': Colors.blue[100],
        'icon': Icons.local_shipping,
        'route': UserRoutesName.MeetingRoomHireScreen,
      },
      {
        'name': 'Marquee Hire',
        'color': Colors.pink[200],
        'icon': Icons.event,
        'route': UserRoutesName.MeetingRoomHireScreen,
      },
      {
        'name': 'Motorhome Hire',
        'color': Colors.purple[300],
        'icon': Icons.rv_hookup,
        'route': UserRoutesName.MeetingRoomHireScreen,
      },
      {
        'name': 'Musician Hire',
        'color': Colors.green[200],
        'icon': Icons.music_note,
        'route': UserRoutesName.MeetingRoomHireScreen,
      },
      {
        'name': 'Photographers',
        'color': Colors.yellow[100],
        'icon': Icons.camera_alt,
        'route': UserRoutesName.MeetingRoomHireScreen,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Popular Service Categories',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 150,
          height: 2,
          color: Colors.orange,
        ),
        const SizedBox(height: 8),
        Text(
          'Find trusted professionals for all your service needs',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.4,
          ),
          itemCount: staticCategories.length,
          itemBuilder: (context, index) {
            final category = staticCategories[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () {
                  Get.toNamed(category['route']);
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        category['color'],
                        (category['color'] as Color).withOpacity(0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        category['icon'],
                        size: 28,
                        color: Colors.black87,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        category['name'],
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(UserRoutesName.allCategoryView);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.orange,
            side: const BorderSide(color: Colors.orange, width: 2),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 0,
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'View All Categories',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, size: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOfferingsCarousel(
      BuildContext context, List<CategoryModelss> categories) {
    if (categories.isEmpty) {
      return Container(
        height: 200,
        child: const Center(
          child: Text(
            'No categories available',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            width: MediaQuery.of(context).size.width * 0.65,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    child: Image.network(
                      category.categoryImage,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.category,
                                color: Colors.blue,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                category.categoryName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: Text(
                            category.description,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.4,
                            ),
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCustomPackageSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.grey[50]!,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.help_outline,
              color: Colors.orange,
              size: 30,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Did not find your Package?',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Feel free to ask us.\nWe\'ll make it for you',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            "Don't worry if you haven't found exactly what you're looking for on our platform. At HireAnything, we're dedicated to meeting your unique needs. Simply reach out to us with your specific requirements, and our team will work diligently to create a tailored package just for you.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.to(() => const ContactUsScreen());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 3,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.chat, size: 18),
                SizedBox(width: 8),
                Text(
                  'REQUEST CUSTOM PRICE',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
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
