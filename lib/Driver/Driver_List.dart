import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goyn/Driver/Driver_Details.dart';
import 'package:goyn/Driver/Driver_Registration.dart';
import 'package:goyn/customwidgets.dart/Custom_Widgets.dart';
import 'package:goyn/provider/DriverlistProvider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class DriverList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Union"),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          navigateTo(context, DriverRegistrationScreen());
        },
        backgroundColor: const Color(0xFFF0AC00),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        label: Row(
          children: const [
            Text(
              "Add Driver ",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 5),
            Icon(Icons.add, color: Colors.white, size: 18),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _LocationHeader(),
            SizedBox(height: 10),
            _SearchBar(),
            SizedBox(height: 15),
            Expanded(child: _DriversList()), // 🛠 Ensures scrolling works
          ],
        ),
      ),
    );
  }
}

// Custom Widget for Location Header
class _LocationHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 39,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Malappuram',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Number of drivers 39',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Custom Widget for Search Bar
class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final driverProvider = Provider.of<DriverlistProvider>(context);

    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffF5F5F5),
      ),
      child: TextField(
        onChanged: (value) => driverProvider.setSearchQuery(value),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          filled: true,
          fillColor: const Color(0xffF5F5F5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: "Search driver",
          hintStyle: GoogleFonts.openSans(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset("assets/icons/search.svg"),
          ),
        ),
      ),
    );
  }
}

// Custom Widget for Drivers List
class _DriversList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final driverProvider = Provider.of<DriverlistProvider>(context);
    final filteredDrivers = driverProvider.filteredDrivers;

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: filteredDrivers.length,
      itemBuilder: (context, index) {
        final driver = filteredDrivers[index];
        return GestureDetector(
          onTap: () => navigateTo(context, DriverDetailsPage()),
          child: DriverCard(driver: driver),
        );
      },
    );
  }
}

// Custom Widget for Driver Card
class DriverCard extends StatelessWidget {
  final Driver driver;

  const DriverCard({required this.driver});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 0.1, spreadRadius: 0.1),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50, // Set a width for consistency
            height: 50, // Set a height for consistency
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(driver.imageUrl),
                fit: BoxFit.cover, // Ensures image fills the container
              ),
            ),
            clipBehavior: Clip.hardEdge, // Prevents image overflow
          ),
          SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driver.name,
                    style: GoogleFonts.openSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis, // Prevents text overflow
                    maxLines: 1,
                  ),
                  Text(
                    driver.phone,
                    style: GoogleFonts.openSans(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Image.asset(
                  "assets/icons/Frame 1597882545.png",
                  height: 35, // Reduced size for better alignment
                  width: 35,
                ),
                onPressed: () {},
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              SizedBox(width: 8), // Added spacing
              IconButton(
                icon: Image.asset(
                  "assets/icons/phone_Icon.png",
                  height: 35,
                  width: 35,
                ),
                onPressed: () {},
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
