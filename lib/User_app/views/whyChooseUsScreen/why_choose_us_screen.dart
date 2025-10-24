import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/res/routes/routes.dart';

class WhyChooseUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 32, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WelcomeSection(),
              SizedBox(height: 40),
              SectionDivider(),
              WhatMakesDifferentSection(),
              SizedBox(height: 40),
              SectionDivider(),
              FacilitiesSection(),
              SizedBox(height: 40),
              SectionDivider(),
              BenefitsForUsersSection(),
              SizedBox(height: 40),
              SectionDivider(),
              BenefitsForVendorsSection(),
              SizedBox(height: 40),
              SectionDivider(),
              MakeHiringSmarterSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: 64,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.blue.shade700,
        borderRadius: BorderRadius.circular(6),
      ),
    ),
  );
}

class WelcomeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, 30, 24, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to\nhireanything.com',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, height: 1.05, color: Colors.black87),
            ),
            SizedBox(height: 10),
            Text(
              'Where Hiring Meets Simplicity',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade800,
                letterSpacing: 0.6,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'At hireanything.com, our mission is simple: to make hiring or renting anything you need—easy, reliable, and hassle-free. Whether you’re a customer searching for a service or item, or a vendor offering your services or products for hire, we’ve built a platform that connects you effortlessly.\n\nFrom tools and vehicles to party supplies, home services, or professionals—hireanything.com is your one-stop rental and hiring marketplace.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
                height: 1.65,
                letterSpacing: 0.03,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WhatMakesDifferentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SectionWithHeader(
      header: 'What Makes\nhireanything.com\nDifferent?',
      children: [
        FeatureCard(
          icon: Icons.dashboard_customize_rounded,
          title: 'All-In-One Hiring Platform',
          description: 'Everything under one digital roof: tools, equipment, vehicles, services, party essentials, home maintenance & more.',
          iconColor: Colors.blue.shade700,
        ),
        FeatureCard(
          icon: Icons.verified_user,
          title: 'Trusted and Verified Vendors',
          description: 'Screened for safety, quality, and professionalism so you can hire with confidence.',
          iconColor: Colors.green.shade700,
        ),
        FeatureCard(
          icon: Icons.payment_rounded,
          title: 'Transparent Pricing & Secure Transactions',
          description: 'Secure payment gateway—no hidden costs.',
          iconColor: Colors.orange.shade700,
        ),
        FeatureCard(
          icon: Icons.touch_app_rounded,
          title: 'Easy-To-Use Interface',
          description: 'Intuitive web and mobile design—effortless for every user.',
          iconColor: Colors.deepPurple.shade700,
        ),
      ],
    );
  }
}

class FacilitiesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SectionWithHeader(
      header: 'Facilities We Offer',
      children: [
        FeatureCard(
          icon: Icons.apps,
          title: 'Wide Range of Categories',
          description: 'Tools, Vehicles, Event Supplies, Home Services, Electronics, Fitness & more.',
          iconColor: Colors.blue,
        ),
        FeatureCard(
          icon: Icons.search,
          title: 'Smart Search & Filters',
          description: 'Find by location, category, date, availability, and price.',
          iconColor: Colors.purple,
        ),
        FeatureCard(
          icon: Icons.star_border,
          title: 'Vendor Profiles & Ratings',
          description: 'Transparent reviews and ratings for informed decisions.',
          iconColor: Colors.amber.shade800,
        ),
        FeatureCard(
          icon: Icons.lock,
          title: 'Secure Online Payment & Booking',
          description: 'Safe, reliable, instant payment platform.',
          iconColor: Colors.green,
        ),
        FeatureCard(
          icon: Icons.access_time,
          title: 'Real-Time Availability',
          description: "Know exactly what's available, live.",
          iconColor: Colors.blueGrey,
        ),
        FeatureCard(
          icon: Icons.support_agent,
          title: 'Customer Support',
          description: 'Professional support team, always ready to help.',
          iconColor: Colors.pink,
        ),
      ],
    );
  }
}

class BenefitsForUsersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SectionWithHeader(
      header: 'Benefits for Users (Hirers)',
      children: [
        FeatureCard(
          icon: Icons.timer,
          title: 'Save Time & Effort',
          description: 'No more endless search. Find what you need in minutes.',
          iconColor: Colors.pink.shade400,
        ),
        FeatureCard(
          icon: Icons.attach_money,
          title: 'Cost-Effective',
          description: 'Rent when you need—avoid heavy purchases, control your costs.',
          iconColor: Colors.teal.shade700,
        ),
        FeatureCard(
          icon: Icons.calendar_today,
          title: 'Flexible & Convenient',
          description: 'Book, schedule, and hire on your own terms—last minute or long-term.',
          iconColor: Colors.orange.shade400,
        ),
        FeatureCard(
          icon: Icons.check_circle,
          title: 'Trusted Choices',
          description: 'Verified vendors, reviews, secure transactions.',
          iconColor: Colors.indigo.shade900,
        ),
      ],
    );
  }
}

class BenefitsForVendorsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SectionWithHeader(
      header: 'Benefits for Vendors\n(Service Providers/Renters)',
      children: [
        FeatureCard(
          icon: Icons.trending_up,
          title: 'Boost Your Visibility',
          description: 'Be discovered by customers actively looking locally and beyond.',
          iconColor: Colors.blue,
        ),
        FeatureCard(
          icon: Icons.monetization_on,
          title: 'Grow Your Income',
          description: 'Monetize underutilized assets: tools, vehicles, equipment, services.',
          iconColor: Colors.deepPurple,
        ),
        FeatureCard(
          icon: Icons.analytics,
          title: 'Performance Insights',
          description: 'Analytics help you understand your audience and optimize listings.',
          iconColor: Colors.orange,
        ),
        FeatureCard(
          icon: Icons.build,
          title: 'Easy Management Tools',
          description: 'Track bookings, manage inventory, and chat with customers.',
          iconColor: Colors.green,
        ),
        FeatureCard(
          icon: Icons.percent,
          title: 'No Heavy Commission Cuts',
          description: "Fair business model—get maximum value from every listing.",
          iconColor: Colors.cyan.shade700,
        ),
        FeatureCard(
          icon: Icons.people,
          title: 'Easy Interface',
          description: "Effortless dashboard and profile management.",
          iconColor: Colors.blue.shade700,
        ),
        FeatureCard(
          icon: Icons.calendar_today,
          title: 'Flexible Booking Options',
          description: 'Hourly, daily, weekly, or custom durations—maximum flexibility.',
          iconColor: Colors.indigo,
        ),
      ],
    );
  }
}

class MakeHiringSmarterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.blue.shade700,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.13),
            blurRadius: 14,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Let’s Make Hiring\nSmarter – Together.',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.18,
              letterSpacing: -0.7,
            ),
          ),
          SizedBox(height: 18),
          Text(
            "Whether you're someone in need or someone with something to offer, hireanything.com is your partner for seamless hiring and renting. We're building a trusted ecosystem that benefits both sides.",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white.withOpacity(0.96),
              height: 1.55,
            ),
          ),
          SizedBox(height: 11),
          Text(
            'Join us today – and experience the smarter way to hire.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 22),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                Get.toNamed(UserRoutesName.loginUserView);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue.shade700,
                elevation: 3,
                padding: EdgeInsets.symmetric(horizontal: 44, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                  side: BorderSide(color: Colors.blue.shade700, width: 2.2),
                ),
              ),
              icon: Icon(Icons.arrow_forward_rounded),
              label: Text(
                'Join Now',
                style: TextStyle(
                    fontSize: 19, fontWeight: FontWeight.bold, letterSpacing: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionWithHeader extends StatelessWidget {
  final String header;
  final List<Widget> children;
  const SectionWithHeader({required this.header, required this.children});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            height: 1.1,
            letterSpacing: -0.3,
            color: Colors.blue.shade800,
          ),
        ),
        SizedBox(height: 22),
        ...children
            .map((e) => Padding(padding: const EdgeInsets.only(bottom: 20), child: e))
            .toList(),
      ],
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color iconColor;

  FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shadowColor: iconColor.withOpacity(0.06),
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 27),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: iconColor,
                      height: 1.12,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14.5,
                      color: Colors.grey[700],
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
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