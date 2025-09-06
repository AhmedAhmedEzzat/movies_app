import 'package:flutter/material.dart';
import 'package:movies_app/modules/layout/pages/browse_view.dart';
import 'package:movies_app/modules/layout/pages/home_view.dart';
import 'package:movies_app/modules/layout/pages/profile_view.dart';
import 'package:movies_app/modules/layout/pages/search_view.dart';
abstract class Constants {
  static List<Widget> screens = [HomeView(), SearchView(), BrowseView(), ProfileView()];
}
