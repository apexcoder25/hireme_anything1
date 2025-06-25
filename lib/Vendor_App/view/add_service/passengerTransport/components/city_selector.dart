// components/city_selector.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/components/passenger_service_viewmodel.dart';


class CitySelector extends StatefulWidget {
  const CitySelector({super.key});

  @override
  State<CitySelector> createState() => _CitySelectorState();
}

class _CitySelectorState extends State<CitySelector> {
  @override
  Widget build(BuildContext context) {
    final vm = Get.put(PassengerServiceViewModel());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Cities Available *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) async {
            if (textEditingValue.text.isEmpty) return const Iterable<String>.empty();
            vm.cityFetchController.onTextChanged(textEditingValue.text);
            return vm.cityFetchController.placeList.map((place) => place['description'] as String);
          },
          onSelected: (String selection) {
            if (!vm.selectedCities.contains(selection)) {
              vm.selectedCities.add(selection);
            }
            vm.cityFetchController.clearSearch();
          },
          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
            return TextField(
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: "Type to search cities",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        Obx(() => Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              constraints: const BoxConstraints(minHeight: 50),
              child: vm.selectedCities.isEmpty
                  ? const Text('No cities selected', style: TextStyle(color: Colors.grey, fontSize: 16))
                  : Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: vm.selectedCities
                          .map((city) => Chip(
                                label: Text(city, style: const TextStyle(fontSize: 14)),
                                deleteIcon: const Icon(Icons.close, size: 18),
                                onDeleted: () => vm.selectedCities.remove(city),
                                backgroundColor: Colors.grey[200],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ))
                          .toList(),
                    ),
            )),
        const SizedBox(height: 20),
      ],
    );
  }
}