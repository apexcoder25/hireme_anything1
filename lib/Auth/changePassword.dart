import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 100 / 100,
        width: MediaQuery.of(context).size.width * 100 / 100,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 50 / 100,
              width: MediaQuery.of(context).size.width * 90 / 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white)),
              child: Column(
                children: [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
