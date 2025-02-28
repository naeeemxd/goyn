import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goyn/provider/Union_Provider.dart';
import 'package:provider/provider.dart';
import 'package:goyn/Driver_List.dart';
import 'package:goyn/Union_Registration.dart';

// Union model class

class GoynHomePage extends StatelessWidget {
  const GoynHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UnionProvider(),
      child: _GoynHomePageContent(),
    );
  }
}

class _GoynHomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final unionProvider = Provider.of<UnionProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UnionRegistration()),
          );
        },
        backgroundColor: const Color(0xFFF0AC00),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        label: Row(
          children: const [
            Text(
              "Add Union ",
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
      appBar: AppBar(
        title: Image.asset("assets/images/logo.png", width: 120, height: 40),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DriverList()),
                );
              },
              child: Container(
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
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Search bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  onChanged: (value) => unionProvider.search(value),
                  decoration: InputDecoration(
                    hintText: 'Search union',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon:
                        unionProvider.searchQuery.isEmpty
                            ? Padding(
                              padding: const EdgeInsets.only(
                                top: 5.0,
                                bottom: 5.0,
                                left: 15,
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/search.svg",
                                width: 32,
                                height: 32,
                                fit: BoxFit.contain,
                              ),
                            )
                            : IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                unionProvider.clearSearch();
                              },
                            ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Stats row
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Row(
                  children: [
                    const Text(
                      "Number of Unions ",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        "${unionProvider.unionCount}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Image.asset("assets/icons/divider.png"),
                    const SizedBox(width: 6),

                    const Text(
                      "Number of Drivers ",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        "${unionProvider.totalDrivers}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Union list
              Expanded(
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
                          onTap: () {
                            // Navigate to union details or driver list
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DriverList(),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Updated UnionListItem to include onTap
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
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0.5,
                blurRadius: 0.5,
                offset: const Offset(1, 1),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 15, right: 10),
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: SvgPicture.asset("assets/icons/user-group-03.svg"),
              ),
            ),
            title: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              "Number of drivers $drivers",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
