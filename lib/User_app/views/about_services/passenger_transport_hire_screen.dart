import 'package:flutter/material.dart';
import 'package:hire_any_thing/utilities/AppConstant.dart';
import 'package:hire_any_thing/utilities/constant.dart';
import 'package:hire_any_thing/User_app/views/widget/service_section.dart';

class PassengerTransportHireDetailsScreen extends StatelessWidget {
  const PassengerTransportHireDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Passenger Transport Hire"),
        centerTitle: true,
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: const Text(
                      "ABOUT OUR PASSENGER TRANSPORT SERVICES",
                      style: AppTextStyles.sectionTitleGradient,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "We offer reliable and comfortable passenger transport solutions for individuals and groups. Whether it’s for corporate events, airport transfers, or special occasions, our fleet ensures safe and efficient travel.",
                    style: AppTextStyles.bodyText,
                  ),
                  const SizedBox(height: 16),
                  const BulletPoint(text: "24/7 Availability"),
                  const BulletPoint(text: "Affordable Pricing"),
                  const BulletPoint(text: "GPS-Enabled Vehicles"),
                  const BulletPoint(text: "Custom Travel Solutions"),
                  const BulletPoint(text: "Safety Standards"),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: Image.network(
                      "https://hireanything.com/assets/PassengerTransport-f2ae8a43.jpg",
                      height: 450,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: const Text(
                      "WHY CHOOSE US?",
                      style: AppTextStyles.sectionTitleGradient,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const ServiceCard(
                    title: "Diverse Vehicle Options",
                    description: "Choose from sedans, minibuses, and coaches to accommodate any group size.",
                    icon: Icons.directions_bus,
                    iconColor: AppColors.accentBlue,
                  ),
                  const ServiceCard(
                    title: "Experienced Drivers",
                    description: "Our professional and courteous drivers ensure a smooth and stress-free journey.",
                    icon: Icons.person,
                    iconColor: AppColors.accentGreen,
                  ),
                  const ServiceCard(
                    title: "Flexible Scheduling",
                    description: "Book transport services tailored to your timetable and specific needs.",
                    icon: Icons.access_time,
                    iconColor: AppColors.accentPurple,
                  ),
                  const ServiceCard(
                    title: "GPS-Enabled Vehicles",
                    description: "Real-time tracking ensures safety and route optimization during travel.",
                    icon: Icons.gps_fixed,
                    iconColor: AppColors.accentBlue,
                  ),
                  const ServiceCard(
                    title: "Safety Standards",
                    description: "Vehicles are regularly maintained and meet strict safety protocols for passenger security.",
                    icon: Icons.security,
                    iconColor: AppColors.accentGreen,
                  ),
                  const ServiceCard(
                    title: "Affordable Pricing",
                    description: "Transparent rates with flexible packages to suit all budgets.",
                    icon: Icons.monetization_on,
                    iconColor: AppColors.accentYellow,
                  ),
                ],
              ),
            ),
            const ServiceSection(
              title: "OUR PASSENGER TRANSPORT EXCELLENCE",
              items: [
                {
                  'title': "Comfortable & Spacious Vehicles",
                  'description': "Our fleet includes modern and well-maintained vehicles designed for passenger comfort and convenience.",
                  'icon': Icons.directions_bus,
                  'iconColor': AppColors.accentBlue,
                },
                {
                  'title': "Professional Drivers",
                  'description': "Trained and experienced drivers ensure a smooth and reliable transport experience.",
                  'icon': Icons.person,
                  'iconColor': AppColors.accentGreen,
                },
                {
                  'title': "Real-Time Tracking",
                  'description': "GPS-enabled vehicles provide route optimization and peace of mind for every journey.",
                  'icon': Icons.gps_fixed,
                  'iconColor': AppColors.accentPurple,
                },
                {
                  'title': "Transparent Pricing",
                  'description': "Affordable and clear pricing with no hidden fees ensures confidence in every booking.",
                  'icon': Icons.monetization_on,
                  'iconColor': AppColors.accentYellow,
                },
              ],
            ),
            const ServiceSection(
              title: "OUR COVERAGE AREA",
              items: [
                {
                  'title': "Nationwide Reach",
                  'description': "With our expansive coverage, we ensure that your needs are met wherever you are in the USA.",
                  'icon': Icons.map,
                  'iconColor': AppColors.accentBlue,
                },
                {
                  'title': "Localized Support",
                  'description': "Our team is dedicated to understanding the unique requirements of each region we serve, offering tailored solutions.",
                  'icon': Icons.support_agent,
                  'iconColor': AppColors.accentGreen,
                },
                {
                  'title': "Reliable Service",
                  'description': "No matter your location, we guarantee prompt and professional service every time.",
                  'icon': Icons.check_circle,
                  'iconColor': AppColors.accentPurple,
                },
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("CHECK YOUR LOCATION", style: AppTextStyles.sectionTitle),
                  SizedBox(height: 8),
                  Text(
                    "Not sure if we serve your area? Simply contact us. We’re here to serve you wherever you need us!",
                    style: AppTextStyles.bodyText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: AppColors.accentBlue, size: 20),
          const SizedBox(width: 8),
          Text(text, style: AppTextStyles.bodyText),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;

  const ServiceCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: iconColor.withOpacity(0.2),
              child: Icon(
                icon,
                color: iconColor,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.cardTitle),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: AppTextStyles.cardDescription,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}