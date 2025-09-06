import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/custom_button.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/color_pallete.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class LoginView extends StatefulWidget {
  static const String routeName = '/login';

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  int selectedLanguage = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: ColorPallete.backgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(AppAssets.appLogoIcon, height: MediaQuery.of(context).size.height*0.12),
                const SizedBox(height: 50),
                CustomTextFormField(
                  hintText: 'Email',
                  prefixIcon: Image.asset(AppAssets.emailIcon,color: ColorPallete.textWhiteColor),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  isPassword: true,
                  hintText: 'Password',
                  prefixIcon: Image.asset(AppAssets.passwordIcon,color: ColorPallete.textWhiteColor),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forget_password');
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: ColorPallete.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                CustomButton(
                  child: Text('Login', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400
                      ,color: ColorPallete.textBlackColor)),
                  onTap: () {
                    Navigator.pushNamed(context, '/layout');
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color:  ColorPallete.textWhiteColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register_view');
                      },
                      child: Text(
                        'Create One',
                        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700,
                          color: ColorPallete.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                        child: Divider(color: ColorPallete.primaryColor)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'OR',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: ColorPallete.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                        width: 100,
                        child: Divider(color: ColorPallete.primaryColor)),
                  ],
                ),
                const SizedBox(height: 16),
                CustomButton(
                  onTap: () {},

                  child: Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.googleIcon, height: 30, width: 30, color: ColorPallete.textBlackColor),
                      Text(
                        'Login with Google',
                        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,
                          color: ColorPallete.textBlackColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
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
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    iconList: [Image.asset(AppAssets.englishFlag, height: 35, width: 35),
                      Image.asset(AppAssets.arabicFlag, height: 35, width: 35),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
