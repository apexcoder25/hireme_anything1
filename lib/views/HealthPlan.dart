import 'package:flutter/material.dart';
class HealthPlan extends StatefulWidget {
  const HealthPlan({super.key});

  @override
  State<HealthPlan> createState() => _HealthPlanState();
}

class _HealthPlanState extends State<HealthPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enquiry"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.asset("assets/icons/empty-box.png",height: 80,width: 100,)),
            SizedBox(
              height: 12,
            ),
            Text(
              "No Enquiries Yet",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "You haven't made any enquiries yet. Start exploring our services and send us your questions or requests whenever you're ready!",
              // overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 3,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
