import 'package:hire_any_thing/utilities/constant.dart';
import 'package:flutter/material.dart';

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  double _minPrice = 20;
  double _maxPrice = 680;
  int _bedrooms = 2;
  int _beds = 1;
  double _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Destination Type
            Text("Destination Type",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDestinationTypeButton(Icons.location_city, "City"),
                  _buildDestinationTypeButton(Icons.beach_access, "Beach Front",
                      selected: true),
                  _buildDestinationTypeButton(Icons.landscape, "Landmark"),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Price Range Slider
            Text("Price",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 10),
            SliderTheme(
              data: SliderThemeData(
                activeTrackColor: kPrimaryColor,
                thumbColor: kPrimaryColor,
                trackHeight: 4,
              ),
              child: RangeSlider(
                values: RangeValues(_minPrice, _maxPrice),
                min: 0,
                max: 1000,
                onChanged: (RangeValues values) {
                  setState(() {
                    _minPrice = values.start;
                    _maxPrice = values.end;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPriceTextField("Minimum", _minPrice),
                _buildPriceTextField("Maximum", _maxPrice),
              ],
            ),
            SizedBox(height: 20),

            // Rating
            Text("Rating",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildRatingButton("Any", 0),
                  _buildRatingButton("5.0", 5),
                  _buildRatingButton("4.0", 4),
                  _buildRatingButton("3.0", 3),
                  _buildRatingButton("2.0", 2),
                  _buildRatingButton("1.0", 1),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Rooms and Beds
            Text("Rooms and Beds",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildRoomOption("Bedrooms", _bedrooms, () {
                  setState(() {
                    if (_bedrooms > 1) _bedrooms--;
                  });
                }, () {
                  setState(() {
                    _bedrooms++;
                  });
                }),
                _buildRoomOption("Beds", _beds, () {
                  setState(() {
                    if (_beds > 1) _beds--;
                  });
                }, () {
                  setState(() {
                    _beds++;
                  });
                }),
              ],
            ),
            Spacer(),

            // Buttons at the bottom
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // Clear All Action
                  },
                  child: Text("Clear All"),
                  style: TextButton.styleFrom(foregroundColor: Colors.grey),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Search Action
                  },
                  child: Text("Search"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDestinationTypeButton(IconData icon, String label,
      {bool selected = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton.icon(
        onPressed: () {
          // Handle destination type selection
        },
        icon: Icon(icon, color: selected ? Colors.white : kPrimaryColor),
        label: Text(label,
            style: TextStyle(color: selected ? Colors.white : kPrimaryColor)),
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? kPrimaryColor : Colors.white,
          side: BorderSide(color: kPrimaryColor),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }

  Widget _buildPriceTextField(String label, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(child: Text("\$${value.toInt()}")),
        ),
      ],
    );
  }

  Widget _buildRatingButton(String label, double rating) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedRating = rating;
          });
        },
        child: Row(
          children: [
            Icon(
              Icons.star_border,
              size: 18,
            ),
            SizedBox(
              width: 3,
            ),
            Text(label),
          ],
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor:
              _selectedRating == rating ? Colors.white : Colors.black,
          backgroundColor:
              _selectedRating == rating ? kPrimaryColor : Colors.grey.shade200,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          side: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildRoomOption(String label, int value, VoidCallback onDecrease,
      VoidCallback onIncrease) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
        SizedBox(height: 4),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              onPressed: onDecrease,
              color: Colors.grey,
            ),
            Text(value.toString()),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              onPressed: onIncrease,
              color: kPrimaryColor,
            ),
          ],
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(home: Testing()));
}
