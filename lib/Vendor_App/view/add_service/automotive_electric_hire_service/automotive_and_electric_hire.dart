import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/cutom_widgets/signup_textfilled.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/custom_checkbox.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/custom_dropdown.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/calenderController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupanController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/image_controller.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/vender_side_getx_controller.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AutomotiveElectricHireService extends StatefulWidget {
  final Rxn<String> Category;
  final Rxn<String> SubCategory;
   final String? CategoryId;
  final String? SubCategoryId;

  const AutomotiveElectricHireService(
      {super.key, required this.Category, required this.SubCategory,this.CategoryId, this.SubCategoryId});

  @override
  State<AutomotiveElectricHireService> createState() =>
      _AutomotiveElectricHireServiceState();
}

class _AutomotiveElectricHireServiceState extends State<AutomotiveElectricHireService> {
   final ImageController imageController = Get.put(ImageController());
   final CouponController couponController = Get.put(CouponController());
  final CalendarController Calendercontroller = Get.put(CalendarController());

  TextEditingController kmPriceController = TextEditingController();

  TextEditingController streetNameController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController desController = TextEditingController();

  TextEditingController jobTitleController = TextEditingController();

    TextEditingController experienceController = TextEditingController();
   TextEditingController SpecializationsController = TextEditingController();
    TextEditingController KeySkillsCompletedController = TextEditingController();
     TextEditingController KeyProjectCompletedController = TextEditingController();
   TextEditingController  automativeDefaultPriceController = TextEditingController();
  TextEditingController oneDayPriceController =TextEditingController();
  TextEditingController perHourPriceController = TextEditingController();
  final List<String> timeSlots = ["morning", "afternoon", "evening", "night"];
    TextEditingController preferredWorkLocationsController =
      TextEditingController();
  String? selectedTimeSlot;
  String? ServiceStatus;

  bool isOneDayHire = false;
  bool isPerHourHire = false;

  bool isGDPR = false;
   bool isTNC = false;
    bool isContactDetails = false;
     bool isCookiesPolicy = false;
      bool isPrivacyPolicy = false;

   final Map<String, bool> days = {
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Saturday': false,
    'Sunday': false,
  };

  File? _logoImage;
  File? _coverImage;
   bool loader = false;
   String vendorId ="";
 
  final GlobalKey<FormState> _automotivehireKey = GlobalKey<FormState>();

 

@override
void initState() {
  super.initState();
      _loadVendorId();
      print('Cate ${widget.CategoryId}');
      print(widget.SubCategoryId);

}
    Future<void> _loadVendorId() async {
    vendorId = (await SessionVendorSideManager().getVendorId())!;
    print(vendorId); 
    

    setState(() {
     
    });
  }


// void _submitForm() async {
//   if (_automotivehireKey.currentState!.validate()) {
//     final data = {
//       "automativeDefaultPrice": automativeDefaultPriceController.text.trim(),
//       "automativeServicePrice": "",
//       "automativeYearsOfExperience": experienceController.text.trim(),
//       "automotiveJobTitle": jobTitleController.text.trim(),
//       "automotivePreferredWorkLocation": preferredWorkLocationsController.text.trim().isNotEmpty
//           ? preferredWorkLocationsController.text.trim().split(',') 
//           : [],
//       "automotiveService_image": imageController.uploadedUrls, 
//       "automotiveServicesOffered": [
//         {"service_name": "General Maintenance", "original_price": 56, "discounted_price": 0},
//         {"service_name": "Floor Fitting", "original_price": 64, "discounted_price": 0},
//         {"service_name": "Gas & Heating", "original_price": 66, "discounted_price": 0},
//         {"service_name": "ssss", "original_price": 32, "discounted_price": 0}
//       ],
//       "automotiveSpecialization": SpecializationsController.text.trim(),
//       "automotive_keyProjects": KeyProjectCompletedController.text.trim(),
//       "automotive_keySkills": KeySkillsCompletedController.text.trim(),
//       "booking_date_from": Calendercontroller.bookingDateFrom,
//       "booking_date_to": Calendercontroller.bookingDateTo,
//       "categoryId": widget.CategoryId,
//       "subcategoryId": widget.SubCategoryId,
//       "daysAvailable": selectedDays.isNotEmpty ? selectedDays : [], // List of available days
//       "one_day_price": int.tryParse(oneDayPriceController.text.trim()) ?? 0,
//       "per_hour_price": int.tryParse(perHourPriceController.text.trim()) ?? 0,
//       "service_status": ServiceStatus ?? "close",
//       "timeSlot": selectedTimeSlot ?? "afternoon",
//       "vendorId": vendorId,
//     };

//     // API call
//     final isAdded = await apiServiceVenderSide.addServiceVendor(data);

//     if (isAdded) {
//       Get.to(Home());
//     } else {
//       Get.snackbar("Error", "Add Service Failed. Please try again.",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.redAccent,
//           colorText: Colors.white);
//     }
//   }
// }



  final VenderSidetGetXController venderSidetGetXController =
      Get.put(VenderSidetGetXController());

  // String? selectedHireOption; // Default selected option
  // String selectedSubOption = 'Sub C.. Limousine Hire'; // Default selected option

 
     



  @override
  Widget build(BuildContext context) {
        final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: colors.scaffold_background_color,
        appBar: AppBar(
          backgroundColor: colors.white,
          elevation: 0,
          centerTitle: true,
          title: Obx(() => Text(
                'Add ${widget.SubCategory.value ?? ''} Service', // Handles null safety
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: colors.black),
              )),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _automotivehireKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                            const Text(
                  'Default Price *',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                
                Signup_textfilled(
                  length: 50,
                  textcont: automativeDefaultPriceController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  // textcont: shonum,

                  keytype: TextInputType.number,
                  hinttext: "Price will be same for all Services",
                ),
                          const Text(
                  'Service Availability Period',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),

                const Text(
                  'Select the Period during which your service will be avilable',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Color.fromARGB(255, 109, 104, 104)),
                ),
                const SizedBox(height: 40),
                 
                Obx(
                  () => _buildDatePicker(
                      context, "From", Calendercontroller.fromDate, true),
                ),
                Obx(
                  () => _buildDatePicker(
                      context, "To", Calendercontroller.toDate, false),
                ),

                SizedBox(height: 10),
                Obx(() => TableCalendar(
                      focusedDay: Calendercontroller.fromDate.value,
                      firstDay: DateTime.utc(2025, 1, 1),
                      lastDay: DateTime.utc(2050, 12, 31),
                      calendarFormat: CalendarFormat.month,
                      availableGestures: AvailableGestures.none,
                      headerStyle: HeaderStyle(formatButtonVisible: false),
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) {
                          if (Calendercontroller.visibleDates
                              .any((d) => isSameDay(d, day))) {
                            return _buildCalendarCell(day);
                          }
                          return SizedBox.shrink(); // Hide all other dates
                        },
                      ),
                    )),
                          const SizedBox(height: 10),
                                                 const SizedBox(height: 20),
                   const Text(
                  'Availability',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                
                SizedBox(height: 15),
                     
                   const Text(
                  'Days Available *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                
                SizedBox(height: 10),
               GridView.builder(
      shrinkWrap: true, // Prevent unnecessary scrolling
      physics: NeverScrollableScrollPhysics(), // Disable scrolling inside GridView
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Adjust for 2 columns
        crossAxisSpacing: 20,
        mainAxisSpacing: 1,
        childAspectRatio: 6, // Adjust to fit UI properly
      ),
      itemCount: days.length,
      itemBuilder: (context, index) {
        String day = days.keys.elementAt(index);
        return CustomCheckbox(
          title: day,
          value: days[day]!,
          onChanged: (value) {
            setState(() {
              days[day] = value!;
            });
          },
        );
      },
    ),

                const SizedBox(height: 20),
                   const Text(
                  'Time Slots Available *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                
                SizedBox(height: 10),
                CustomDropdown(
                  hintText: "Select Time Slot",
                  items: timeSlots,
                  selectedValue: selectedTimeSlot,
                  onChanged: (value) {
                    setState(() {
                      selectedTimeSlot = value;
                    });
                  },
                ),

                const SizedBox(height: 20),
                const Text(
                  'Role Preferences',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),
                const Text(
                  'Job Title',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                Signup_textfilled(
                  length: 50,
                  textcont: jobTitleController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  // textcont: shonum,

                  keytype: TextInputType.text,
                  hinttext: "e.g. EV Technician",
                ),

                const SizedBox(height: 10),
                const Text(
                  'Preferred Work Locations *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                Signup_textfilled(
                  length: 50,
                  textcont: preferredWorkLocationsController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  // textcont: shonum,

                  keytype: TextInputType.text,
                  hinttext: "Type a city...",
                ),

                const SizedBox(height: 20),
                CustomCheckboxContainer(
                  title: "One Day Hire?",
                  description:
                      "This package includes service for up to 10 hours, whichever comes first",
                  value: isOneDayHire,
                  onChanged: (value) {
                    setState(() {
                      isOneDayHire = value!;
                    });
                  },
                ),
                 isOneDayHire == true ?
                      
                      Signup_textfilled(
                            length: 500,
                            textcont: oneDayPriceController,
                            textfilled_height: 17,
                            textfilled_weight: 1,
                            // textcont: shonum,

                            keytype: TextInputType.number,
                            hinttext: "Enter package Price (£)",
                          ) :
                         

                  const SizedBox(height: 20),

                

                CustomCheckboxContainer(
                  title: "Per Hour Hire?",
                  description:
                      "This package includes service for up to 10 hours",
                  value: isPerHourHire,
                  onChanged: (value) {
                    setState(() {
                      isPerHourHire = value!;
                    });
                  },
                ),
                 const SizedBox(height: 10),
                isPerHourHire == true ?
                      
                      Signup_textfilled(
                            length: 500,
                            textcont: perHourPriceController,
                            textfilled_height: 17,
                            textfilled_weight: 1,
                            // textcont: shonum,

                            keytype: TextInputType.number,
                            hinttext: "Enter package Price (£)",
                          ) :
                         

                  const SizedBox(height: 20),

                    const Text(
                  'Experience And Portfolio',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                   const Text(
                  'Total Years of Experience',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                 const SizedBox(height: 10),

                Signup_textfilled(
                  length: 50,
                  textcont:experienceController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  // textcont: shonum,

                  keytype: TextInputType.number,
                  hinttext: "0",
                ),

                const SizedBox(height: 20),
                  const Text(
                  'Specializations *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                 const SizedBox(height: 10),

                Signup_textfilled(
                  length: 50,
                  textcont:SpecializationsController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  // textcont: shonum,

                  keytype: TextInputType.text,
                  hinttext: "e.g. Computer Engineering",
                ),

                const SizedBox(height: 20),
              
                  const Text(
                  'Service Status *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                 const SizedBox(height: 10),
                  CustomDropdown(
                  hintText: "Select Status",
                  items:['open','close'],
                  selectedValue: ServiceStatus,
                  onChanged: (value) {
                    setState(() {
                      ServiceStatus = value;
                    });
                  },
                ),

                const SizedBox(height: 20),
                 
                  const Text(
                  'Key Projects Completed *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                 const SizedBox(height: 10),

                Signup_textfilled(
                  length: 400,
                  textcont:KeyProjectCompletedController,
                  textfilled_height: 8,
                  textfilled_weight: 1,
                  // textcont: shonum,

                  keytype: TextInputType.text,
                  hinttext: "e.g. mathematics tutor,CBSE expert",
                ),

                const SizedBox(height: 20),
                
               
                          const SizedBox(height: 20),
                            const Text("Service Images *",
                    style: TextStyle(color: Colors.black87, fontSize: 16)),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child:  Obx(() => Wrap(
                children: List.generate(imageController.selectedImages.length,
                    (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Image.file(
                          File(imageController.selectedImages[index]),
                          fit: BoxFit.cover,
                          height: 60,
                          width: 60,
                        ),
                        Positioned(
                          top: 2,
                          right: 2,
                          child: GestureDetector(
                            onTap: () => imageController.removeImage(index),
                            child: Icon(Icons.close, color: Colors.redAccent),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              )))),
                const SizedBox(height: 20),
             // Upload Button
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.camera),
                        title: Text('Take a Photo'),
                        onTap: () {
                          imageController.pickImages(true);
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.photo_library),
                        title: Text('Choose from Gallery'),
                        onTap: () {
                          imageController.pickImages(false);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: DottedBorder(
              color: Colors.black,
              strokeWidth: 1,
              dashPattern: [5, 5],
              child: Container(
                height: 150,
                width: double.infinity,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud_upload_outlined, size: 40, color: Colors.grey),
                      Text(
                        "Click to upload or drag and drop PNG, JPG (MAX. 800x400px)",
                        style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
                const SizedBox(height:30),
                 const SizedBox(height: 20),

                CustomCheckbox(
                  title: 'I agree to the processing of my personal data in accordance with the GDPR and the company\'s privacy policy', 
                  value: isGDPR, 
                  onChanged: (value) {
                    setState(() {
                      isGDPR = value!;
                    });
                  },
                  ),
                   const SizedBox(height: 20),
                   CustomCheckbox(
                  title: 'I agree to the Terms and Conditions', 
                  value: isTNC, 
                  onChanged: (value) {
                    setState(() {
                      isTNC = value!;
                    });
                  },
                  ),
                   const SizedBox(height: 20),
                   CustomCheckbox(
                  title: 'I have not shared any contact details (Email, Phone, Skype, Website etc.)', 
                  value: isContactDetails, 
                  onChanged: (value) {
                    setState(() {
                      isContactDetails = value!;
                    });
                  },
                  ),
                   const SizedBox(height: 20),
                   CustomCheckbox(
                  title: 'I agree to the Cookies Policy', 
                  value: isCookiesPolicy, 
                  onChanged: (value) {
                    setState(() {
                      isCookiesPolicy = value!;
                    });
                  },
                  ),
                   const SizedBox(height: 20),
                    CustomCheckbox(
                  title: 'I agree to the Privacy Policy', 
                  value: isPrivacyPolicy, 
                  onChanged: (value) {
                    setState(() {
                      isPrivacyPolicy = value!;
                    });
                  },
                  ),
                   const SizedBox(height: 20),

                       
                   const SizedBox(height: 20),
                     Container(
                  width: w,
                  height: 50,
                  
                  child: ElevatedButton(
                    onPressed: () {
                  // _submitForm();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                       
                          return Colors.green;
                        },
                      ),
                    ),
                    child: (loader == true)
                        ? CircularProgressIndicator(
                            color: Colors.blue,
                          )
                        : const Text(
                            "Submit Service",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),

                const SizedBox(height: 20),



                
              

                        ])))));
  }
}

Widget _buildDatePicker(BuildContext context, String label,
    Rx<DateTime> selectedDate, bool isFrom) {
  final CalendarController calendarController = Get.put(CalendarController());
  return ListTile(
    title: Text(
        "$label: ${DateFormat('dd-MM-yyyy HH:mm').format(selectedDate.value)}"),
    trailing: Icon(Icons.calendar_today),
    onTap: () async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(2025, 2, 1),
        lastDate: DateTime(2050, 12, 31),
      );

      if (pickedDate != null) {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(selectedDate.value),
        );

        if (pickedTime != null) {
          DateTime finalDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          if (isFrom) {
            calendarController.updateDateRange(
                finalDateTime, calendarController.toDate.value);
          } else {
            calendarController.updateDateRange(
                calendarController.fromDate.value, finalDateTime);
          }
        }
      }
    },
  );
}

Widget _buildCalendarCell(DateTime date) {
  return Center(
    child: Text(
      DateFormat('d').format(date),
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
    ),
  );
}
