import 'package:flutter/material.dart';

import '../uiltis/color.dart';

class Button_widget extends StatefulWidget {
  final String buttontext;
  final void Function()? onpressed;
  final button_height;
  final button_weight;

  const Button_widget(
      {super.key,
      required this.buttontext,
      this.onpressed,
      this.button_height,
      this.button_weight});

  @override
  State<Button_widget> createState() => _Button_widgetState();
}

class _Button_widgetState extends State<Button_widget> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
      width: w / widget.button_weight,
      height: h / widget.button_height,
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
              backgroundColor: MaterialStateProperty.all(colors.button_color)),
          onPressed: widget.onpressed
          // (){Get.to(Home());}
          ,
          child: Text(
            widget.buttontext,
            style: TextStyle(color: Colors.white, fontSize: 15),
          )),
    );
  }
}
