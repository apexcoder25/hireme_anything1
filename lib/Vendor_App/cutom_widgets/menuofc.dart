import 'package:hire_any_thing/Vendor_App/cutom_widgets/InProgress.dart';
import 'package:hire_any_thing/Vendor_App/cutom_widgets/cancel.dart';
import 'package:hire_any_thing/Vendor_App/cutom_widgets/completed.dart';
import 'package:hire_any_thing/Vendor_App/cutom_widgets/new_orders.dart';
import 'package:hire_any_thing/Vendor_App/cutom_widgets/rejected.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:flutter/material.dart';

class DashbordItem extends StatefulWidget {
  final String name;
  const DashbordItem({super.key, required this.name});

  @override
  State<DashbordItem> createState() => _DashbordItemState();
}

class _DashbordItemState extends State<DashbordItem> {
  @override
  Widget build(BuildContext context) {
    print(widget.name);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: colors.white,
          ),
        ),
        backgroundColor: colors.button_color,
        centerTitle: true,
        title: Text(
          widget.name,
          style: TextStyle(color: colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: widget.name == 'New Order'
          ? NewOrderWidget()
          : widget.name == 'In Progress'
              ? InProgressWidget()
              : widget.name == 'Completed'
                  ? CompletedWidget()
                  : widget.name == 'Rejected'
                      ? RejectedWidget()
                      : widget.name == 'Cancel'
                          ? CancelWidget()
                          : null,
    );
  }
}
