import 'package:flutter/material.dart';
class CarePlan extends StatefulWidget {
  const CarePlan({super.key});

  @override
  State<CarePlan> createState() => _CarePlanState();
}

class _CarePlanState extends State<CarePlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Care Plan"),
      ),
    );
  }
}
