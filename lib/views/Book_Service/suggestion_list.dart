
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hire_any_thing/data/getx_controller/user_side/city_fetch_controller.dart';
// import 'package:hire_any_thing/data/models/user_side_model/place_model.dart';

// class SuggestionList extends StatefulWidget {
//   final bool isFromField;
//   final bool showSuggestions;
//   final Function(PlaceSuggestion) onSuggestionSelected;

//   const SuggestionList({
//     super.key,
//     required this.isFromField,
//     required this.showSuggestions,
//     required this.onSuggestionSelected,
//   });

//   @override
//   State<SuggestionList> createState() => _SuggestionListState();
// }

// class _SuggestionListState extends State<SuggestionList> {
//   @override
//   Widget build(BuildContext context) {
//     final viewModel = Get.put(CityFetchController());
//     if (!widget.showSuggestions) return const SizedBox.shrink();

//     return Container(
//       constraints: const BoxConstraints(maxHeight: 200),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: Colors.grey[300]!),
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(0, 2))],
//       ),
//       child: Obx(() => viewModel.isLoadingSuggestions.value
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               shrinkWrap: true,
//               itemCount: viewModel.placeSuggestions.length,
//               itemBuilder: (context, index) {
//                 final suggestion = viewModel.placeSuggestions[index];
//                 return ListTile(
//                   title: Text(suggestion.description),
//                   onTap: () => widget.onSuggestionSelected(suggestion),
//                 );
//               },
//             )),
//     );
//   }
// }