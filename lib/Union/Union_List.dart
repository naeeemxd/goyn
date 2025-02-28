import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goyn/Driver/Driver_List.dart';
import 'package:goyn/Union/Union_Registration.dart';
import 'package:goyn/provider/Union_Provider.dart';
import 'package:provider/provider.dart';

class GoynHomePageContent extends StatelessWidget {
  const GoynHomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingButton(context),
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _buildSearchBar(context),
              const SizedBox(height: 16),
              _buildStatsRow(),
              const SizedBox(height: 16),
              _buildUnionList(),
            ],
          ),
        ),
      ),
    );
  }

  // Floating action button
  Widget _buildFloatingButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed:
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UnionRegistration()),
          ),
      backgroundColor: const Color(0xFFF0AC00),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      label: const Row(
        children: [
          Text("Add Union ", style: _buttonTextStyle),
          SizedBox(width: 5),
          Icon(Icons.add, color: Colors.white, size: 18),
        ],
      ),
    );
  }

  // AppBar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Image.asset("assets/images/logo.png", width: 120, height: 40),
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: GestureDetector(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DriverList()),
                ),
            child: const _ProfileIcon(),
          ),
        ),
      ],
    );
  }

  // Search Bar
  Widget _buildSearchBar(BuildContext context) {
    return Consumer<UnionProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: TextField(
            onChanged: provider.search,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              filled: true,
              fillColor: const Color(0xffF5F5F5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              hintText: "Search Union",
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
      },
    );
  }

  // Stats row
  Widget _buildStatsRow() {
    return Consumer<UnionProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Row(
            children: [
              const Text("Number of Unions ", style: _statTextStyle),
              _buildStatNumber(provider.unionCount),
              const SizedBox(width: 5),
              Image.asset("assets/icons/divider.png"),
              const SizedBox(width: 6),
              const Text("Number of Drivers ", style: _statTextStyle),
              _buildStatNumber(provider.totalDrivers),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatNumber(int number) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        "$number",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.purple,
        ),
      ),
    );
  }

  // Union list
  Widget _buildUnionList() {
    return Expanded(
      child: Consumer<UnionProvider>(
        builder: (context, provider, child) {
          if (provider.unions.isEmpty) {
            return const Center(
              child: Text(
                'No unions found',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: provider.unions.length,
            itemBuilder: (context, index) {
              final union = provider.unions[index];
              return UnionListItem(
                name: union.name,
                drivers: union.drivers.toString(),
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DriverList()),
                    ),
              );
            },
          );
        },
      ),
    );
  }
}

// Reusable Profile Icon Widget
class _ProfileIcon extends StatelessWidget {
  const _ProfileIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: const BoxDecoration(
        color: Color(0xFFF0AC00),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: SvgPicture.asset(
          "assets/icons/user.svg",
          width: 25,
          height: 25,
          fit: BoxFit.none,
        ),
      ),
    );
  }
}

// Union List Item
class UnionListItem extends StatelessWidget {
  final String name;
  final String drivers;
  final VoidCallback? onTap;

  const UnionListItem({
    Key? key,
    required this.name,
    required this.drivers,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 71,
          decoration: _boxDecoration.copyWith(color: Colors.white),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            leading: _buildLeadingIcon(),
            title: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text("Number of drivers $drivers", style: _subtitleStyle),
            trailing: const Icon(Icons.chevron_right, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildLeadingIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: _boxDecoration.copyWith(color: const Color(0xFFF8F8F8)),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: SvgPicture.asset("assets/icons/user-group-03.svg"),
      ),
    );
  }
}

// Reusable Styles
const _buttonTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w900,
  fontSize: 16,
);

const _statTextStyle = TextStyle(fontWeight: FontWeight.w800, fontSize: 15);

const _subtitleStyle = TextStyle(fontSize: 12, color: Colors.grey);

final _boxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(15),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      spreadRadius: 0.5,
      blurRadius: 4, // Increased for a softer shadow effect
      offset: const Offset(0, 0), // Shadow applied on all sides
    ),
  ],
);
