// import 'package:flutter/material.dart';

// class CarSearchPage extends StatefulWidget {
//   @override
//   _CarSearchPageState createState() => _CarSearchPageState();
// }

// class _CarSearchPageState extends State<CarSearchPage> {
//   List<Map<String, String>> companies = [
//     {'name': 'BMW', 'logo': 'Images/image_car_Company/bmw.png'},
//     {'name': 'Mazda', 'logo': 'https://via.placeholder.com/100?text=Mazda'},
//     {'name': 'Audi', 'logo': 'https://via.placeholder.com/100?text=Audi'},
//     {
//       'name': 'Mercedes',
//       'logo': 'https://via.placeholder.com/100?text=Mercedes'
//     },
//     // إضافة المزيد من الشركات هنا...
//   ];

//   // List<String> carNames = ['BMW X5', 'Mazda CX-5', 'Audi Q7', 'Mercedes GLC'];
//   // List<String> filteredCars = [];
//   // String selectedCompany = 'All';
//   // String searchQuery = '';

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   filteredCars = carNames;
//   // }

//   // // فلترة السيارات حسب اسم الشركة
//   // void filterCars(String company) {
//   //   setState(() {
//   //     selectedCompany = company;
//   //     if (company == 'All') {
//   //       filteredCars = carNames;
//   //     } else {
//   //       filteredCars = carNames.where((car) => car.contains(company)).toList();
//   //     }
//   //   });
//   // }

//   // // البحث داخل السيارات
//   // void searchCars(String query) {
//   //   setState(() {
//   //     searchQuery = query;
//   //     if (selectedCompany == 'All') {
//   //       filteredCars = carNames
//   //           .where((car) => car.toLowerCase().contains(query.toLowerCase()))
//   //           .toList();
//   //     } else {
//   //       filteredCars = carNames
//   //           .where((car) =>
//   //               car.contains(selectedCompany) &&
//   //               car.toLowerCase().contains(query.toLowerCase()))
//   //           .toList();
//   //     }
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("بحث عن سيارات",
//             style: TextStyle(fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // شريط البحث
//             TextField(
//               onChanged: searchCars,
//               decoration: InputDecoration(
//                 hintText: 'ابحث عن سيارات...',
//                 hintStyle: const TextStyle(color: Colors.grey),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),

//             // عرض الشعارات والشركات
//             SizedBox(
//               height: 150,
//               child: GridView.builder(
//                 scrollDirection: Axis.horizontal,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 1,
//                   mainAxisSpacing: 16,
//                   childAspectRatio: 1,
//                 ),
//                 itemCount: companies.length + 1,
//                 itemBuilder: (context, index) {
//                   if (index == companies.length) {
//                     return GestureDetector(
//                       onTap: () => filterCars('All'),
//                       child: const Column(
//                         children: [
//                           Icon(Icons.all_inbox,
//                               size: 60, color: Colors.blueAccent),
//                           Text('الكل', style: TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                     );
//                   } else {
//                     final company = companies[index];
//                     return GestureDetector(
//                       onTap: () => filterCars(company['name']!),
//                       child: Column(
//                         children: [
//                           ClipOval(
//                             child: Image.network(
//                               company['logo']!,
//                               width: 60,
//                               height: 60,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           Text(company['name']!,
//                               style: const TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ),
//             const SizedBox(height: 16),

//             // عرض السيارات بعد الفلترة والبحث
//             Expanded(
//               child: ListView.builder(
//                 itemCount: filteredCars.length,
//                 itemBuilder: (context, index) {
//                   return CarCard(carName: filteredCars[index]);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ويدجت لعرض سيارة
// class CarCard extends StatelessWidget {
//   final String carName;

//   const CarCard({super.key, required this.carName});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 8,
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: ListTile(
//         contentPadding: const EdgeInsets.all(16),
//         leading: ClipOval(
//           child: Image.network(
//             'https://via.placeholder.com/100',
//             width: 60,
//             height: 60,
//             fit: BoxFit.cover,
//           ),
//         ),
//         title: Text(carName,
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         subtitle:
//             const Text("تفاصيل السيارة هنا", style: TextStyle(color: Colors.grey)),
//         trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
//       ),
//     );
//   }
// }
