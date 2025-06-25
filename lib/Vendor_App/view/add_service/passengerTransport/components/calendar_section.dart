// components/calendar_section.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/calenderController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/components/passenger_service_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class CalendarSection extends StatefulWidget {
  const CalendarSection({super.key});

  @override
  State<CalendarSection> createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  void _showSetPriceDialog(BuildContext context, DateTime date, PassengerServiceViewModel vm) {
    final controller = TextEditingController(
        text: vm.calendarController.getPriceForDate(date)?.toString() ?? vm.vendorServiceModel.value.kilometerPrice.toString());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Set Special Price for ${DateFormat('dd/MM/yyyy').format(date)}'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Price per Mile (£)', border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              final price = int.tryParse(controller.text) ?? 0;
              if (price >= 0) {
                vm.setSpecialPrice(date, price);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid price (≥ 0)')));
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<PassengerServiceViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Service Availability Period', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        const Text('Select the Period during which your service will be available',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 109, 104, 104))),
        const SizedBox(height: 20),
        Obx(() => _buildDatePicker(context, "From", vm.calendarController.fromDate, true)),
        Obx(() => _buildDatePicker(context, "To", vm.calendarController.toDate, false)),
        const SizedBox(height: 10),
        Obx(() => TableCalendar(
              onDaySelected: (selectedDay, focusedDay) {
                if (vm.calendarController.visibleDates.any((d) => isSameDay(d, selectedDay))) {
                  vm.calendarController.fromDate.value = focusedDay;
                  _showSetPriceDialog(context, selectedDay, vm);
                }
              },
              focusedDay: vm.calendarController.fromDate.value,
              firstDay: DateTime.utc(2025, 1, 1),
              lastDay: DateTime.utc(2050, 12, 31),
              calendarFormat: CalendarFormat.month,
              availableGestures: AvailableGestures.none,
              headerStyle: const HeaderStyle(formatButtonVisible: false),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  final isClickable = vm.calendarController.visibleDates.any((d) => isSameDay(d, day));
                  return _buildCalendarCell(day, isClickable, vm);
                },
              ),
            )),
        const SizedBox(height: 20),
        const Text('Special Prices Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        SizedBox(
          height: 150,
          child: Obx(() => vm.calendarController.specialPrices.isEmpty
              ? const Center(
                  child: Text('No special prices set yet', style: TextStyle(fontSize: 16, color: Colors.black)))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: vm.calendarController.specialPrices.length,
                  itemBuilder: (context, index) {
                    final entry = vm.calendarController.specialPrices[index];
                    final date = entry['date'] as DateTime;
                    final price = entry['price'] as double;
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DateFormat('EEE, d MMM yyyy').format(date), style: const TextStyle(fontSize: 16)),
                          Row(
                            children: [
                              Text('£${price.toStringAsFixed(2)}/mile',
                                  style: TextStyle(fontSize: 16, color: price > 0 ? Colors.black : Colors.red)),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => vm.calendarController.deleteSpecialPrice(date),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context, String label, Rx<DateTime> selectedDate, bool isFrom) {
    final vm = Get.find<PassengerServiceViewModel>();
    return ListTile(
      title: Text("$label: ${DateFormat('dd-MM-yyyy HH:mm').format(selectedDate.value)}"),
      trailing: const Icon(Icons.calendar_today),
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate.value,
          firstDate: DateTime(2025, 2, 1),
          lastDate: DateTime(2099, 12, 31),
        );
        if (pickedDate != null) {
          final pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(selectedDate.value));
          if (pickedTime != null) {
            final finalDateTime = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
            if (isFrom) {
              vm.calendarController.updateDateRange(finalDateTime, vm.calendarController.toDate.value);
            } else {
              vm.calendarController.updateDateRange(vm.calendarController.fromDate.value, finalDateTime);
            }
          }
        }
      },
    );
  }

  Widget _buildCalendarCell(DateTime day, bool isClickable, PassengerServiceViewModel vm) {
    final defaultPrice = vm.vendorServiceModel.value.kilometerPrice.toDouble();
    final price = vm.calendarController.getPriceForDate(day) ?? defaultPrice;

    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
        color: isClickable ? Colors.white : Colors.grey.withOpacity(0.3),
      ),
      child: InkWell(
        onTap: isClickable ? () => _showSetPriceDialog(Get.context!, day, vm) : null,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                DateFormat('d').format(day),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isClickable ? Colors.black : Colors.grey),
              ),
              Text(
                '£${price.toStringAsFixed(2)}/mile',
                style: TextStyle(fontSize: 7, color: isClickable ? (price > 0 ? Colors.red : Colors.red) : Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}