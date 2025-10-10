import 'package:flutter/material.dart';
import 'package:hire_any_thing/utilities/AppConstant.dart';
import 'package:hire_any_thing/utilities/constant.dart';

import 'service_card.dart';


class WhyChooseUs extends StatelessWidget {
  const WhyChooseUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: ShaderMask(
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
        ),
        const ServiceCard(
          title: "Variety of Room Sizes",
          description: "From small private rooms to large conference spaces, we cater to meetings of all scales.",
          icon: Icons.meeting_room,
          iconColor: AppColors.accentBlue,
        ),
        const ServiceCard(
          title: "State-of-the-Art Facilities",
          description: "Enjoy high-speed internet, AV equipment, whiteboards, and more for a productive experience.",
          icon: Icons.computer,
          iconColor: AppColors.accentBlue,
        ),
        const ServiceCard(
          title: "Customizable Layouts",
          description: "Choose from boardroom, classroom, or theater-style setups to suit your meeting format.",
          icon: Icons.brush,
          iconColor: AppColors.accentPink,
        ),
        const ServiceCard(
          title: "Dedicated Support Staff",
          description: "On-site assistance to help with technical needs and ensure smooth operations.",
          icon: Icons.person,
          iconColor: AppColors.accentYellow,
        ),
      ],
    );
  }
}