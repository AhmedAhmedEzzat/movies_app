import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/color_pallete.dart';

class ProfileTopSection extends StatelessWidget {
  const ProfileTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: BoxDecoration(
          color: ColorPallete.greyColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage(AppAssets.avatar1),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "12",
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: ColorPallete.textWhiteColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text("Wish List",
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: ColorPallete.textWhiteColor,
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "10",
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: ColorPallete.textWhiteColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text("History",
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: ColorPallete.textWhiteColor,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Ahmed Ezzat',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: ColorPallete.textWhiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      onTap: () {
                        Navigator.pushNamed(context, '/edite_profile');
                      },
                      child: Text(
                        'Edit Profile',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: ColorPallete.textBlackColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                   child: CustomButton(
                     borderColor: Colors.red,
                   backgroundColor: Colors.red,
                     onTap: () {},
                     child:   Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children:[
                         Text(
                         'Exit',
                         style: theme.textTheme.titleLarge?.copyWith(
                           fontWeight: FontWeight.w400,
                           fontSize: 20,
                           color: ColorPallete.textWhiteColor,
                         ),
                       ),
                         const SizedBox(width: 4),
                         Icon(Icons.logout,color: ColorPallete.textWhiteColor,)
                       ]
                     ),
                   ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            const TabBar(
              indicatorColor: ColorPallete.primaryColor,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: ColorPallete.primaryColor,
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.list,size: 30,),
                  text: "Wish List",
                ),
                Tab(
                  icon: Icon(Icons.folder,size: 30,),
                  text: "History",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
