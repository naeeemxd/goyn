// import 'package:flutter/material.dart';
// import 'package:goyn/customwidgets.dart/Custom_Widgets.dart';
// import 'package:goyn/provider/ImageProvider.dart';
// import 'package:provider/provider.dart';

// class ProfilePhotoScreen extends StatelessWidget {
//   const ProfilePhotoScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final profilePhotoProvider = Provider.of<ProfilePhotoProvider>(context);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: CustomAppBar(title: 'Profile Photo'),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const SizedBox(height: 30),
//             const Text(
//               'Upload a good quality photo of yourself.',
//               style: TextStyle(color: Colors.black87, fontSize: 14),
//             ),
//             GestureDetector(
//               onTap:
//                   () => profilePhotoProvider.pickImage(), // Open image picker
//               child: Container(
//                 height: screenHeight / 2,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   image:
//                       profilePhotoProvider.selectedImage != null
//                           ? DecorationImage(
//                             image: FileImage(
//                               profilePhotoProvider.selectedImage!,
//                             ),
//                             fit: BoxFit.cover,
//                           )
//                           : const DecorationImage(
//                             image: AssetImage(
//                               "assets/images/profilePageLogo.png",
//                             ),
//                             fit: BoxFit.contain,
//                           ),
//                 ),
//                 alignment: Alignment.center,
//                 child:
//                     profilePhotoProvider.selectedImage == null
//                         ? const Text(
//                           '',
//                           style: TextStyle(color: Colors.white, fontSize: 16),
//                         )
//                         : null,
//               ),
//             ),
//             Spacer(),
//             CustomButton(
//               title: 'Save',
//               onTap: () {
//                 // Handle save logic here
//                 final selectedImage = profilePhotoProvider.selectedImage;
//                 if (selectedImage != null) {
//                   print("Image saved: ${selectedImage.path}");
//                 } else {
//                   print("No image selected");
//                 }
//               },
//             ),
//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }
// }
