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
        // Header
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
    switch (service.serviceType.toLowerCase()) {
      case 'boat':
        return service.boatRates != null;
      case 'horse':
        return service.pricing != null;
      case 'funeral':
        return service.pricingDetails != null;
      case 'minibus':
        return service.miniBusRates != null;
      case 'limousine':
      case 'chauffeur':
        return service.pricingDetails != null;
      case 'coach':
        return service.pricing != null || service.pricingDetails != null;
      default:
        return service.pricing != null ||
            service.pricingDetails != null ||
            service.boatRates != null ||
            service.miniBusRates != null;
    }
  }

  List<Widget> _buildPricingDetails() {
    switch (service.serviceType.toLowerCase()) {
      case 'boat':
        return _buildBoatPricing();
      case 'horse':
        return _buildHorsePricing();
      case 'funeral':
        return _buildFuneralPricing();
      case 'minibus':
        return _buildMinibusPricing();
      case 'limousine':
        return _buildLimousinePricing();
      case 'chauffeur':
        return _buildChauffeurPricing();
      case 'coach':
        return _buildCoachPricing();
      default:
        return _buildGeneralPricing();
    }
  }

  List<Widget> _buildBoatPricing() {
    if (service.boatRates == null) return [_noPricingWidget()];

    List<Widget> pricingRows = [];

    // Build list of available rates
    List<Widget> rateColumns = [];
    
    if (service.boatRates!.hourlyRate != null) {
      rateColumns.add(_buildRateColumn("Hourly", service.boatRates!.hourlyRate));
    }
    if (service.boatRates!.threeHourRate != null) {
      rateColumns.add(_buildRateColumn("3 Hours", service.boatRates!.threeHourRate));
    }
    if (service.boatRates!.halfDayRate != null) {
      rateColumns.add(_buildRateColumn("Half Day", service.boatRates!.halfDayRate));
    }
    if (service.boatRates!.fullDayRate != null) {
      rateColumns.add(_buildRateColumn("Full Day", service.boatRates!.fullDayRate));
    }
    
    // Fallback to old fields if new ones aren't available
    if (rateColumns.isEmpty) {
      if (service.boatRates!.halfDayHire != null) {
        rateColumns.add(_buildRateColumn("Half Day", service.boatRates!.halfDayHire));
      }
      if (service.boatRates!.tenHourDayHire != null) {
        rateColumns.add(_buildRateColumn("10 Hour Day", service.boatRates!.tenHourDayHire));
      }
    }

    if (rateColumns.isNotEmpty) {
      pricingRows.add(_buildRateRow(rateColumns));
    }

    // Per mile rate
    if (service.boatRates!.perMileRate != null && service.boatRates!.perMileRate! > 0) {
      pricingRows.add(SizedBox(height: 12));
      pricingRows.add(_buildSingleRate(
          "Per Mile", service.boatRates!.perMileRate!,
          isDecimal: true));
    }

    return pricingRows.isNotEmpty ? pricingRows : [_noPricingWidget()];
  }

  List<Widget> _buildHorsePricing() {
    if (service.pricing == null) return [_noPricingWidget()];

    List<Widget> pricingRows = [];

    // Standard rates
    pricingRows.add(_buildRateRow([
      _buildRateColumn("Hourly", service.pricing!.hourlyRate),
      _buildRateColumn("Half Day", service.pricing!.halfDayRate),
      _buildRateColumn("Full Day", service.pricing!.fullDayRate),
    ]));

    // Fixed packages
    if (service.pricing!.fixedPackages.isNotEmpty) {
      pricingRows.add(SizedBox(height: 12));
      pricingRows.add(_buildFixedPackages(service.pricing!.fixedPackages));
    }

    return pricingRows;
  }

  List<Widget> _buildFuneralPricing() {
    if (service.pricingDetails == null) return [_noPricingWidget()];

    List<Widget> pricingRows = [];

    // Standard rates using PricingDetails properties
    List<Widget> rates = [];
    rates.add(_buildRateColumn("Hourly", service.pricingDetails!.hourlyRate));
    rates.add(_buildRateColumn("Half Day", service.pricingDetails!.halfDayRate.toDouble()));
    
    if (service.pricingDetails!.dayRate != null) {
      rates.add(_buildRateColumn("Day Rate", service.pricingDetails!.dayRate!));
    }
    
    if (service.pricingDetails!.fullDayRate != null) {
      rates.add(_buildRateColumn("Full Day", service.pricingDetails!.fullDayRate!.toDouble()));
    }

    pricingRows.add(_buildRateRow(rates));

    // Additional rates
    if (service.pricingDetails!.weddingPackageRate != null) {
      pricingRows.add(SizedBox(height: 12));
      pricingRows.add(_buildSingleRate(
          "Wedding Package", service.pricingDetails!.weddingPackageRate!));
    }

    if (service.pricingDetails!.airportTransferRate != null) {
      pricingRows.add(SizedBox(height: 8));
      pricingRows.add(_buildSingleRate(
          "Airport Transfer", service.pricingDetails!.airportTransferRate!));
    }

    return pricingRows;
  }

  List<Widget> _buildMinibusPricing() {
    if (service.miniBusRates == null) return [_noPricingWidget()];

    List<Widget> pricingRows = [];

    // Standard rates
    pricingRows.add(_buildRateRow([
      _buildRateColumn("Hourly", service.miniBusRates!.hourlyRate.toDouble()),
      _buildRateColumn("Half Day", service.miniBusRates!.halfDayRate),
      _buildRateColumn("Full Day", service.miniBusRates!.fullDayRate),
    ]));

    // Mileage information
    if (service.miniBusRates!.mileageLimit > 0) {
      pricingRows.add(SizedBox(height: 12));
      pricingRows.add(_buildMileageInfo(
          service.miniBusRates!.mileageLimit,
          service.miniBusRates!.additionalMileageFee));
    }

    return pricingRows;
  }

  List<Widget> _buildLimousinePricing() {
    return _buildPricingDetailsGeneric("Limousine");
  }

  List<Widget> _buildChauffeurPricing() {
    return _buildPricingDetailsGeneric("Chauffeur");
  }

  List<Widget> _buildCoachPricing() {
    // Try pricing first, then pricingDetails
    if (service.pricing != null) {
      return _buildHorsePricing(); // Use same logic as horse
    } else if (service.pricingDetails != null) {
      return _buildPricingDetailsGeneric("Coach");
    }
    return [_noPricingWidget()];
  }

  List<Widget> _buildGeneralPricing() {
    if (service.pricing != null) {
      return _buildHorsePricing();
    } else if (service.pricingDetails != null) {
      return _buildPricingDetailsGeneric("Service");
    } else if (service.boatRates != null) {
      return _buildBoatPricing();
    } else if (service.miniBusRates != null) {
      return _buildMinibusPricing();
    }
    return [_noPricingWidget()];
  }

  List<Widget> _buildPricingDetailsGeneric(String serviceType) {
    if (service.pricingDetails == null) return [_noPricingWidget()];

    List<Widget> pricingRows = [];

    // Standard rates
    List<Widget> rates = [];
    rates.add(_buildRateColumn("Hourly", service.pricingDetails!.hourlyRate));
    rates.add(_buildRateColumn("Half Day", service.pricingDetails!.halfDayRate.toDouble()));
    
    if (service.pricingDetails!.fullDayRate != null) {
      rates.add(_buildRateColumn("Full Day", service.pricingDetails!.fullDayRate!.toDouble()));
    }

    pricingRows.add(_buildRateRow(rates));

    return pricingRows;
  }

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

  Widget _buildRateColumn(String label, double? rate) {
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
          rate != null ? "£${rate.toStringAsFixed(0)}" : "N/A",
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
        )).toList(),
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