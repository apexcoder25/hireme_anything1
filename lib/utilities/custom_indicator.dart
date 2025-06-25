
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'constant.dart';

class CustomPageIndicator extends StatelessWidget {
  final int currentPage;
  final int itemCount;
  final Color dotColor;
  final Color activeDotColor;

  const CustomPageIndicator({
    required this.currentPage,
    required this.itemCount,
    required this.dotColor,
    required this.activeDotColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          height: 10,
          width: currentPage == index ? 20 : 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: currentPage == index ? kPrimaryColor : Colors.grey,
          ),
        );
      }),
    );
  }
}
