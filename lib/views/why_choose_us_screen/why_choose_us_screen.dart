import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/res/routes/routes.dart';

class WhyChooseUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[50],
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Why Choose Us',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WelcomeSection(),
            SizedBox(height: 32),
            WhatMakesDifferentSection(),
            SizedBox(height: 32),
            FacilitiesSection(),
            SizedBox(height: 32),
            BenefitsForUsersSection(),
            SizedBox(height: 32),
            BenefitsForVendorsSection(),
            SizedBox(height: 32),
            MakeHiringSmarterSection(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}


class WelcomeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to\nHireAnything.com',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Where Hiring Meets Simplicity',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue[800],
          ),
        ),
        SizedBox(height: 16),
        Text(
          'At HireAnything.com, our mission is simple: to make hiring or renting anything you need – easy, reliable, and hassle-free. Whether you’re a customer searching for a service or item, or a vendor offering your services or products for hire, we’ve built a platform that connects you effortlessly.\n\n'
          'From tools and vehicles to party supplies, home services, or professionals – HireAnything.com is your one-stop rental and hiring marketplace.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
      ],
    );
  }
}


class WhatMakesDifferentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What Makes\nHireAnything.com\nDifferent?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: 50,
          height: 2,
          color: Colors.blue[800],
        ),
        SizedBox(height: 16),
        FeatureCard(
          icon: Icons.lightbulb_outline,
          title: 'All-In-One Hiring Platform',
          description:
              'We bring together everything under one digital roof – tools, equipment, services, vehicles, party essentials, home maintenance pros, and more. No more juggling multiple websites or apps.',
          iconColor: Colors.blue[600]!,
        ),
        SizedBox(height: 16),
        FeatureCard(
          icon: Icons.verified_user,
          title: 'Trusted and Verified Vendors',
          description:
              'We screen and verify our vendors to ensure safety, quality, and professionalism. So you can hire with peace of mind.',
          iconColor: Colors.blue[600]!,
        ),
        SizedBox(height: 16),
        FeatureCard(
          icon: Icons.payment,
          title: 'Transparent Pricing & Secure Transactions',
          description:
              'What you see is what you get. No hidden costs. Our secure payment gateway ensures smooth and protected transactions.',
          iconColor: Colors.blue[600]!,
        ),
        SizedBox(height: 16),
        FeatureCard(
          icon: Icons.people,
          title: 'Easy-To-Use Interface',
          description:
              'Our intuitive website design makes searching, comparing, booking, and managing your hires effortless – whether you’re tech-savvy or not.',
          iconColor: Colors.blue[600]!,
        ),
      ],
    );
  }
}


class FacilitiesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Facilities We Offer',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: 50,
          height: 2,
          color: Colors.blue[800],
        ),
        SizedBox(height: 16),
        FeatureCard(
          icon: Icons.apps,
          title: 'Wide Range of Categories',
          description:
              'Tools, Vehicles, Event Supplies, Home Services, Electronics, Fitness Equipment & more.',
          iconColor: Colors.blue[600]!,
        ),
        SizedBox(height: 16),
        FeatureCard(
          icon: Icons.search,
          title: 'Smart Search & Filters',
          description:
              'Easily find what you need by location, category, availability, and price.',
          iconColor: Colors.blue[600]!,
        ),
        SizedBox(height: 16),
        FeatureCard(
          icon: Icons.star_border,
          title: 'Vendor Profiles & Ratings',
          description:
              'Check reviews, compare offerings, and make informed choices.',
          iconColor: Colors.blue[600]!,
        ),
        SizedBox(height: 16),
        FeatureCard(
          icon: Icons.lock,
          title: 'Secure Online Payment & Booking',
          description: 'Safe, fast, and reliable payment gateway.',
          iconColor: Colors.blue[600]!,
        ),
        SizedBox(height: 16),
        FeatureCard(
          icon: Icons.access_time,
          title: 'Real-Time Availability',
          description:
              'No need to guess – know exactly what’s available when you need it.',
          iconColor: Colors.blue[600]!,
        ),
        SizedBox(height: 16),
        FeatureCard(
          icon: Icons.support_agent,
          title: 'Customer Support',
          description:
              'Friendly support team ready to help you with queries and bookings.',
          iconColor: Colors.blue[600]!,
        ),
      ],
    );
  }
}


class BenefitsForUsersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Benefits for Users (Hirers)',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: 50,
          height: 2,
          color: Colors.blue[800],
        ),
        SizedBox(height: 16),
        FeatureCard(
          icon: Icons.timer,
          title: 'Save Time & Effort',
          description:
              'No more endless browsing. Find exactly what you need in minutes.',
          iconColor: Colors.pink[400]!,
        ),
        SizedBox(height: 16),
        FeatureCard(
          icon: Icons.attach_money,
          title: 'Cost-Effective Solutions',
          description:
              'Why buy when you can rent? Avoid heavy purchases by hiring high-quality products or services when you need them.',
          iconColor: Colors.pink[400]!,
        ),
        SizedBox(height: 16),
        FeatureCard(
          icon: Icons.calendar_today,
          title: 'Flexible & Convenient',
          description:
              'Schedule and hire on your own terms – last minute or long-term, it’s up to you.',
          iconColor: Colors.pink[400]!,
        ),
        SizedBox(height: 16),
        FeatureCard(
          icon: Icons.check_circle,
          title: 'Trusted Choices',
          description:
              'Access verified vendors with reviews and ratings to ensure you get the best quality and service.',
          iconColor: Colors.pink[400]!,
        ),
      ],
    );
  }
}
class BenefitsForVendorsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Benefits for Vendors\n(Service Providers/Renters)',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: 50,
          height: 2,
          color: Colors.blue[800],
        ),
        SizedBox(height: 16),
        FeatureCard(
          icon: Icons.trending_up,
          title: 'Boost Your Visibility',
          description:
              'Get discovered by customers actively looking to hire services or rent products – locally and beyond.',
          iconColor: Colors.blue[600]!,
        ),
        SizedBox(height: 16),
        FeatureCard(
          icon: Icons.monetization_on,
          title: 'Grow Your Income',
          description:
              'Monetize your underutilized tools, vehicles, equipment, or services.',
          iconColor: Colors.blue[600]!,
        ),
        SizedBox(height: 16),
        FeatureCard(
          icon: Icons.analytics,
          title: 'Performance Insights',
          description:
              'Access analytics to understand your customers and improve your offerings.',
          iconColor: Colors.blue[600]!,
        ),
        SizedBox(height: 16),
        FeatureCard(
          icon: Icons.build,
          title: 'Easy Management Tools',
          description:
              'Track bookings, manage inventory, and communicate with customers – all in one place.',
          iconColor: Colors.blue[600]!,
        ),
        SizedBox(height: 16),
        FeatureCard(
          icon: Icons.percent,
          title: 'No Heavy Commission Cuts',
          description:
              'We believe in fair business. Our platform ensures you get maximum value from your listings.',
          iconColor: Colors.blue[600]!,
        ),
        SizedBox(height: 16),
        FeatureCard(
          icon: Icons.people,
          title: 'Easy-To-Use Interface',
          description:
              'Our intuitive website design makes searching, comparing, booking, and managing your hires effortless – whether you’re tech-savvy or not.',
          iconColor: Colors.blue[600]!,
        ),
        SizedBox(height: 16),
        FeatureCard(
          icon: Icons.calendar_today,
          title: 'Flexible Booking Options',
          description:
              'Choose hourly, daily, weekly, or custom durations – we support all types of hiring needs with flexibility and convenience.',
          iconColor: Colors.blue[600]!,
        ),
      ],
    );
  }
}


class MakeHiringSmarterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Let’s Make Hiring\nSmarter – Together.',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Whether you’re someone in need or someone with something to offer, HireAnything.com is your partner in making hiring and renting seamless. We’re building a trusted ecosystem that benefits both sides of the transaction.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Join us today – and experience the smarter way to hire.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
              Get.toNamed(UserRoutesName.loginUserView);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Join Now',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable Feature Card Component
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
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Container(
            width: 50,
            height: 2,
            color: Colors.blue[800],
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}