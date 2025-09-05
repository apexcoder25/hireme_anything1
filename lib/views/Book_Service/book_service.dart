import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/cutom_widgets/signup_textfilled.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/city_fetch_controller.dart';
import 'package:hire_any_thing/views/Book_Service/your_services_booking.dart';
import 'package:intl/intl.dart';

class BookServices extends StatefulWidget {
  final String categoryId;
  final String subcategoryId;
  final String id;
  final String fromDate;
  final String todate;
  final String capacity;
  final String ServiceCities;
  final String minDistance;
  final String maxDistsnce;
  final String? vehicleTypes; // Optional for funeral
  final String? packageOptions; // Optional for funeral
  final String? carriageTypes; // Optional for horse
  final String? horseTypes; // Optional for horse
  final String? vehicleType; // Optional for chauffeur
  final String? makeModel; // Optional for chauffeur
  const BookServices({
    super.key,
    this.categoryId = "",
    this.subcategoryId = "",
    this.id = "",
    this.fromDate = "",
    this.todate = "",
    this.capacity = "",
    this.ServiceCities = "",
    this.minDistance = "",
    this.maxDistsnce = "",
    this.vehicleTypes,
    this.packageOptions,
    this.carriageTypes,
    this.horseTypes,
    this.vehicleType,
    this.makeModel,
  });

  @override
  State<BookServices> createState() => _BookServicesState();
}

class _BookServicesState extends State<BookServices> {
  late CityFetchController cityFetchController = Get.put(CityFetchController());
  final TextEditingController _fromLocationController = TextEditingController();
  final TextEditingController _toLocationController = TextEditingController();
  final TextEditingController pickupDateController = TextEditingController();
  final TextEditingController pickupTimeController = TextEditingController();

  final GlobalKey<FormState> _bookServiceFormKey = GlobalKey<FormState>();
  String distanceRange = "- miles";
  String availableFrom = "Invalid Date to Invalid Date";
  bool _showFromSuggestions = false;
  bool _showToSuggestions = false;
  String? _fromPlaceId;
  String? _toPlaceId;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    pickupDateController.text = "dd-mm-yyyy";
    pickupTimeController.text = "--:--";

    _fromLocationController.addListener(_validateForm);
    _toLocationController.addListener(_validateForm);
    pickupDateController.addListener(_validateForm);
    pickupTimeController.addListener(_validateForm);

    _fromLocationController.addListener(() {
      cityFetchController.onTextChanged(_fromLocationController.text);
      setState(() {
        _showFromSuggestions = _fromLocationController.text.isNotEmpty;
        _showToSuggestions = false;
      });
    });

    _toLocationController.addListener(() {
      cityFetchController.onTextChanged(_toLocationController.text);
      setState(() {
        _showToSuggestions = _toLocationController.text.isNotEmpty;
        _showFromSuggestions = false;
      });
    });
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _fromLocationController.text.isNotEmpty &&
          _toLocationController.text.isNotEmpty &&
          pickupDateController.text != "dd-mm-yyyy" &&
          pickupTimeController.text != "--:--";
    });
  }

  @override
  void dispose() {
    _fromLocationController.dispose();
    _toLocationController.dispose();
    pickupDateController.dispose();
    pickupTimeController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime() async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now, // Prevent past dates
      lastDate: DateTime(2050),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          pickupDateController.text =
              DateFormat('dd-MM-yyyy').format(pickedDate);
          pickupTimeController.text = pickedTime.format(context);
        });
      }
    }
  }

  Future<void> _calculateDistance() async {
    String pickup = _fromLocationController.text.trim();
    String drop = _toLocationController.text.trim();

    if (pickup.isEmpty ||
        drop.isEmpty ||
        _fromPlaceId == null ||
        _toPlaceId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please set valid pickup and delivery locations")),
      );
      return;
    }

    List<String> serviceCities = getCityList(widget.ServiceCities);

    String fromCity = pickup.split(',')[0].trim();
    String toCity = drop.split(',')[0].trim();

    bool fromCityValid = serviceCities.contains(fromCity);
    bool toCityValid = serviceCities.contains(toCity);

    if (!fromCityValid || !toCityValid) {
      String unavailableCities = '';
      if (!fromCityValid) unavailableCities += '$fromCity';
      if (!toCityValid)
        unavailableCities +=
            (unavailableCities.isNotEmpty ? ', $toCity' : toCity);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Service is available only in these areas: ${serviceCities.join(", ")}. Unavailable: $unavailableCities',
          ),
        ),
      );
      return;
    }

    double? distanceMiles = await cityFetchController.calculateDistanceMiles(
        _fromPlaceId!, _toPlaceId!);
    if (distanceMiles != null) {
      if (distanceMiles == -1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "No driving route exists between these locations. Please select locations within the same region.",
            ),
          ),
        );
      } else {
        double minDistance = double.tryParse(widget.minDistance) ?? 0;
        double maxDistance =
            double.tryParse(widget.maxDistsnce) ?? double.infinity;

        if (distanceMiles < minDistance || distanceMiles > maxDistance) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Distance ($distanceMiles miles) is outside the service range ($minDistance - $maxDistance miles). '
                'Service is available only in these areas: ${serviceCities.join(", ")}.',
              ),
            ),
          );
        } else {
          setState(() {
            distanceRange = '${distanceMiles.toStringAsFixed(1)} miles';
            availableFrom =
                "${formatDateTime(widget.fromDate)} - ${formatDateTime(widget.todate)}";
          });

          try {
            double distance = double.parse(distanceMiles.toStringAsFixed(1));
            Get.to(
              YourServicesBooking(
                id: widget.id,
                distance: distance,
                fromLocation: _fromLocationController.text,
                toLocation: _toLocationController.text,
                pickupTime: pickupTimeController.text,
                pickupDate: pickupDateController.text,
                // capacity: widget.capacity,
                // vehicleTypes: widget.vehicleTypes,
                // packageOptions: widget.packageOptions,
                // carriageTypes: widget.carriageTypes,
                // horseTypes: widget.horseTypes,
                // vehicleType: widget.vehicleType,
                // makeModel: widget.makeModel,
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid distance format')),
            );
          }
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Failed to calculate distance. Please try again.")),
      );
    }
  }

  String formatDateTime(String isoString) {
    if (isoString.isNotEmpty) {
      DateTime dateTime = DateTime.parse(isoString).toLocal();
      return DateFormat('dd-MM-yyyy').format(dateTime);
    }
    return "Invalid Date";
  }

  List<String> getCityList(String cityNames) {
    return cityNames
        .split(',')
        .map((city) => city.trim().replaceAll('[', '').replaceAll(']', ''))
        .where((city) => city.isNotEmpty)
        .toList();
  }

  void _showCityDialog() {
    final cities = getCityList(widget.ServiceCities);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.lightBlue[100],
        title: const Text('All Service Areas',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.9,
              ),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                alignment: WrapAlignment.center,
                children: cities
                    .map((city) => _buildCityTile(city, context))
                    .toList(),
              ),
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildCityTile(String city, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        city,
        style: const TextStyle(
            fontSize: 14, color: Colors.grey, overflow: TextOverflow.ellipsis),
        maxLines: 4,
        softWrap: true,
      ),
    );
  }

  Widget _buildSuggestions(bool isFromField) {
    if ((isFromField && !_showFromSuggestions) ||
        (!isFromField && !_showToSuggestions)) {
      return const SizedBox.shrink();
    }
    return Container(
      constraints: const BoxConstraints(maxHeight: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: Obx(() => ListView.builder(
            shrinkWrap: true,
            itemCount: cityFetchController.placeList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title:
                    Text(cityFetchController.placeList[index]['description']),
                onTap: () {
                  setState(() {
                    if (isFromField) {
                      _fromLocationController.text =
                          cityFetchController.placeList[index]['description'];
                      _fromPlaceId =
                          cityFetchController.placeList[index]['place_id'];
                      _showFromSuggestions = false;
                    } else {
                      _toLocationController.text =
                          cityFetchController.placeList[index]['description'];
                      _toPlaceId =
                          cityFetchController.placeList[index]['place_id'];
                      _showToSuggestions = false;
                    }
                    cityFetchController.clearSearch();
                  });
                },
              );
            },
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[50],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Your Service',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _bookServiceFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Set Delivery Location',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.lightBlue, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Service Availability Information',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    const SizedBox(height: 10),
                    Text(
                        '• Distance Range: ${widget.minDistance} - ${widget.maxDistsnce}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.blue)),
                    Text(
                        '• Available From: ${formatDateTime(widget.fromDate)} - ${formatDateTime(widget.todate)}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.blue)),
                    Text('• Maximum Capacity: ${widget.capacity}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.blue)),
                    if (widget.vehicleTypes != null)
                      Text('• Vehicle Types: ${widget.vehicleTypes}',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.blue)),
                    if (widget.packageOptions != null)
                      Text('• Package Options: ${widget.packageOptions}',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.blue)),
                    if (widget.carriageTypes != null)
                      Text('• Carriage Types: ${widget.carriageTypes}',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.blue)),
                    if (widget.horseTypes != null)
                      Text('• Horse Types: ${widget.horseTypes}',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.blue)),
                    if (widget.vehicleType != null)
                      Text('• Vehicle Type: ${widget.vehicleType}',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.blue)),
                    if (widget.makeModel != null)
                      Text('• Make/Model: ${widget.makeModel}',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.blue)),
                    Row(
                      children: [
                        const Text('• Service Areas: +',
                            style: TextStyle(fontSize: 14, color: Colors.blue)),
                        GestureDetector(
                          onTap: _showCityDialog,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${getCityList(widget.ServiceCities).length} cities',
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.green,
                                    decoration: TextDecoration.underline),
                              ),
                              const Icon(Icons.location_on,
                                  color: Colors.green),
                              const SizedBox(width: 4.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('From:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Signup_textfilled(
                length: 100,
                textcont: _fromLocationController,
                textfilled_height: 17,
                textfilled_weight: 1,
                keytype: TextInputType.text,
                hinttext: "Enter pickup location",
              ),
              _buildSuggestions(true),
              const SizedBox(height: 20),
              const Text('To:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Signup_textfilled(
                length: 100,
                textcont: _toLocationController,
                textfilled_height: 17,
                textfilled_weight: 1,
                keytype: TextInputType.text,
                hinttext: "Enter drop location",
              ),
              _buildSuggestions(false),
              const SizedBox(height: 20),
              const Text('Pickup Date and Time:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: pickupDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "dd-mm-yyyy",
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.green, width: 3),
                        ),
                      ),
                      onTap: _selectDateTime,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: pickupTimeController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "--:--",
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.green, width: 3),
                        ),
                      ),
                      onTap: _selectDateTime,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _isFormValid ? _calculateDistance : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFormValid ? Colors.blue : Colors.grey,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Calculate Distance',
                      style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Distance: $distanceRange\nPlease set your pickup and delivery locations above to see final pricing and proceed with checkout.',
                  style: const TextStyle(fontSize: 14, color: Colors.orange),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
