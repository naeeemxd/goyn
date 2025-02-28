import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPress;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onBackPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: AppBar(
          backgroundColor: const Color(0x08000000),
          surfaceTintColor: Colors.transparent,
          elevation: 1,
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: SvgPicture.asset("assets/icons/back_arrow.svg"),
            onPressed: onBackPress ?? () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
