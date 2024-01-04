import 'package:flutter/material.dart';

void navigation(BuildContext context, String routerName) {
  Navigator.of(context).pushNamed(routerName);
}
