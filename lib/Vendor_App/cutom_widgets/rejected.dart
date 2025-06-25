import 'package:flutter/material.dart';

class RejectedWidget extends StatefulWidget {
  const RejectedWidget({super.key});

  @override
  State<RejectedWidget> createState() => _RejectedWidgetState();
}

class _RejectedWidgetState extends State<RejectedWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          // final order = orders[index];
          // final productList =
          //     order['products'] as List<dynamic>;

          return Card(
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Order Number:11',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text('GHS 237',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Date 29-02-24'),
                      SizedBox(
                          height: 40,
                          child:
                              Image.asset("assets/image/rejectedorders.png")),
                    ],
                  ),
                  // const Text('Product List: '),
                  // const SizedBox(height: 8.0),
                  Column(children: [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('product_name',
                                style: const TextStyle(color: Colors.black)),
                          ),
                          Expanded(
                            child: Text('variants',
                                style: const TextStyle(color: Colors.black)),
                          ),
                        ],
                      ),
                    )
                  ]),
                  const SizedBox(height: 10.0),
                ],
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
