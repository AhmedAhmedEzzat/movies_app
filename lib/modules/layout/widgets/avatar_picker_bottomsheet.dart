import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/avatar_widget.dart';
import 'package:movies_app/core/theme/color_pallete.dart';

class AvatarPickerBottomSheet extends StatelessWidget {
  final List<String> avatars;
  final String selectedAvatar;
  final Function(String) onAvatarSelected;

  const AvatarPickerBottomSheet({
    super.key,
    required this.avatars,
    required this.selectedAvatar,
    required this.onAvatarSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: avatars.length,
      itemBuilder: (context, index) {
        final avatar = avatars[index];
        return AvatarWidget(
          imagePath: avatar,
          showBorder: true,
          isSelected: avatar == selectedAvatar,
          borderColor: ColorPallete.primaryColor,
          selectedColor: ColorPallete.primaryColor,
          onTap: () {
            onAvatarSelected(avatar);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
