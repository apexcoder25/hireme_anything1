import 'package:flutter/material.dart';
import 'package:hire_any_thing/utilities/AppConstant.dart';
import 'package:hire_any_thing/utilities/constant.dart';
import 'package:hire_any_thing/User_app/views/widget/service_section.dart';

class TutorHireScreen extends StatelessWidget {
  const TutorHireScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tutor Hire"),
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
                      "ABOUT OUR TUTOR HIRE SERVICES",
                      style: AppTextStyles.sectionTitleGradient,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "We provide access to professional tutors for a wide range of subjects and academic levels. Whether you need help with school subjects, exam preparation, or advanced topics, our tutors are here to assist you in achieving your educational goals.",
                    style: AppTextStyles.bodyText,
                  ),
                  const SizedBox(height: 16),
                  const BulletPoint(text: "Qualified Professionals"),
                  const BulletPoint(text: "Flexible Scheduling"),
                  const BulletPoint(text: "Personalized Learning Plans"),
                  const BulletPoint(text: "Online & In-Person Options"),
                  const BulletPoint(text: "Affordable Rates"),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: Image.network(
                      "https://hireanything.com/assets/MeetingRoom-3ed5d178.jpg",
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
                    title: "Qualified Professionals",
                    description: "Our tutors are experienced and certified in their respective fields, ensuring top-quality education.",
                    icon: Icons.school,
                    iconColor: AppColors.accentBlue,
                  ),
                  const ServiceCard(
                    title: "Flexible Scheduling",
                    description: "Book sessions at times that suit your schedule, with both one-time and recurring options available.",
                    icon: Icons.access_time,
                    iconColor: AppColors.accentBlue,
                  ),
                  const ServiceCard(
                    title: "Personalized Learning Plans",
                    description: "Every session is tailored to match the student’s unique learning style and academic goals.",
                    icon: Icons.book,
                    iconColor: AppColors.accentPurple,
                  ),
                  const ServiceCard(
                    title: "Online & In-Person Options",
                    description: "Choose between virtual tutoring sessions or face-to-face learning based on your preference.",
                    icon: Icons.computer,
                    iconColor: AppColors.accentGreen,
                  ),
                  const ServiceCard(
                    title: "Affordable Rates",
                    description: "Transparent pricing with packages designed to fit your budget and learning needs.",
                    icon: Icons.monetization_on,
                    iconColor: AppColors.accentYellow,
                  ),
                  const ServiceCard(
                    title: "All Academic Levels",
                    description: "We cater to students from primary school to university and beyond.",
                    icon: Icons.school,
                    iconColor: AppColors.accentPurple,
                  ),
                ],
              ),
            ),
            const ServiceSection(
              title: "OUR TUTOR EXCELLENCE",
              items: [
                {
                  'title': "Expert Tutors",
                  'description': "Our tutors have a proven track record of helping students excel academically.",
                  'icon': Icons.check_circle,
                  'iconColor': AppColors.accentBlue,
                },
                {
                  'title': "Flexible Learning Options",
                  'description': "Learn at your own pace with schedules and methods customized for you.",
                  'icon': Icons.computer,
                  'iconColor': AppColors.accentGreen,
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