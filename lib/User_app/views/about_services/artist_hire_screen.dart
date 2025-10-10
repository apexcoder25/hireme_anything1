import 'package:flutter/material.dart';
import 'package:hire_any_thing/utilities/AppConstant.dart';
import 'package:hire_any_thing/utilities/constant.dart';
import 'package:hire_any_thing/User_app/views/widget/service_section.dart';

class ArtistHireDetailsScreen extends StatelessWidget {
  const ArtistHireDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Artist Hire"),
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
                      "About Our Artist Hire Services",
                      style: AppTextStyles.sectionTitleGradient,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "We connect you with talented artists for a wide range of events and projects. Whether it’s a corporate gathering, private party, or community festival, our roster includes performers, musicians, painters, and more to make your event unforgettable.",
                    style: AppTextStyles.bodyText,
                  ),
                  const SizedBox(height: 16),
                  const BulletPoint(text: "24/7 Booking Support"),
                  const BulletPoint(text: "Competitive Rates"),
                  const BulletPoint(text: "Wide Genre Coverage"),
                  const BulletPoint(text: "On-Demand Performances"),
                  const BulletPoint(text: "Custom Requests"),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: Image.network(
                      "https://hireanything.com/image/about.png",
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
                    title: "Diverse Talent Pool",
                    description: "From musicians and dancers to visual artists and entertainers, we offer professionals for every occasion",
                    icon: Icons.event,
                    iconColor: AppColors.accentBlue,
                  ),
                  const ServiceCard(
                    title: "Tailored Performances",
                    description: "Artists adapt their craft to match the theme and tone of your event, ensuring a personalized experience.",
                    icon: Icons.format_paint,
                    iconColor: AppColors.accentGreen,
                  ),
                  const ServiceCard(
                    title: "Professional Excellence",
                    description: "All artists are highly skilled, experienced, and committed to delivering memorable performances.",
                    icon: Icons.star,
                    iconColor: AppColors.accentPurple,
                  ),
                  const ServiceCard(
                    title: "Custom Requests",
                    description: "Have a specific theme or requirement? Let us curate the perfect artistic experience for you.",
                    icon: Icons.brush,
                    iconColor: AppColors.accentBlue,
                  ),
                  const ServiceCard(
                    title: "On-Demand Performances",
                    description: "Flexible scheduling ensures performances fit seamlessly into your event timeline.",
                    icon: Icons.punch_clock,
                    iconColor: AppColors.accentYellow,
                  ),
                  const ServiceCard(
                    title: "Transparent Pricing",
                    description: "Affordable pricing packages, transparent quotes, and no hidden fees for all artist hires",
                    icon: Icons.monetization_on,
                    iconColor: AppColors.accentGreen,
                  ),
                ],
              ),
            ),
            const ServiceSection(
              title: "Our Artist Hire Excellence",
              items: [
                {
                  'title': "Exceptional Talent",
                  'description': "Our roster includes skilled and experienced artists who are dedicated to making your event unforgettable.",
                  'icon': Icons.star,
                  'iconColor': AppColors.accentBlue,
                },
                {
                  'title': "Punctual and Reliable",
                  'description': "Artists arrive on time and are well-prepared to perform seamlessly within your schedule.",
                  'icon': Icons.access_time,
                  'iconColor': AppColors.accentGreen,
                },
                {
                  'title': "Curated Experiences",
                  'description': "Every performance is tailored to suit your event’s theme, ensuring a unique and captivating experience.",
                  'icon': Icons.format_paint,
                  'iconColor': AppColors.accentPurple,
                },
                {
                  'title': "Transparent Pricing",
                  'description': "Clear, upfront pricing ensures you know exactly what you're paying for with no hidden fees.",
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