// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:refreshed/refreshed.dart';
// import 'package:sealed_countries/sealed_countries.dart';

// class CountryCode {
//   final String name;
//   final String nativeName;
//   final String code;

//   CountryCode({
//     required this.name,
//     required this.nativeName,
//     required this.code,
//   });

//   factory CountryCode.fromCountry(Country country) {
//     return CountryCode(
//       name: country.name.toString().tr,
//       nativeName: country.nativeName ?? country.name.toString(),
//       code: country.calling.toString(),
//     );
//   }
// }

// class CountryCodeSheet extends StatelessWidget {
//   const CountryCodeSheet({super.key});

//   static final List<CountryCode> countryCodes = Country.list
//       .where((country) => country.calling != null)
//       .map((country) => CountryCode.fromCountry(country))
//       .toList()
//     ..sort((a, b) => a.name.compareTo(b.name));

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.7,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(10),
//           topRight: Radius.circular(10),
//         ),
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             child: Text(
//               'selectCountryCode'.tr,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: countryCodes.length,
//               itemBuilder: (context, index) {
//                 final country = countryCodes[index];
//                 return ListTile(
//                   title: Text(
//                       '${country.name}-${country.nativeName}：${country.code}'),
//                   onTap: () {
//                     Get.back(result: country);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
