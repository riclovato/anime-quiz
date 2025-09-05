import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar(
  BuildContext context, {
  List<Widget>? actions,
}) {
  return AppBar(
    title: Center(child: Text('Anime Quiz')),
    backgroundColor: Colors.black,
  );
}