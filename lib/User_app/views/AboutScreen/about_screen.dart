import 'package:flutter/material.dart';
import 'package:hire_any_thing/utilities/colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // HEADER
              Text(
                'About HireAnything',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                  letterSpacing: -0.5,
                  height: 1.08,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "We're on a mission to revolutionize how people find and book services across the UK. From transport to tutoring, we connect you with verified professionals who deliver quality results.",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              _buildStatsColumn(),
              const SizedBox(height: 30),

              _sectionHeader('Our Core Values'),
              Text(
                'These principles guide everything we do and shape how we serve our community',
                style: TextStyle(
                  color: AppColors.grey700,
                  fontSize: 15.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 23),
              _coreValueCard(
                icon: Icons.explore_outlined,
                title: "Our Mission",
                desc: "To connect people with trusted service providers, making it easy to find and book quality services across the UK.",
                color: AppColors.primaryDark,
              ),
              _coreValueCard(
                icon: Icons.verified,
                title: "Our Values",
                desc: "We believe in trust, quality, and exceptional customer service. Every interaction should exceed expectations.",
                color: AppColors.success,
              ),
              _coreValueCard(
                icon: Icons.visibility,
                title: "Our Vision",
                desc: "To become the UK's most trusted platform for service bookings, empowering both customers and providers.",
                color: AppColors.secondaryDark,
              ),
              const SizedBox(height: 36),

              // TEAM
              _sectionHeader('Meet Our Team'),
              Text(
                "The passionate people behind HireAnything, working to make your service booking experience exceptional",
                style: TextStyle(
                  color: AppColors.grey700,
                  fontSize: 15.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _teamMember(
                "Sarah Johnson",
                "CEO & Founder",
                "Passionate about connecting people with quality services.",
                "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80",
              ),
              _teamMember(
                "Michael Chen",
                "CTO",
                "Leading our technology vision and platform development.",
                "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80",
              ),
              _teamMember(
                "Emma Davis",
                "Head of Operations",
                "Ensuring smooth operations and exceptional service quality.",
                "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=300&q=80",
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryDark,
            letterSpacing: -0.18,
          ),
          textAlign: TextAlign.center,
        ),
      );

  static Widget _coreValueCard({
    required IconData icon,
    required String title,
    required String desc,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: ListTile(
          leading: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withOpacity(0.13),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 25),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: AppColors.textPrimary,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              desc,
              style: TextStyle(
                  fontSize: 14.4, color: AppColors.textSecondary, height: 1.4),
            ),
          ),
        ),
      ),
    );
  }

  Widget _teamMember(
      String name, String title, String desc, String imgUrl) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 7),
      elevation: 1.7,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imgUrl),
              radius: 27,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.2,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: AppColors.textSecondary, fontSize: 13.5),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: TextStyle(
                        color: AppColors.grey900, fontSize: 13.7, height: 1.4),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget _buildStatsColumn() {
  final stats = [
    {"value": "50K+", "label": "Happy Customers", "icon": Icons.emoji_emotions_outlined, "color": AppColors.success},
    {"value": "1000+", "label": "Verified Providers", "icon": Icons.verified_user_outlined, "color": AppColors.btnColor},
    {"value": "24/7", "label": "Support Available", "icon": Icons.support_agent_outlined, "color": AppColors.secondaryDark},
    {"value": "99%", "label": "Satisfaction Rate", "icon": Icons.thumb_up_alt_outlined, "color": AppColors.premiumGold},
  ];

  return Wrap(
    alignment: WrapAlignment.center,
    runSpacing: 18,
    spacing: 15,
    children: stats.map((item) => _statCard(
      icon: item["icon"] as IconData,
      value: item["value"] as String,
      label: item["label"] as String,
      color: item["color"] as Color,
    )).toList(),
  );
}

static Widget _statCard({
  required IconData icon,
  required String value,
  required String label,
  required Color color,
}) {
  return Container(
    width: 155,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.08),
          blurRadius: 10,
          offset: Offset(0, 6),
        ),
      ],
      border: Border.all(color: color.withOpacity(0.12)),
    ),
    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.13),
          ),
          padding: EdgeInsets.all(10),
          child: Icon(icon, color: color, size: 27),
        ),
        SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryDark,
            fontSize: 22,
            letterSpacing: -0.6,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.grey700,
            fontWeight: FontWeight.w600,
            fontSize: 14.5,
            height: 1.3,
          ),
        ),
      ],
    ),
  );
}

  static Widget _statColumn(
      TextStyle headline, TextStyle label, String stat, String desc) {
    return Column(
      children: [
        Text(stat, style: headline),
        const SizedBox(height: 3),
        Text(desc, style: label, textAlign: TextAlign.center),
      ],
    );
  }
}
