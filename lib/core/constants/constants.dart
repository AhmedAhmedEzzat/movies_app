import 'package:flutter/material.dart';
import 'package:movies_app/modules/layout/pages/browse/browse_view.dart';
import 'package:movies_app/modules/layout/pages/home/home_view.dart';
import 'package:movies_app/modules/layout/pages/edite_profile/profile_view.dart';
import 'package:movies_app/modules/layout/pages/search/search_view.dart';
abstract class Constants {
  static List<Widget> screens = [HomeView(), SearchView(), BrowseView(), ProfileView()];
}
