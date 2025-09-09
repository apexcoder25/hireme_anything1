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
    switch (service.serviceType?.toLowerCase()) {
      case 'boat':
        return service.boatRates != null;
      case 'horse':
        return service.pricing != null;
      case 'funeral':
        return service.pricingDetails != null;
      case 'minibus':
        return service.miniBusRates != null;
      case 'limousine':
        return service.hourlyRate != null ||
            service.halfDayRate != null ||
            service.fullDayRate != null;
      case 'chauffeur':
        return service.hourlyRate != null ||
            service.halfDayRate != null ||
            service.fullDayRate != null ||
            service.pricing != null ||
            service.pricingDetails != null;
      case 'coach':
        return service.pricing != null ||
            service.hourlyRate != null ||
            service.pricingDetails != null;
      default:
        return service.hourlyRate != null ||
            service.halfDayRate != null ||
            service.fullDayRate != null ||
            service.pricing != null ||
            service.pricingDetails != null;
    }
  }

  List<Widget> _buildPricingDetails() {
    switch (service.serviceType?.toLowerCase()) {
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

    // Standard rates
    if (_hasAnyRate(service.boatRates!.hourlyRate,
        service.boatRates!.halfDayRate, service.boatRates!.fullDayRate)) {
      pricingRows.add(_buildRateRow([
        _buildRateColumn("Hourly", service.boatRates!.hourlyRate),
        _buildRateColumn("Half Day", service.boatRates!.halfDayRate),
        _buildRateColumn("Full Day", service.boatRates!.fullDayRate),
      ]));
    }

    // Overnight charter rate
    if (service.boatRates!.overnightCharterRate != null &&
        service.boatRates!.overnightCharterRate! > 0) {
      pricingRows.add(SizedBox(height: 12));
      pricingRows.add(_buildSingleRate(
          "Overnight Charter", service.boatRates!.overnightCharterRate));
    }

    // Package deals description
    if (service.boatRates!.packageDealsDescription != null &&
        service.boatRates!.packageDealsDescription!.isNotEmpty) {
      pricingRows.add(SizedBox(height: 12));
      pricingRows.add(_buildPackageDescription(
          "Package Deals", service.boatRates!.packageDealsDescription!));
    }

    return pricingRows;
  }

  List<Widget> _buildHorsePricing() {
    if (service.pricing == null) return [_noPricingWidget()];

    List<Widget> pricingRows = [];

    if (_hasAnyRate(service.pricing!.hourlyRate, service.pricing!.halfDayRate,
        service.pricing!.fullDayRate)) {
      pricingRows.add(_buildRateRow([
        _buildRateColumn("Hourly", service.pricing!.hourlyRate),
        _buildRateColumn("Half Day", service.pricing!.halfDayRate),
        _buildRateColumn("Full Day", service.pricing!.fullDayRate),
      ]));
    }

    // Ceremony package rate
    if (service.pricing!.ceremonyPackageRate != null &&
        service.pricing!.ceremonyPackageRate! > 0) {
      pricingRows.add(SizedBox(height: 12));
      pricingRows.add(_buildSingleRate(
          "Ceremony Package", service.pricing!.ceremonyPackageRate));
    }

    // Per mile charge
    if (service.pricing!.perMileCharge != null &&
        service.pricing!.perMileCharge! > 0) {
      pricingRows.add(SizedBox(height: 8));
      pricingRows.add(_buildSingleRate(
          "Per Mile", service.pricing!.perMileCharge,
          isDecimal: true));
    }

    return pricingRows;
  }

  List<Widget> _buildFuneralPricing() {
    if (service.pricingDetails == null) return [_noPricingWidget()];

    List<Widget> pricingRows = [];

    // Use dayRate instead of fullDayRate for funeral services
    if (_hasAnyRate(service.pricingDetails!.hourlyRate,
        service.pricingDetails!.halfDayRate, service.pricingDetails!.dayRate)) {
      pricingRows.add(_buildRateRow([
        _buildRateColumn("Hourly", service.pricingDetails!.hourlyRate),
        _buildRateColumn("Half Day", service.pricingDetails!.halfDayRate),
        _buildRateColumn("Day Rate", service.pricingDetails!.dayRate),
      ]));
    }

    // Additional funeral-specific rates
    if (service.pricingDetails!.multiDayRate != null &&
        service.pricingDetails!.multiDayRate! > 0) {
      pricingRows.add(SizedBox(height: 12));
      pricingRows.add(_buildSingleRate(
          "Multi-Day Rate", service.pricingDetails!.multiDayRate));
    }

    if (service.pricingDetails!.extraMileageCharge != null &&
        service.pricingDetails!.extraMileageCharge! > 0) {
      pricingRows.add(SizedBox(height: 8));
      pricingRows.add(_buildSingleRate(
          "Extra Mileage Charge", service.pricingDetails!.extraMileageCharge));
    }

    if (service.pricingDetails!.waitTimeFeePerHour != null &&
        service.pricingDetails!.waitTimeFeePerHour! > 0) {
      pricingRows.add(SizedBox(height: 8));
      pricingRows.add(_buildSingleRate("Wait Time Fee (per hour)",
          service.pricingDetails!.waitTimeFeePerHour));
    }

    if (service.pricingDetails!.decoratingFloralServiceFee != null &&
        service.pricingDetails!.decoratingFloralServiceFee! > 0) {
      pricingRows.add(SizedBox(height: 8));
      pricingRows.add(_buildSingleRate("Decorating/Floral Service Fee",
          service.pricingDetails!.decoratingFloralServiceFee));
    }

    // Deposit information
    if (service.pricingDetails!.depositRequired == true &&
        service.pricingDetails!.depositAmount != null &&
        service.pricingDetails!.depositAmount! > 0) {
      pricingRows.add(SizedBox(height: 12));
      pricingRows
          .add(_buildDepositInfo(service.pricingDetails!.depositAmount!));
    }

    // Mileage information
    if (service.pricingDetails!.mileageLimit != null ||
        service.pricingDetails!.mileageAllowance != null) {
      pricingRows.add(SizedBox(height: 8));
      pricingRows.add(_buildMileageInfo());
    }

    return pricingRows;
  }

  List<Widget> _buildMinibusPricing() {
    if (service.miniBusRates == null) return [_noPricingWidget()];

    List<Widget> pricingRows = [];

    if (_hasAnyRate(service.miniBusRates!.hourlyRate,
        service.miniBusRates!.halfDayRate, service.miniBusRates!.fullDayRate)) {
      pricingRows.add(_buildRateRow([
        _buildRateColumn("Hourly", service.miniBusRates!.hourlyRate),
        _buildRateColumn("Half Day", service.miniBusRates!.halfDayRate),
        _buildRateColumn("Full Day", service.miniBusRates!.fullDayRate),
      ]));
    }

    // Mileage information
    if (service.miniBusRates!.mileageAllowance != null &&
        service.miniBusRates!.mileageAllowance! > 0) {
      pricingRows.add(SizedBox(height: 12));
      pricingRows.add(_buildSingleRate(
          "Mileage Allowance", service.miniBusRates!.mileageAllowance,
          suffix: " miles"));
    }

    if (service.miniBusRates!.additionalMileageFee != null &&
        service.miniBusRates!.additionalMileageFee! > 0) {
      pricingRows.add(SizedBox(height: 8));
      pricingRows.add(_buildSingleRate("Additional Mileage Fee",
          service.miniBusRates!.additionalMileageFee));
    }

    return pricingRows;
  }

  List<Widget> _buildLimousinePricing() {
    List<Widget> pricingRows = [];

    // Standard rates
    if (_hasAnyRate(
        service.hourlyRate, service.halfDayRate, service.fullDayRate)) {
      pricingRows.add(_buildRateRow([
        _buildRateColumn("Hourly", service.hourlyRate),
        _buildRateColumn("Half Day", service.halfDayRate),
        _buildRateColumn("Full Day", service.fullDayRate),
      ]));
    }

    // Special package rates
    if (service.weddingPackageRate != null && service.weddingPackageRate! > 0) {
      pricingRows.add(SizedBox(height: 12));
      pricingRows
          .add(_buildSingleRate("Wedding Package", service.weddingPackageRate));
    }

    if (service.airportTransferRate != null &&
        service.airportTransferRate! > 0) {
      pricingRows.add(SizedBox(height: 8));
      pricingRows.add(
          _buildSingleRate("Airport Transfer", service.airportTransferRate));
    }

    // Fuel and mileage information
    if (service.fuelIncluded != null) {
      pricingRows.add(SizedBox(height: 12));
      pricingRows
          .add(_buildBooleanInfo("Fuel Included", service.fuelIncluded!));
    }

    if (service.mileageCapLimit != null && service.mileageCapLimit! > 0) {
      pricingRows.add(SizedBox(height: 8));
      pricingRows.add(_buildSingleRate("Mileage Cap", service.mileageCapLimit,
          suffix: " miles", showCurrency: false));
    }

    if (service.mileageCapExcessCharge != null &&
        service.mileageCapExcessCharge! > 0) {
      pricingRows.add(SizedBox(height: 8));
      pricingRows.add(_buildSingleRate(
          "Excess Mileage Charge", service.mileageCapExcessCharge));
    }

    return pricingRows.isEmpty ? [_noPricingWidget()] : pricingRows;
  }

  List<Widget> _buildChauffeurPricing() {
    List<Widget> pricingRows = [];

    if (service.pricing != null &&
        _hasAnyRate(service.pricing!.hourlyRate, service.pricing!.halfDayRate,
            service.pricing!.fullDayRate)) {
      pricingRows.add(_buildRateRow([
        _buildRateColumn("Hourly", service.pricing!.hourlyRate),
        _buildRateColumn("Half Day", service.pricing!.halfDayRate),
        _buildRateColumn("Full Day", service.pricing!.fullDayRate),
      ]));
    } else if (service.pricingDetails != null &&
        _hasAnyRate(
            service.pricingDetails!.hourlyRate,
            service.pricingDetails!.halfDayRate,
            service.pricingDetails!.fullDayRate)) {
      pricingRows.add(_buildRateRow([
        _buildRateColumn("Hourly", service.pricingDetails!.hourlyRate),
        _buildRateColumn("Half Day", service.pricingDetails!.halfDayRate),
        _buildRateColumn("Full Day", service.pricingDetails!.fullDayRate),
      ]));
    } else if (_hasAnyRate(
        service.hourlyRate, service.halfDayRate, service.fullDayRate)) {
      pricingRows.add(_buildRateRow([
        _buildRateColumn("Hourly", service.hourlyRate),
        _buildRateColumn("Half Day", service.halfDayRate),
        _buildRateColumn("Full Day", service.fullDayRate),
      ]));
    }

    return pricingRows.isEmpty ? [_noPricingWidget()] : pricingRows;
  }

  List<Widget> _buildCoachPricing() {
    List<Widget> pricingRows = [];

    // Try different pricing sources
    if (service.pricing != null &&
        _hasAnyRate(service.pricing!.hourlyRate, service.pricing!.halfDayRate,
            service.pricing!.fullDayRate)) {
      pricingRows.add(_buildRateRow([
        _buildRateColumn("Hourly", service.pricing!.hourlyRate),
        _buildRateColumn("Half Day", service.pricing!.halfDayRate),
        _buildRateColumn("Full Day", service.pricing!.fullDayRate),
      ]));
    } else if (service.pricingDetails != null &&
        _hasAnyRate(
            service.pricingDetails!.hourlyRate,
            service.pricingDetails!.halfDayRate,
            service.pricingDetails!.fullDayRate)) {
      pricingRows.add(_buildRateRow([
        _buildRateColumn("Hourly", service.pricingDetails!.hourlyRate),
        _buildRateColumn("Half Day", service.pricingDetails!.halfDayRate),
        _buildRateColumn("Full Day", service.pricingDetails!.fullDayRate),
      ]));
    } else if (_hasAnyRate(
        service.hourlyRate, service.halfDayRate, service.fullDayRate)) {
      pricingRows.add(_buildRateRow([
        _buildRateColumn("Hourly", service.hourlyRate),
        _buildRateColumn("Half Day", service.halfDayRate),
        _buildRateColumn("Full Day", service.fullDayRate),
      ]));
    }

    return pricingRows.isEmpty ? [_noPricingWidget()] : pricingRows;
  }

  List<Widget> _buildGeneralPricing() {
    List<Widget> pricingRows = [];

    // Try pricing object first, then service level rates, then pricingDetails
    if (service.pricing != null &&
        _hasAnyRate(service.pricing!.hourlyRate, service.pricing!.halfDayRate,
            service.pricing!.fullDayRate)) {
      pricingRows.add(_buildRateRow([
        _buildRateColumn("Hourly", service.pricing!.hourlyRate),
        _buildRateColumn("Half Day", service.pricing!.halfDayRate),
        _buildRateColumn("Full Day", service.pricing!.fullDayRate),
      ]));
    } else if (_hasAnyRate(
        service.hourlyRate, service.halfDayRate, service.fullDayRate)) {
      pricingRows.add(_buildRateRow([
        _buildRateColumn("Hourly", service.hourlyRate),
        _buildRateColumn("Half Day", service.halfDayRate),
        _buildRateColumn("Full Day", service.fullDayRate),
      ]));
    } else if (service.pricingDetails != null &&
        _hasAnyRate(
            service.pricingDetails!.hourlyRate,
            service.pricingDetails!.halfDayRate,
            service.pricingDetails!.fullDayRate)) {
      pricingRows.add(_buildRateRow([
        _buildRateColumn("Hourly", service.pricingDetails!.hourlyRate),
        _buildRateColumn("Half Day", service.pricingDetails!.halfDayRate),
        _buildRateColumn("Full Day", service.pricingDetails!.fullDayRate),
      ]));
    }

    return pricingRows.isEmpty ? [_noPricingWidget()] : pricingRows;
  }

  bool _hasAnyRate(num? hourly, num? halfDay, num? fullDay) {
    return (hourly != null && hourly > 0) ||
        (halfDay != null && halfDay > 0) ||
        (fullDay != null && fullDay > 0);
  }

  Widget _buildRateRow(List<Widget> columns) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: columns,
    );
  }

  Widget _buildRateColumn(String label, num? rate) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4),
          Text(
            rate != null && rate > 0 ? "£${rate.toStringAsFixed(0)}" : "N/A",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSingleRate(String label, num? rate,
      {String suffix = "", bool isDecimal = false, bool showCurrency = true}) {
    String value = "N/A";
    if (rate != null && rate > 0) {
      if (showCurrency) {
        value = isDecimal
            ? "£${rate.toStringAsFixed(2)}"
            : "£${rate.toStringAsFixed(0)}";
      } else {
        value = isDecimal ? rate.toStringAsFixed(2) : rate.toStringAsFixed(0);
      }
      value += suffix;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.green.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageDescription(String label, String description) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepositInfo(int depositAmount) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.shade100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Deposit Required",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "£${depositAmount.toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.orange.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMileageInfo() {
    String mileageText = "";
    if (service.pricingDetails?.mileageLimit != null) {
      mileageText = "${service.pricingDetails!.mileageLimit} miles limit";
    } else if (service.pricingDetails?.mileageAllowance != null) {
      mileageText =
          "${service.pricingDetails!.mileageAllowance} miles allowance";
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Mileage",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            mileageText,
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBooleanInfo(String label, bool value) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: value ? Colors.green.shade50 : Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: value ? Colors.green.shade100 : Colors.red.shade100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value ? "Yes" : "No",
            style: TextStyle(
              fontSize: 14,
              color: value ? Colors.green.shade700 : Colors.red.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _noPricingWidget() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Icon(
            Icons.price_check_outlined,
            size: 48,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 8),
          Text(
            "Pricing information not available",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "Please contact for custom quotes",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
