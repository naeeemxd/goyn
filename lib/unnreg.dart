// onTap: () {
//   if (index == 3) {
//     // Navigate to a different screen for Pan Card
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PanCardScreen(), // Replace with your actual screen
//       ),
//     );
//   } else {
//     // Default navigation for other items
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PhotoUploadScreen(
//           title: [
//             "Bank passbook/Cheque",
//             "Police clearance certificate/Judgement copy",
//             "Aadhaar card",
//             "Pan card",
//             '',
//             "Registration Certificate",
//             "vehicle Insurance",
//             "Certificate of fitness",
//             "Vehicle permit",
//           ][index],
//           detaileNumber: [0, 1, 2, 3, 0, 5, 6, 7, 8][index],
//           completed: [
//             registrationProvider.bankPassBookProccessCompleted,
//             registrationProvider.policeClearenceCertificateOrJudgementCopyProcessCompleted,
//             registrationProvider.aadhaarCardProcessCompleted,
//             registrationProvider.panCardProcessCompleted,
//             // Blank
//             false,
//             //
//             registrationProvider.registrationCertificatedProccessCompleted,
//             registrationProvider.vehicleInsuranceProccessCompleted,
//             registrationProvider.certificateOfFitnessProccessCompleted,
//             registrationProvider.vehiclePermitProccessCompleted,
//           ][index],
//         ),
//       ),
//     );
//   }
// },
