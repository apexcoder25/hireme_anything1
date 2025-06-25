
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/getx_controller/vender_side/vender_side_getx_controller.dart';

class CommonForAboutUsTermsPrivacyContactAountUsList extends StatefulWidget {
  const CommonForAboutUsTermsPrivacyContactAountUsList({super.key});

  @override
  State<CommonForAboutUsTermsPrivacyContactAountUsList> createState() => _CommonForAboutUsTermsPrivacyContactAountUsListState();
}

class _CommonForAboutUsTermsPrivacyContactAountUsListState extends State<CommonForAboutUsTermsPrivacyContactAountUsList> {
  @override
  Widget build(BuildContext context) {
    final VenderSidetGetXController venderSidetGetXController = Get.put(VenderSidetGetXController());

    return Scaffold(
      appBar: AppBar(
        title: Text("${venderSidetGetXController.getCommonForTermsPrivacyContactUsAndAboutUs.title}"),
      ),
      body: Padding(
          padding:EdgeInsets.all(8.0),
          child: Text("${venderSidetGetXController.getCommonForTermsPrivacyContactUsAndAboutUs.description}")),
    );
  }
}
