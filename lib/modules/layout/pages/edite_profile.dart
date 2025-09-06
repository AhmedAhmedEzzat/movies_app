import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_assets.dart';
import 'package:movies_app/core/theme/color_pallete.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/core/widgets/avatar_widget.dart';
import 'package:movies_app/modules/layout/widgets/avatar_picker_bottomsheet.dart';

class EditeProfile extends StatefulWidget {
  static const String routeName = '/edite_profile';

  const EditeProfile({super.key});

  @override
  State<EditeProfile> createState() => _EditeProfileState();
}

class _EditeProfileState extends State<EditeProfile> {
  final List<String> avatars = [
    AppAssets.avatar1,
    AppAssets.avatar2,
    AppAssets.avatar3,
    AppAssets.avatar4,
    AppAssets.avatar5,
    AppAssets.avatar6,
    AppAssets.avatar7,
    AppAssets.avatar8,
    AppAssets.avatar9,
  ];
  String selectedAvatar = AppAssets.avatar1;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Pick Avatar")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AvatarWidget(
              imagePath: selectedAvatar,
              isSelected: false,
              showBorder: false,
              size: 120,
              onTap: _showAvatarPicker,
            ),
            const SizedBox(height: 20),

            CustomTextFormField(
              hintText: 'Ahmed Ezzat',
              prefixIcon: Image.asset(AppAssets.nameIcon),
            ),
            const SizedBox(height: 15),

            CustomTextFormField(
              hintText: '01067702463',
              prefixIcon: Image.asset(AppAssets.phoneIcon),
            ),
            const SizedBox(height: 15),

            Align(
              alignment: Alignment.centerLeft,
              child: Text("Reset Password", style: theme.textTheme.bodyMedium),
            ),

            const Spacer(),

            CustomButton(
              borderColor: Colors.red,
              backgroundColor: Colors.red,
              onTap: () {},
              child: Text(
                'Delete Account',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: ColorPallete.textWhiteColor,
                ),
              ),
            ),
            const SizedBox(height: 12),
            CustomButton(
              onTap: () {},
              child: Text(
                'Update Data',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: ColorPallete.textBlackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorPallete.secBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return AvatarPickerBottomSheet(
          avatars: avatars,
          selectedAvatar: selectedAvatar,
          onAvatarSelected: (avatar) {
            setState(() {
              selectedAvatar = avatar;
            });
          },
        );
      },
    );
  }
}
