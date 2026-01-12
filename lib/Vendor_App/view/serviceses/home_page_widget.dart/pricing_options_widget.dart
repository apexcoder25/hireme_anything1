import 'package:flutter/material.dart';
import 'package:hire_any_thing/data/models/vender_side_model/vendor_home_page_services_model.dart';

class PricingOptionsWidget extends StatelessWidget {
  final Service service;

  const PricingOptionsWidget({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header - Identical to original
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "💰 Pricing Options",
            style: TextStyle(
              color: Colors.green.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        SizedBox(height: 15),

        // Pricing Details
        if (_hasPricingInformation())
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildPricingDetails(),
          )
        else
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Pricing information not available - Please contact for quotes",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }

  bool _hasPricingInformation() {
    return service.offeringPrice != null && service.offeringPrice! > 0 ||
        service.boatRates != null ||
        service.miniBusRates != null ||
        service.pricingDetails != null ||
        service.pricing != null;
  }

  List<Widget> _buildPricingDetails() {
    List<Widget> pricingRows = [];

    // 1. Bouncy Castle / Venue Hire / General - offeringPrice
    if (service.offeringPrice != null && service.offeringPrice! > 0) {
      List<Widget> columns = [
        _buildRateColumn("Starting From", service.offeringPrice!.toDouble()),
      ];
      pricingRows.add(_buildRateRow(columns));
    }

    // 2. Boat Pricing
    if (service.boatRates != null) {
      List<Widget> rateColumns = [];

      if (service.boatRates!.hourlyRate != null && service.boatRates!.hourlyRate! > 0) {
        rateColumns.add(_buildRateColumn("Hourly", service.boatRates!.hourlyRate!));
      }
      if (service.boatRates!.threeHourRate != null && service.boatRates!.threeHourRate! > 0) {
        rateColumns.add(_buildRateColumn("3 Hours", service.boatRates!.threeHourRate!));
      }
      if (service.boatRates!.halfDayRate != null && service.boatRates!.halfDayRate! > 0) {
        rateColumns.add(_buildRateColumn("Half Day", service.boatRates!.halfDayRate!));
      }
      if (service.boatRates!.fullDayRate != null && service.boatRates!.fullDayRate! > 0) {
        rateColumns.add(_buildRateColumn("Full Day", service.boatRates!.fullDayRate!));
      }

      // Fallback old fields
      if (rateColumns.isEmpty) {
        if (service.boatRates!.halfDayHire != null && service.boatRates!.halfDayHire! > 0) {
          rateColumns.add(_buildRateColumn("Half Day", service.boatRates!.halfDayHire!));
        }
        if (service.boatRates!.tenHourDayHire != null && service.boatRates!.tenHourDayHire! > 0) {
          rateColumns.add(_buildRateColumn("10 Hour Day", service.boatRates!.tenHourDayHire!));
        }
      }

      if (rateColumns.isNotEmpty) {
        pricingRows.add(_buildRateRow(rateColumns));
      }

      if (service.boatRates!.perMileRate != null && service.boatRates!.perMileRate! > 0) {
        pricingRows.add(SizedBox(height: 12));
        pricingRows.add(_buildSingleRate("Per Mile Extra", service.boatRates!.perMileRate!, isDecimal: true));
      }
    }

    // 3. Minibus Pricing
    if (service.miniBusRates != null) {
      List<Widget> rateColumns = [];
      if (service.miniBusRates!.hourlyRate > 0) {
        rateColumns.add(_buildRateColumn("Hourly", service.miniBusRates!.hourlyRate.toDouble()));
      }
      if (service.miniBusRates!.halfDayRate > 0) {
        rateColumns.add(_buildRateColumn("Half Day", service.miniBusRates!.halfDayRate));
      }
      if (service.miniBusRates!.fullDayRate > 0) {
        rateColumns.add(_buildRateColumn("Full Day", service.miniBusRates!.fullDayRate));
      }

      if (rateColumns.isNotEmpty) {
        pricingRows.add(_buildRateRow(rateColumns));
      }

      if (service.miniBusRates!.mileageLimit > 0) {
        pricingRows.add(SizedBox(height: 12));
        pricingRows.add(_buildMileageInfo(
          service.miniBusRates!.mileageLimit,
          service.miniBusRates!.additionalMileageFee,
        ));
      }
    }

    // 4. Limousine / Chauffeur / Funeral / Coach using pricingDetails
    if (service.pricingDetails != null) {
      List<Widget> rateColumns = [];

      rateColumns.add(_buildRateColumn("Hourly", service.pricingDetails!.hourlyRate));
      rateColumns.add(_buildRateColumn("Half Day", service.pricingDetails!.halfDayRate.toDouble()));

      if (service.pricingDetails!.fullDayRate != null && service.pricingDetails!.fullDayRate! > 0) {
        rateColumns.add(_buildRateColumn("Full Day", service.pricingDetails!.fullDayRate!.toDouble()));
      }
      if (service.pricingDetails!.dayRate != null && service.pricingDetails!.dayRate! > 0) {
        rateColumns.add(_buildRateColumn("Day Rate", service.pricingDetails!.dayRate!));
      }

      if (rateColumns.isNotEmpty) {
        pricingRows.add(_buildRateRow(rateColumns));
      }

      // Extra packages
      if (service.pricingDetails!.weddingPackageRate != null && service.pricingDetails!.weddingPackageRate! > 0) {
        pricingRows.add(SizedBox(height: 12));
        pricingRows.add(_buildSingleRate("Wedding Package", service.pricingDetails!.weddingPackageRate!));
      }
      if (service.pricingDetails!.airportTransferRate != null && service.pricingDetails!.airportTransferRate! > 0) {
        pricingRows.add(SizedBox(height: 8));
        pricingRows.add(_buildSingleRate("Airport Transfer", service.pricingDetails!.airportTransferRate!));
      }
    }

    // 5. Horse Carriage / Coach using pricing object
    if (service.pricing != null) {
      List<Widget> rateColumns = [];

      if (service.pricing!.hourlyRate > 0) {
        rateColumns.add(_buildRateColumn("Hourly", service.pricing!.hourlyRate));
      }
      if (service.pricing!.halfDayRate > 0) {
        rateColumns.add(_buildRateColumn("Half Day", service.pricing!.halfDayRate));
      }
      if (service.pricing!.fullDayRate > 0) {
        rateColumns.add(_buildRateColumn("Full Day", service.pricing!.fullDayRate));
      }

      if (rateColumns.isNotEmpty) {
        pricingRows.add(_buildRateRow(rateColumns));
      }

      if (service.pricing!.fixedPackages.isNotEmpty) {
        pricingRows.add(SizedBox(height: 12));
        pricingRows.add(_buildFixedPackages(service.pricing!.fixedPackages));
      }
    }

    return pricingRows.isNotEmpty ? pricingRows : [_noPricingWidget()];
  }

  // === All UI methods - 100% same as your original ===

  Widget _buildRateRow(List<Widget> columns) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: columns.map((column) => Expanded(child: column)).toList(),
      ),
    );
  }

  Widget _buildRateColumn(String label, double rate) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4),
        Text(
          "£${rate.toStringAsFixed(0)}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade700,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSingleRate(String label, double rate, {bool isDecimal = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            isDecimal ? "£${rate.toStringAsFixed(2)}" : "£${rate.toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFixedPackages(List<FixedPackage> packages) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Fixed Packages",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.blue.shade700,
          ),
        ),
        SizedBox(height: 8),
        ...packages.map((package) => Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          package.packageName,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                      Text(
                        "£${package.packageRate}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                  if (package.packageDescription.isNotEmpty) ...[
                    SizedBox(height: 4),
                    Text(
                      package.packageDescription,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildMileageInfo(int mileageLimit, double additionalFee) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Mileage Information",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.orange.shade700,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Mileage Limit:", style: TextStyle(fontSize: 12)),
              Text("$mileageLimit miles", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Additional Fee:", style: TextStyle(fontSize: 12)),
              Text("£${additionalFee.toStringAsFixed(2)}/mile", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _noPricingWidget() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        "No pricing information available for this service type",
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade600,
          fontStyle: FontStyle.italic,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}