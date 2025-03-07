// import 'package:flutter/material.dart';
// import 'package:goyn/Driver/Driver_Edit.dart';
// import 'package:goyn/Driver/driverProfilePhoto.dart';
// import 'package:goyn/Driver/widgetProfile.dart';
// import 'package:goyn/customwidgets.dart/Custom_Widgets.dart';
// import 'package:goyn/provider/ImageProvider.dart';

// class DriverDetailsPage extends StatelessWidget {
//   const DriverDetailsPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: "Driver Details"),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildInfoSection('Name', 'Muhammmed Junaid C'),
//               const SizedBox(height: 16),
//               _buildInfoSection('Mobile Number', '9876543210'),
//               const SizedBox(height: 16),
//               _buildInfoSection(
//                 'Address',
//                 'Chatholli (H), Vengara, Urakam,\nMalappuram, Kerala 676519',
//               ),
//               const SizedBox(height: 16),
//               _buildInfoSection('Union', 'Malappuram'),
//               const SizedBox(height: 16),

//               // Document sections with chevron
//               _buildDocumentSection(
//                 'Bank passbook/Cheque',
//                 onTap:
//                     () => navigateTo(
//                       context,
//                       DriverProfileWidget<BankProvider>(
//                         documentName: 'Bank Passbook/Check',
//                       ),
//                     ),
//               ),
//               _buildDocumentSection(
//                 'Police clearance certificate/Judgement copy',
//                 onTap:
//                     () => navigateTo(
//                       context,
//                       DriverProfileWidget<PoliceProvider>(
//                         documentName: 'Police Clearance/Judgment',
//                         fieldName: 'Enter your Police Clearance',
//                       ),
//                     ),
//               ),
//               _buildDocumentSection(
//                 'Aadhaar card',
//                 onTap:
//                     () => navigateTo(
//                       context,
//                       DriverProfileWidget<AdharProvider>(
//                         documentName: 'Adhaar',
//                       ),
//                     ),
//               ),
//               _buildDocumentSection(
//                 'Pan card',
//                 onTap:
//                     () => navigateTo(
//                       context,
//                       DriverProfileWidget<PanProvider>(documentName: 'Pan'),
//                     ),
//               ),
//               // _buildDocumentSection(
//               //   'Profile photo',
//               //   onTap: () => navigateTo(context, ProfilePhotoScreen()),
//               // ),

//               // Vehicle Details section
//               const Padding(
//                 padding: EdgeInsets.only(left: 12.0, top: 26),
//                 child: Text(
//                   'Vehicle Details',
//                   style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),

//               // Vehicle document sections
//               _buildDocumentSection(
//                 'Registration Certificate',
//                 onTap:
//                     () => navigateTo(
//                       context,
//                       DriverProfileWidget<RegistrationnProvider>(
//                         documentName: 'Registration Certificate',
//                       ),
//                     ),
//               ),
//               _buildDocumentSection(
//                 'Vehicle Insurance',
//                 onTap:
//                     () => navigateTo(
//                       context,
//                       DriverProfileWidget<InsuranceProvider>(
//                         documentName: 'Vehicle Insurance',
//                       ),
//                     ),
//               ),
//               _buildDocumentSection(
//                 'Cirtificate of Fitness',
//                 onTap:
//                     () => navigateTo(
//                       context,
//                       DriverProfileWidget<FitnessProvider>(
//                         documentName: 'Cirtificate of Fitness',
//                       ),
//                     ),
//               ),
//               _buildDocumentSection(
//                 'Vehicle Permit',
//                 onTap:
//                     () => navigateTo(
//                       context,
//                       DriverProfileWidget<VehicleProvider>(
//                         documentName: 'Vehicle Permit',
//                       ),
//                     ),
//               ),

//               // Bottom action buttons
//               Padding(
//                 padding: const EdgeInsets.only(top: 24.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: SizedBox(
//                         height: 50,
//                         child: OutlinedButton(
//                           onPressed: () {
//                             showDeleteConfirmationDialog(context);
//                           },
//                           style: OutlinedButton.styleFrom(
//                             foregroundColor: Colors.red,
//                             side: const BorderSide(color: Colors.grey),
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                           ),
//                           child: const Text(
//                             'Delete',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w800,
//                               color: Colors.red,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: SizedBox(
//                         height: 50,
//                         // child: CustomButton(
//                         //   title: 'Edit',
//                         //   onTap: () => navigateTo(context, DriverEdit()),
//                         // ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoSection(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 10.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
//           const SizedBox(height: 4),
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 16,
//               color: Colors.black,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDocumentSection(String title, {VoidCallback? onTap}) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10.0),
//       child: GestureDetector(
//         onTap: onTap, // onTap is now optional
//         child: Container(
//           height: 50,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(15),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2), // Slightly stronger shadow
//                 spreadRadius: 1, // Soft spread
//                 blurRadius: 4, // More visible blur
//                 offset: const Offset(1, 1), // Slightly offset shadow
//               ),
//             ],
//           ),
//           alignment: Alignment.centerLeft, // Centers the text
//           child: Padding(
//             padding: const EdgeInsets.only(left: 10.0),
//             child: Row(
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.black,
//                     fontWeight: FontWeight.w500, // Slightly bold text
//                   ),
//                 ),
//                 const Spacer(),
//                 const Padding(
//                   padding: EdgeInsets.only(right: 10.0),
//                   child: Icon(Icons.chevron_right),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
