import 'package:flutter/material.dart';
import 'package:movies_app/core/theme/color_pallete.dart';

class AvatarWidget extends StatelessWidget {
  final String imagePath;
  final bool isSelected;
  final bool showBorder;
  final double size;
  final VoidCallback? onTap;
  final Color? selectedColor;
  final Color? borderColor;

  const AvatarWidget({
    super.key,
    required this.imagePath,
    this.isSelected = false,
    this.showBorder = true,
    this.size = 100,
    this.onTap,
    this.selectedColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isSelected ? (selectedColor ?? ColorPallete.primaryColor) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: showBorder
              ? Border.all(
            color: borderColor ?? ColorPallete.primaryColor,
            width: 2,
          )
              : null,
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
