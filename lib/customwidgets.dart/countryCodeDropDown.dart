import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goyn/provider/Login_Provider.dart';
import 'package:provider/provider.dart';
// Import your provider

class CountryCodeDropdown extends StatelessWidget {
  final Map<String, String> countryCodes;

  const CountryCodeDropdown({Key? key, required this.countryCodes})
    : super(key: key);

  void _showFullScreenDialog(
    BuildContext context,
    CountryCodeProvider provider,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Consumer<CountryCodeProvider>(
              builder: (context, countryProvider, child) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Select Country",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: countryProvider.searchController,
                        decoration: InputDecoration(
                          hintText: 'Search country',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                        ),
                        onChanged: countryProvider.onSearchChanged,
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount:
                              countryProvider.filteredCountryCodes.length,
                          itemBuilder: (context, index) {
                            String countryName = countryProvider
                                .filteredCountryCodes
                                .keys
                                .elementAt(index);
                            String countryCode = countryProvider
                                .filteredCountryCodes
                                .values
                                .elementAt(index);
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              onTap: () {
                                countryProvider.selectCountry(
                                  countryName,
                                  countryCode,
                                );
                                Navigator.pop(context);
                              },
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      countryName,
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    countryCode,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                              shape: Border(
                                bottom: BorderSide(
                                  color: Colors.grey[200]!,
                                  width: 1,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    ).then((_) {
      // When the modal is closed, update the isDropdownOpen
      provider.closeDropdown();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the existing provider instance
    final provider = Provider.of<CountryCodeProvider>(context, listen: true);

    return GestureDetector(
      onTap: () {
        provider.toggleDropdown();
        if (provider.isDropdownOpen) {
          _showFullScreenDialog(context, provider);
        }
      },
      child: Container(
        height: 49,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              provider.selectedCountryCode, // This should now update properly
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
