import 'package:damdleaders_flutter/features/Home/Screens/AddScreen.dart';
import 'package:flutter/material.dart';

import '../features/Home/Screens/ProfileScreen.dart';
import '../features/Home/Screens/videoScreen.dart';

List pages = [
  VideoScreen(),
  const ProfileScreen(uid: "eee"),
  AddScreen(),
  const Text('Messages Screen'),
  const ProfileScreen(uid: 'dddd'),
];

// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;


