import 'package:flutter/material.dart';
import 'package:hire_any_thing/utilities/AppConstant.dart';
import 'package:hire_any_thing/utilities/constant.dart';


class AboutService extends StatelessWidget {
  const AboutService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              "ABOUT OUR MEETING ROOM HIRE SOLUTIONS",
              style: AppTextStyles.sectionTitleGradient,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "We offer modern, well-equipped meeting rooms tailored to meet your business needs. Whether it’s for team meetings, client presentations, or brainstorming sessions, our spaces provide the perfect professional setting.",
            style: AppTextStyles.bodyText,
          ),
          const SizedBox(height: 16),
          const BulletPoint(text: "On-Demand Booking"),
          const BulletPoint(text: "Catering Services"),
          const BulletPoint(text: "Dedicated Support Staff"),
          const BulletPoint(text: "Convenient Locations"),
          const BulletPoint(text: "Transparent Pricing"),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              "https://hireanything.com/assets/MeetingRoom-3ed5d178.jpg", // Placeholder image; replace with actual image URL
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
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