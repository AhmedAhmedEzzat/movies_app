import 'package:flutter/material.dart';

import '../theme/color_pallete.dart';
class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Widget? child;
  final Color? borderColor;
  const CustomButton({super.key, this.onTap, this.backgroundColor, required this.child, this.borderColor, });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(

          elevation: 0,
          backgroundColor: backgroundColor ?? ColorPallete.primaryColor,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: borderColor ?? ColorPallete.primaryColor,
              width: 1.5,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          textStyle: theme.textTheme.bodyLarge,
        ),
        child: child,

      ),
    );
  }
}
