import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/color_pallete.dart';
import '../../../core/widgets/avatar_picker.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class RegisterView extends StatefulWidget {
  static const String routeName = '/register_view';

  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  int selectedLanguage = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AvatarCarousel(
                avatars: [
                  AppAssets.avatar1,
                  AppAssets.avatar2,
                  AppAssets.avatar3,
                  AppAssets.avatar4,
                  AppAssets.avatar5,
                  AppAssets.avatar6,
                  AppAssets.avatar7,
                  AppAssets.avatar8,
                  AppAssets.avatar9,
                ],
                onSelected: (avatar) {},
              ),

              SizedBox(height: 14),
              CustomTextFormField(
                hintText: 'Name',
                prefixIcon: Image.asset(
                  AppAssets.nameIcon,
                  color: ColorPallete.textWhiteColor,
                ),
              ),
              SizedBox(height: 14),
              CustomTextFormField(
                hintText: 'Email',
                prefixIcon: Image.asset(
                  AppAssets.emailIcon,
                  color: ColorPallete.textWhiteColor,
                ),
              ),
              SizedBox(height: 14),
              CustomTextFormField(
                isPassword: true,
                hintText: 'Password',
                prefixIcon: Image.asset(
                  AppAssets.passwordIcon,
                  color: ColorPallete.textWhiteColor,
                ),
              ),
              SizedBox(height: 14),
              CustomTextFormField(
                isPassword: true,
                hintText: 'Confirm Password',
                prefixIcon: Image.asset(
                  AppAssets.passwordIcon,
                  color: ColorPallete.textWhiteColor,
                ),
              ),
              SizedBox(height: 14),
              CustomTextFormField(
                hintText: 'Phone Number',
                prefixIcon: Image.asset(
                  AppAssets.phoneIcon,
                  color: ColorPallete.textWhiteColor,
                ),
              ),
              SizedBox(height: 14),
              CustomButton(
                child: Text(
                  'Create Account',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: ColorPallete.textBlackColor,
                  ),
                ),
                onTap: () {},
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSecondary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: ColorPallete.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14),
              Align(
                alignment: Alignment.center,
                child: AnimatedToggleSwitch<int>.rolling(
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value;
                    });
                  },

                  current: selectedLanguage,
                  values: [0, 1],
                  inactiveOpacity: 1,
                  iconOpacity: 1,
                  style: ToggleStyle(
                    backgroundColor: Colors.transparent,
                    indicatorColor: ColorPallete.primaryColor,
                    borderColor: ColorPallete.primaryColor,
                  ),
                  spacing: 30,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  iconList: [
                    Image.asset(AppAssets.englishFlag, height: 35, width: 35),
                    Image.asset(AppAssets.arabicFlag, height: 35, width: 35),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
