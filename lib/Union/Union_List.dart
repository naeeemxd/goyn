import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goyn/Union/unionEdit.dart';
import 'package:goyn/provider/Union_Provider.dart';
import 'package:goyn/unnreg.dart';
import 'package:provider/provider.dart';
import 'package:goyn/Driver/Driver_List.dart';
import 'package:goyn/Union/Union_Registration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          // onTap:
          //     () => Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => DriverList()),
          //     ),
          child: const _ProfileIcon(),
        ),
      ),
    ],
  );
}

Widget _buildSearchBar(BuildContext context) {
  final searchProvider = Provider.of<SearchProvider>(context, listen: false);
  final TextEditingController controller = TextEditingController(
    text: searchProvider.searchQuery,
  );

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: TextField(
      controller: controller,
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
          child:
              searchProvider.searchQuery.isNotEmpty
                  ? GestureDetector(
                    onTap: () {
                      controller.clear();
                      searchProvider.clearSearch();
                    },
                    child: const Icon(Icons.close, size: 18),
                  )
                  : SvgPicture.asset("assets/icons/search.svg"),
        ),
      ),
      onChanged: (value) {
        searchProvider.setSearchQuery(value);
      },
    ),
  );
}

// Stats row - Fetch number of unions dynamically
Widget _buildStatsRow() {
  return Consumer<UnionProvider>(
    builder: (context, unionProvider, child) {
      return Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Row(
          children: [
            const Text("Number of Unions ", style: _statTextStyle),
            _buildStatNumber(unionProvider.unions.length),
            const SizedBox(width: 5),
            Image.asset("assets/icons/divider.png"),
            const SizedBox(width: 6),
            const Text("Number of Drivers ", style: _statTextStyle),
            _buildStatNumber(
              0,
            ), // Replace with actual driver count if available
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

// Union list with search functionality using provider
Widget _buildUnionList() {
  return Expanded(
    child: Consumer<UnionProvider>(
      builder: (context, unionProvider, child) {
        if (unionProvider.unions.isEmpty) {
          return const Center(
            child: Text(
              'No unions found',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          );
        }

        return Consumer<SearchProvider>(
          builder: (context, searchProvider, child) {
            final filteredUnions = unionProvider.searchUnions(
              searchProvider.searchQuery,
            );

            if (filteredUnions.isEmpty) {
              return const Center(
                child: Text(
                  'No matching unions found',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              );
            }
            return ListView.builder(
              itemCount: filteredUnions.length,
              itemBuilder: (context, index) {
                final union = filteredUnions[index];
                return UnionListItem(
                  name: union.unionName,
                  unionDocId: union.id,
                  drivers: '0',
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => DriverList(
                                union: union.unionName,
                                unionDocId: union.id,
                              ),
                        ),
                      ),
                );
              },
            );
          },
        );
      },
    ),
  );
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
  final String unionDocId;
  final VoidCallback? onTap;

  const UnionListItem({
    Key? key,
    required this.name,
    required this.drivers,
    required this.unionDocId,
    this.onTap,
  }) : super(key: key);

  static const _boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  static const _subtitleStyle = TextStyle(color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 71,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2), // Shadow color
                spreadRadius: .5, // Spread radius
                blurRadius: .5, // Blur radius
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                _buildLeadingIcon(),
                const SizedBox(width: 10), // Add some spacing
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text("Number of drivers $drivers", style: _subtitleStyle),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    navigateTo(context, UnionEdit(unionDocId: unionDocId));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 15,
                    ),
                  ),
                ),

                const Icon(Icons.chevron_right, color: Colors.black),
              ],
            ),
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
      blurRadius: 4,
      offset: const Offset(0, 0),
    ),
  ],
);
