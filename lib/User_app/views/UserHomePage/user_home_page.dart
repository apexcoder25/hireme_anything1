import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/category_controller.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/user_profile_controller.dart';
import 'package:hire_any_thing/data/models/user_side_model/category_model.dart';
import 'package:hire_any_thing/res/routes/routes.dart';
import 'package:hire_any_thing/User_app/views/UserHomePage/categories_icons_widget.dart';
import 'package:hire_any_thing/User_app/views/UserHomePage/user_drawer.dart';
import 'package:hire_any_thing/User_app/views/contactUs/contact_us.dart';

class UserHomePageScreen extends StatefulWidget {
  @override
  _UserHomePageScreenState createState() => _UserHomePageScreenState();
}

class _UserHomePageScreenState extends State<UserHomePageScreen> {
  final CategoryController controller = Get.put(CategoryController());
  final ScrollController _scrollController = ScrollController();
  final UserProfileController profileController =
      Get.put(UserProfileController());

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      profileController.fetchProfile();
      _startAutoScroll();
    });
  }

  void _onDrawerItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
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
        duration: Duration(seconds: 5),
        curve: Curves.fastOutSlowIn,
      )
          .then((value) {
        _scrollController.jumpTo(0);
        _startAutoScroll();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[50],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Explore Our Services',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu, color: colors.black),
          ),
        ),
      ),
      drawer: UserDrawer(onItemSelected: _onDrawerItemSelected),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
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
                ),
              ),
              CategoriesCarouselScreen(),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Find Affordable Options from Nearby Service Providers',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 20),
              _buildCategoriesCarousel(context, controller.categories),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              const Text(
                textAlign: TextAlign.center,
                'Find Affordable Options from Nearby Rental Providers',
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
        ),
        SizedBox(height: 16),
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
            return ElevatedButton(
              onPressed: () {
                Get.toNamed(category['route']);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: category['color'],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    category['icon'],
                    size: 30,
                    color: Colors.black54,
                  ),
                  SizedBox(height: 8),
                  Text(
                    category['name'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
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
            foregroundColor: Colors.black,
            side: const BorderSide(color: Colors.orange, width: 2),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'View All Categories',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, color: Colors.black),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        title,
        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildOfferingsCarousel(
      BuildContext context, List<CategoryModelss> categories) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.47,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            width: MediaQuery.of(context).size.width * 0.5,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    category.categoryImage,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.error, color: Colors.red),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.category, color: Colors.blue),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              category.categoryName,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        category.description,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        textAlign: TextAlign.start,
                        maxLines: 7,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Did not find your Package?',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const Text(
            'Feel free to ask us.\nWe\'ll make it for you',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 8),
          Text(
            "Don’t worry if you haven’t found exactly what you’re looking for on our platform. At HireAnything, we’re dedicated to meeting your unique needs. Simply reach out to us with your specific requirements, and our team will work diligently to create a tailored package just for you.",
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Get.to(ContactUsScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child:
                  Text('REQUEST CUSTOM PRICE', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
