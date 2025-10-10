import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hire_any_thing/User_app/views/subCategoryPage/electricianDetail.dart';
import '../../main.dart';
import '../../utilities/constant.dart';
import 'date_timeSelect.dart';

class BloodTestSearchBar extends StatefulWidget {
  const BloodTestSearchBar({super.key});

  @override
  State<BloodTestSearchBar> createState() => _BloodTestSearchBarState();
}

class _BloodTestSearchBarState extends State<BloodTestSearchBar> {
  List test = ["Blood", "Urine", "Heart"];
  TextEditingController _controller = TextEditingController();
  late Timer _timer;
  int _currentIndex = 0;
  List<String> _autoTypeTexts = ['\'CBC\'', '\'Lipid Profile\'', '\'Liver\''];
  String _typedText = '';

  late FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    _startAutoTyping();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _startAutoTyping() {
    _timer = Timer.periodic(Duration(milliseconds: 150), (timer) {
      if (!_focusNode.hasFocus) {
        setState(() {
          if (_currentIndex < _autoTypeTexts.length) {
            String currentWord = _autoTypeTexts[_currentIndex];
            String newText = "Search For $currentWord";


            if (_typedText != newText) {
              if (_typedText.length < newText.length) {
                _typedText = newText.substring(0, _typedText.length + 1);
              }
            } else {
              _currentIndex++;
              _typedText = 'Search For';
            }
          } else {
            _currentIndex = 0;
          }
        });
      }
    });
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      _timer.cancel();
    } else {
      _startAutoTyping();
    }
  }
  List<bool> isExpandedList = List.filled(4, false);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return SafeArea(
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.white,
          systemNavigationBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          // bottomNavigationBar: Navi(),

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 5, bottom: 10),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: h/17,
                          width: w / 1.1,
                          child: TextFormField(
            
                              readOnly: false,
                              showCursor: true,
                              cursorColor: Colors.black,
                              cursorWidth: 2.0,
                              cursorHeight: 24.0,
                              textAlign: TextAlign.left,
                              autofocus: true,
            
            
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.search,
                                      color: Colors.grey),
                                  hintText: "Test",
                                  hintStyle: const TextStyle(fontSize: 14),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.grey)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.grey))))),
            
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
            
                  ),
                  Column(
                    children: [
            
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                          itemCount: 2,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            List<String> images = [
                              "assets/icons/bloodcbc.jpg",
                              "assets/icons/liver.jpg",
                              "assets/icons/kidney.jpg",
                              "assets/icons/heart.jpg",
                            ];
                            List<String> names = [
                              "Complete Blood Count",
                              "Liver Function Test",
                              "Kidney Function Test",
                              "Lipid Profile",
                            ];
                            List<String> price = [
                              "500",
                              "600",
                              "900",
                              "800",
                            ];
            
                            int imageIndex = index % images.length;
                            int nameIndex = index % names.length;
                            int priceIndex = index % price.length;
            
                            String imageUrl = images[imageIndex];
                            String name = names[nameIndex];
                            String Price = price[priceIndex];
                            String $rating = "";
                            String description =
                                "Provide better service and description goes here. It can be more than two lines and will show a 'More' button if expanded.";
            
                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isExpandedList[index] = !isExpandedList[index];
                                  });
                                },
                                child: Stack(children: [
                                  Container(
                                      height: MediaQuery.of(context).size.height *
                                          23 /
                                          100,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: ClipRect(
                                        child: Card(
                                          elevation: 0.5,
                                          color: Colors.white,
                                          surfaceTintColor: Colors.transparent,
                                          shadowColor: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              children: [
                                                Row(
            
                                                  children: [
                                                    Container(width: MediaQuery.of(context).size.height*25/100,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            name,
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                FontWeight.bold),
                                                          ),
                                                          SizedBox(
                                                            height: 2,
                                                          ),
                                                          Container(
                                                            width: w / 2.5,
                                                            child:  Text(
                                                              "\u{20B9}$Price",
                                                              overflow:
                                                              TextOverflow.ellipsis,
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                  FontWeight.bold),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),


                                                          Container(
                                                            width: w / 2,
                                                            child: Text(
                                                              description,
                                                              overflow:
                                                              TextOverflow.ellipsis,
                                                              maxLines:
                                                              isExpandedList[index]
                                                                  ? null
                                                                  : 2,
                                                              style: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: 12
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // SizedBox(width: 10,),
                                                    Container(
                                                      height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          16 /
                                                          100,
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          36 /
                                                          100,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  imageUrl),
                                                              fit: BoxFit.fill)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )),
                                  Positioned(
                                    top: 110,
                                    left: 214,
                                    child: InkWell(
                                      onTap: () {
                                        selectedProduct = ProductDetails(name, double.parse(Price));
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => DateShow()));
                                      },
                                      child: Container(
                                        height: h * 0.05,
                                        width: w * 0.28,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.2),
                                              blurRadius: 10,
                                              spreadRadius: 2,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: const Center(
                                            child: Text(
                                              "Add To Cart ",
                                              style: TextStyle(
                                                  color: kPrimaryColor,
                                                  fontSize: 13,
                                                  // fontSize isPortrait ? 16 : 20,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                      ),
                                    ),
                                  ),
                                ]));
                          }),
            
                    ],
                  ),
            
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
