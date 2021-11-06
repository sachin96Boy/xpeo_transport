import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1.0,
      color: Colors.black,
      thickness: 2.0,
      indent: 10.0,
      endIndent: 10.0,
    );
  }
}
