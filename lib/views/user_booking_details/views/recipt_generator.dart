import 'dart:io';

import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/models/user_side_model/user_booking_model.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class PdfGenerator {
  static Future<void> generateAndSaveReceipt(BookingDetails booking) async {
    try {
      // Request permission
      if (!await _requestPermission()) {
        Get.snackbar('Permission Denied', 'Please allow storage access.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return;
      }

      final pdf = pw.Document();
      final formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

      pdf.addPage(
        pw.Page(
          margin: const pw.EdgeInsets.all(32),
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                    child: pw.Text('HireAnything.com',
                        style: pw.TextStyle(
                            fontSize: 24, fontWeight: pw.FontWeight.bold))),
                pw.SizedBox(height: 8),
                pw.Center(
                    child: pw.Text('[Your Address], Phone: [Your Contact Number]',
                        style: pw.TextStyle(fontSize: 12))),
                pw.Center(
                    child: pw.Text(
                        'Email: [Your Email] | https://hireanything.com',
                        style: pw.TextStyle(fontSize: 12))),
                pw.Divider(),
                pw.SizedBox(height: 10),
                pw.Text('RECEIPT',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 8),
                pw.Text('Receipt No: ${booking.orderNo ?? 'N/A'}'),
                pw.Text('Date: $formattedDate'),
                pw.SizedBox(height: 16),
                pw.Text('Customer Booking Details',
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 6),
                pw.Text('Pickup Location: ${booking.pickupLocation ?? 'N/A'}'),
                pw.Text('Drop Location: ${booking.dropLocation ?? 'N/A'}'),
                pw.Text('Pickup Date: ${DateFormat('dd/MM/yyyy').format(booking.pickupDate ?? DateTime.now())}'),
                pw.Text('Pickup Time: ${booking.pickupTime ?? 'N/A'}'),
                pw.Text('Seats Booked: ${booking.bookingSeats ?? 'N/A'}'),
                pw.Text('Distance: ${(booking.distance ?? 0.0).toStringAsFixed(1)} km'),
                pw.SizedBox(height: 16),
                pw.Text('Service Details',
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 6),
                if (booking.serviceId == null)
                  pw.Text('Service Details are not available.')
                else ...[
                  pw.Text('Service Name: ${booking.serviceId?.serviceName ?? 'N/A'}'),
                  pw.Text('Description: ${booking.serviceId?.description ?? 'N/A'}'),
                  pw.Text('Make & Model: ${booking.serviceId?.makeAndModel ?? 'N/A'}'),
                  pw.Text('Registration No: ${booking.serviceId?.registrationNo ?? 'N/A'}'),
                 
                  pw.Text('Seats: ${booking.serviceId?.noOfSeats ?? 'N/A'}'),
                ],
                pw.SizedBox(height: 16),
                pw.Text('Payment Summary',
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 6),
                pw.Text('Total Amount: £${(booking.grandTotal ?? 0.0).toStringAsFixed(2)}'),
                pw.Text('Payment Method: ${booking.paymentMethod ?? 'N/A'}'),
                pw.Text('Transaction ID: ${booking.paypalOrderId ?? 'N/A'}'),
                pw.Text('Status: ${booking.bookingStatus ?? 'N/A'}'),
                pw.SizedBox(height: 24),
                pw.Text('Thank you for choosing HireAnything.com!',
                    style: pw.TextStyle(
                        fontSize: 12, fontStyle: pw.FontStyle.italic)),
              ],
            );
          },
        ),
      );

      final downloadsDir = await DownloadsPathProvider.downloadsDirectory;
      final fileName = 'receipt_${booking.id ?? DateTime.now().millisecondsSinceEpoch}.pdf';
      final filePath = '${downloadsDir!.path}/$fileName';
      final file = File(filePath);

      await file.writeAsBytes(await pdf.save());

      Get.snackbar(
        'Receipt Saved',
        'Saved in Downloads folder as $fileName',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Open the file
      await OpenFile.open(filePath);
    } catch (e) {
      print("PDF generation error: $e");
      Get.snackbar('Error', 'Failed to generate receipt',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  static Future<bool> _requestPermission() async {
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted) {
        return true;
      }

      // For Android 11+
      if (await Permission.manageExternalStorage.request().isGranted) {
        return true;
      }

      return false;
    }
    return true; // iOS or others
  }
}
