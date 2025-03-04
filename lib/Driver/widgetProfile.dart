import 'package:flutter/material.dart';
import 'package:goyn/customwidgets.dart/Custom_Widgets.dart';
import 'package:provider/provider.dart';

class DriverProfileWidget<T> extends StatelessWidget {
  final String documentName;
  final String? fieldName;

  const DriverProfileWidget({
    Key? key,
    required this.documentName,
    this.fieldName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final TextEditingController _docController = TextEditingController();
    final provider = Provider.of<T>(context);
    final String displayFieldName = fieldName ?? documentName;

    return Scaffold(
      appBar: CustomAppBar(title: '$documentName Card'),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Let's find your $documentName card",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Enter your $documentName and we\'ll get your information from GOYN. By sharing your $documentName details, you confirm that you have shared such details voluntarily.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (provider is dynamic && provider.pickImage != null) {
                          provider.pickImage();
                        }
                      },
                      child: Container(
                        height: screenHeight / 2 - 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image:
                              provider is dynamic &&
                                      provider.selectedImage != null
                                  ? DecorationImage(
                                    image: FileImage(provider.selectedImage!),
                                    fit: BoxFit.fitWidth,
                                  )
                                  : const DecorationImage(
                                    image: AssetImage(
                                      "assets/images/Untitled design.png",
                                    ),
                                    fit: BoxFit.fitWidth,
                                  ),
                        ),
                        alignment: Alignment.center,
                        child:
                            provider is dynamic &&
                                    provider.selectedImage == null
                                ? Padding(
                                  padding: const EdgeInsets.only(top: 100.0),
                                  child: Text(
                                    'Add $documentName Photo',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                )
                                : null,
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      label: 'Enter your $displayFieldName ',
                      controller: _docController,
                    ),
                    const SizedBox(height: 24),
                    CustomButton(title: 'Save', onTap: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}