import 'package:flutter/material.dart';

class BookingStatusScreen extends StatefulWidget {
  const BookingStatusScreen({super.key});

  @override
  State<BookingStatusScreen> createState() => _BookingStatusScreenState();
}

class _BookingStatusScreenState extends State<BookingStatusScreen> {
  String selectedFilter = 'Pending';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Management Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Summary Cards in Column
            _summaryCard('0', 'Pending', Colors.orange),
            const SizedBox(height: 10),
            _summaryCard('0', 'Completed', Colors.green),
            const SizedBox(height: 10),
            _summaryCard('0', 'Cancelled', Colors.red),
            const SizedBox(height: 10),
            _summaryCard('£0.00', 'Total Revenue', Colors.indigo),

            const SizedBox(height: 20),

            // Filter Buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _filterButton('Pending', Colors.orange),
                  _filterButton('Completed', Colors.green),
                  _filterButton('Cancelled', Colors.red),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Search and Filter
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search bookings...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: 'All Time',
                  items: ['All Time', 'Today', 'This Week']
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ))
                      .toList(),
                  onChanged: (_) {},
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Data Table with horizontal scroll
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Order No')),
                  DataColumn(label: Text('Customer Name')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Mobile')),
                  DataColumn(label: Text('Service Name')),
                  DataColumn(label: Text('Category')),
                  DataColumn(label: Text('Pickup Location')),
                  DataColumn(label: Text('Drop Location')),
                  DataColumn(label: Text('Special Request')),
                  DataColumn(label: Text('Pickup Date')),
                  DataColumn(label: Text('Pickup Time')),
                  DataColumn(label: Text('Distance')),
                  DataColumn(label: Text('Seats')),
                  DataColumn(label: Text('Total Amount')),
                  DataColumn(label: Text('Payment Status')),
                  DataColumn(label: Text('Action')),
                  DataColumn(label: Text('Invoice')),
                  DataColumn(label: Text('Date')),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text(
                        'No ${selectedFilter.toLowerCase()} bookings available.',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                      )),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Pagination Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(onPressed: () {}, child: Text('Previous')),
                const SizedBox(width: 10),
                Text('Page 1 of 1'),
                const SizedBox(width: 10),
                OutlinedButton(onPressed: () {}, child: Text('Next')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(String count, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(count,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 8),
          Text(label, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _filterButton(String label, Color color) {
    final isSelected = selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? color : Colors.grey.shade300,
          foregroundColor: isSelected ? Colors.white : Colors.black,
        ),
        onPressed: () {
          setState(() {
            selectedFilter = label;
          });
        },
        icon: Icon(_getIcon(label)),
        label: Text('$label (0)'),
      ),
    );
  }

  IconData _getIcon(String label) {
    switch (label) {
      case 'Pending':
        return Icons.watch_later;
      case 'Completed':
        return Icons.check_circle;
      case 'Cancelled':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }
}
