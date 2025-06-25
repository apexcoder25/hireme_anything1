import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/about_controller.dart';
import 'package:hire_any_thing/views/UserHomePage/user_drawer.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final AboutController aboutController = Get.put(AboutController());

  int _selectedIndex = 4;

  void _onDrawerItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100], 
  
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[100],
        elevation: 0,
        centerTitle: true,
        title: Text(
          'About',
          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu, color: colors.black),
          ),
        ),
      ),
      drawer: UserDrawer(onItemSelected: _onDrawerItemSelected),
      body:Obx(() {
        if (aboutController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        else if(aboutController.aboutInfo.isEmpty){
            return Center(child: Text("No About Info"));
        }
         else {
           return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           
            Container(
              width: double.infinity,
              height: 370, 
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: NetworkImage(
                  aboutController.aboutInfo[0].image.toString()
                  ),
                  fit: BoxFit.cover,
                  
                 
                ),
              ),
            
            ),
            const SizedBox(height: 20),

    
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCategoryChip('Event Rentals'),
                const SizedBox(width: 10),
                _buildCategoryChip('Transportation'),
              ],
            ),
            const SizedBox(height: 20),

            Text(
              'Welcome to HireAnything',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
             Text(
              'About Us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
             Divider( 
              color: Colors.grey, 
              thickness: 1.0, 
          
            ),
            const SizedBox(height: 10),

            
            Text(
             aboutController.aboutInfo[0].aboutus.toString(),
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

           
            Text(
              'A Marketplace for Hire Services',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
             Divider( 
              color: Colors.grey, 
              thickness: 1.0, 
          
            ),
            const SizedBox(height: 10),
            Text(
         aboutController.aboutInfo[0].marketPlace.toString(),
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

           
            Text(
              'The Problem',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
             Divider( 
              color: Colors.grey, 
              thickness: 1.0, 
          
            ),
            const SizedBox(height: 10),

            Text(
             aboutController.aboutInfo[0].problem.toString(),
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            Text(
              'The Solution',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
             Divider( 
              color: Colors.grey, 
              thickness: 1.0, 
          
            ),
            const SizedBox(height: 10),
           
            Text(
              aboutController.aboutInfo[0].solution.toString(),
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40), 
          ],
        ),
      );
        }

      } ),
      
      
     
    );
  }

  // Helper method to create category chips
  Widget _buildCategoryChip(String category) {
    return Chip(
      label: Text(
        category,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey[300]!, width: 1),
      ),
    );
  }
}