import 'package:flutter/material.dart';
import 'package:movies_app/modules/layout/widgets/profile_top_section.dart';


class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            ProfileTopSection(),



          ],
        ),
      ),
    );
  }
}
