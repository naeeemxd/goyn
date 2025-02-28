import 'dart:io';
import 'package:flutter/material.dart';
import 'package:goyn/customwidgets.dart/country_codes.dart';
import 'package:image_picker/image_picker.dart';


class RegistrationProvider extends ChangeNotifier {
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Login Page Properties
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController(text: '+91');

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////
  final GlobalKey keyField = GlobalKey();
  late List<MapEntry<String, String>> filteredCountries;
  final LayerLink layerLink = LayerLink();
  OverlayEntry? overlayEntry;
  bool isDropdownOpen = false;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// initializing Filted Country Codes starting from the build
  void initializingFilterCountryCodes(countryCodes) {
    filteredCountries = countryCodes.entries.toList();
  }

// Country Code Filter Function in the contry Code in built List
  void filterCountriesCodes(String query, double screenHeight) {
    filteredCountries = countryCodes.entries.where((entry) => entry.key.toLowerCase().contains(query.toLowerCase()) || entry.value.contains(query)).toList();
    notifyListeners();
    closeDropdown();
    openDropdown(screenHeight);
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Country Code Drop Down Sheet Open and Closing Tongle Function. Working With is isDropDownOpen Boolean
  void toggleDropdown(double screenHeight) {
    if (isDropdownOpen) {
      closeDropdown();
    } else {
      openDropdown(screenHeight);
    }
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// opening Drop Down Sheet of Country Code in Login Page with Passing Screen Height,
  void openDropdown(double screenHeight) {
    final RenderBox renderBox = keyField.currentContext!.findRenderObject() as RenderBox;
    final double textFieldHeight = renderBox.size.height;
    final double textFieldTop = renderBox.localToGlobal(Offset.zero).dy;

    // Determine dropdown direction (above or below). DropDown height = 200
    bool showAbove = (textFieldTop + textFieldHeight + 200) > screenHeight;

    overlayEntry = createOverlayEntry(showAbove, textFieldHeight);
    Overlay.of(keyField.currentContext!).insert(overlayEntry!);
    isDropdownOpen = true;
    notifyListeners();
  }

  // Closing Drop Down Sheet of Country Code Closing  with Boolian false
  void closeDropdown() {
    overlayEntry?.remove();
    isDropdownOpen = false;
    notifyListeners();
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////
// The Drop Down sheet of Cotry Code selecting in Login Screen
  OverlayEntry createOverlayEntry(
    bool showAbove,
    double textFieldHeight,
  ) {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 100,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: showAbove ? Offset(0, -200 - 10) : Offset(0, textFieldHeight + 10),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              constraints: BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: filteredCountries.length,
                itemBuilder: (context, index) {
                  final entry = filteredCountries[index];
                  return ListTile(
                    title: Text(entry.value),
                    onTap: () {
                      countryCodeController.text = entry.value;
                      closeDropdown();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////////
  /// OTP Verification Page
  ///////////////////////////////////////////////////////////////////////////////////////

  FocusNode focusNodes = FocusNode();
  TextEditingController otpControllers = TextEditingController();

  ///////////////////////////////////////////////////////////////////////////////////////
  /// Driver Registration Screen
  ///////////////////////////////////////////////////////////////////////////////////////
  // Driver Personal Detailes
  TextEditingController driverNameController = TextEditingController();
  TextEditingController driverMobileNumberController = TextEditingController();
  TextEditingController driverAddressController = TextEditingController();
  TextEditingController driverEmailController = TextEditingController();
  // Are u a member of any union Yes or No Bool variable.
  // if the variable is true the value is Yes (Yes, a Member of a Union). otherwise (No, have't membership of any Unions)
  String isUnionMemberOfAnyOtherUnion = '';
  // Union Selecting Dropdown variable
  String selectedUnionName = "Select Union";

// Setiing user input of "Yes" or "No". Are u a Member of any union
  void setIsUnionMemberOfAnyOtherUnion(String value) {
    isUnionMemberOfAnyOtherUnion = value;
    notifyListeners();
  }

// Setiing user input of union Select from drop Down
  void setSelectedUnion(value) {
    selectedUnionName = value;
    notifyListeners();
  }

  bool isRegistrationProccessCompleted() {
    bool isCompleted = false;
    isCompleted = driverNameController.text != '' &&
        driverMobileNumberController.text != '' &&
        driverAddressController.text != '' &&
        driverEmailController.text != '' &&
        bankPassBookProccessCompleted &&
        policeClearenceCertificateOrJudgementCopyProcessCompleted &&
        aadhaarCardProcessCompleted &&
        panCardProcessCompleted &&
        registrationCertificatedProccessCompleted &&
        vehicleInsuranceProccessCompleted &&
        certificateOfFitnessProccessCompleted &&
        vehiclePermitProccessCompleted;
    // notifyListeners();
    return isCompleted;
  }

///////////////////////////////////////////////////////////////////////////////////////
  /// Upload Driver Details Screen
///////////////////////////////////////////////////////////////////////////////////////

// Driver Requirments Id Numbers
  TextEditingController bankPassBookOrCheckNumberController = TextEditingController();
  TextEditingController policeClearenceCertificateOrJudgementCopyController = TextEditingController();
  TextEditingController aadhaarCardController = TextEditingController();
  TextEditingController panCardController = TextEditingController();
// Vehicle Requirments Id Numbers
  TextEditingController registrationCertificateController = TextEditingController();
  TextEditingController vehicleInsuranceController = TextEditingController();
  TextEditingController certificateOfFitnessController = TextEditingController();
  TextEditingController vehiclePermitController = TextEditingController();
// Driver Requirments Images
  File? bankPassBookImage;
  File? policeClearenceCertificateOrJudgementCopyImage;
  File? aadhaarCardFronSideImage;
  File? aadhaarCardBackSideImage;
  File? panCardImage;
// Vehicle Requirements Images
  File? registrationCertificateImage;
  File? vehicleInsuranceImage;
  File? certificateOfFitnessImage;
  File? vehiclePermitImage;

// Driver Requirement Proccess is Completed
  bool bankPassBookProccessCompleted = false;
  bool policeClearenceCertificateOrJudgementCopyProcessCompleted = false;
  bool aadhaarCardProcessCompleted = false;
  bool panCardProcessCompleted = false;

// Vehicle Requirement Proccess is Completed
  bool registrationCertificatedProccessCompleted = false;
  bool vehicleInsuranceProccessCompleted = false;
  bool certificateOfFitnessProccessCompleted = false;
  bool vehiclePermitProccessCompleted = false;

// Driver and Requieements Image Picker
  final ImagePicker _picker = ImagePicker();
  Future<void> pickImage(ImageSource source, int detaileNumber) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      switch (detaileNumber) {
        case 0:
          bankPassBookImage = File(pickedFile.path);
          break;
        case 1:
          policeClearenceCertificateOrJudgementCopyImage = File(pickedFile.path);
          break;
        case 2:
          aadhaarCardFronSideImage = File(pickedFile.path);
          break;
        case 3:
          panCardImage = File(pickedFile.path);
        case 4:
          aadhaarCardBackSideImage = File(pickedFile.path);
          break;
        case 5:
          registrationCertificateImage = File(pickedFile.path);
          break;
        case 6:
          vehicleInsuranceImage = File(pickedFile.path);
          break;
        case 7:
          certificateOfFitnessImage = File(pickedFile.path);
          break;
        case 8:
          vehiclePermitImage = File(pickedFile.path);
          break;
        default:
      }
      notifyListeners();
    }
  }

  void setDataAddingProcessComplete(int detaileNumber, BuildContext context) async {
    switch (detaileNumber) {
      case 0:
        bankPassBookProccessCompleted = true;
        break;
      case 1:
        policeClearenceCertificateOrJudgementCopyProcessCompleted = true;
        break;
      case 2:
        aadhaarCardProcessCompleted = true;
        break;
      case 3:
        panCardProcessCompleted = true;
      case 4:
        aadhaarCardProcessCompleted = true;
        break;
      case 5:
        registrationCertificatedProccessCompleted = true;
        break;
      case 6:
        vehicleInsuranceProccessCompleted = true;
        break;
      case 7:
        certificateOfFitnessProccessCompleted = true;
        break;
      case 8:
        vehiclePermitProccessCompleted = true;
        break;
      default:
    }
    notifyListeners();
    Navigator.pop(context);
  }

///////////////////////////////////////////////////////////////////////////////////////
  /// Select Payment Method Screen
///////////////////////////////////////////////////////////////////////////////////////

  String isSelectedPaymentOption = "";

  void setSelectedPaymentoption(value) {
    isSelectedPaymentOption = value;
    notifyListeners();
  }
}
