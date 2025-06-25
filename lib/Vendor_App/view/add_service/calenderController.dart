import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarController extends GetxController {
  var fromDate = DateTime.now().obs;
  var toDate = DateTime.now().add(Duration(days: 7)).obs;
  var visibleDates = <DateTime>[].obs;
  var specialPrices = <Map<String, dynamic>>[].obs;

  var defaultPrice = 0.0.obs; // Default price per mile

  @override
  void onInit() {
    super.onInit();
    // Delay the initial update until after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateDateRange(DateTime.now(), DateTime.now().add(Duration(days: 7)));
    });
  }

  void setSpecialPrice(DateTime date, double price) {
    final dateStr = DateFormat('yyyy-MM-dd').format(date);
    final existingIndex = specialPrices.indexWhere(
        (entry) => DateFormat('yyyy-MM-dd').format(entry['date'] as DateTime) == dateStr);
    
    if (existingIndex != -1) {
      specialPrices[existingIndex]['price'] = price;
    } else {
      specialPrices.add({'date': date, 'price': price});
    }
    specialPrices.refresh();
  }

  void deleteSpecialPrice(DateTime date) {
    final dateStr = DateFormat('yyyy-MM-dd').format(date);
    specialPrices.removeWhere(
        (entry) => DateFormat('yyyy-MM-dd').format(entry['date'] as DateTime) == dateStr);
    specialPrices.refresh();
  }

  double getPriceForDate(DateTime date) {
    final dateStr = DateFormat('yyyy-MM-dd').format(date);
    final entry = specialPrices.firstWhereOrNull(
        (entry) => DateFormat('yyyy-MM-dd').format(entry['date'] as DateTime) == dateStr);
    return entry?['price'] as double? ?? defaultPrice.value;
  }

  void updateDateRange(DateTime from, DateTime to) {
    if (from.isAfter(to)) {
      to = from.add(Duration(days: 1));
    }

    final today = DateTime.now();
    if (from.isBefore(today)) {
      from = today;
      if (to.isBefore(today.add(Duration(days: 1)))) {
        to = today.add(Duration(days: 1));
      }
    }

    fromDate.value = from;
    toDate.value = to;

    visibleDates.clear();
    for (DateTime date = from;
        date.isBefore(to.add(Duration(days: 1)));
        date = date.add(Duration(days: 1))) {
      visibleDates.add(DateTime(date.year, date.month, date.day));
    }

    specialPrices.removeWhere((entry) {
      final date = entry['date'] as DateTime;
      return date.isBefore(from) || date.isAfter(to);
    });

    visibleDates.refresh();
    specialPrices.refresh();
  }

  void setDefaultPrice(double price) {
    defaultPrice.value = price;
  }

  String formatToISO(DateTime date) {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(date.toUtc());
  }

  String get bookingDateFrom => formatToISO(fromDate.value);
  String get bookingDateTo => formatToISO(toDate.value);
}