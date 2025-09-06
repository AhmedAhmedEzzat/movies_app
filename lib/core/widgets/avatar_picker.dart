import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AvatarCarousel extends StatefulWidget {
  final List<String> avatars;
  final Function(String) onSelected;

  const AvatarCarousel({
    super.key,
    required this.avatars,
    required this.onSelected,
  });

  @override
  State<AvatarCarousel> createState() => _AvatarCarouselState();
}

class _AvatarCarouselState extends State<AvatarCarousel> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.avatars.length,
          options: CarouselOptions(
            height: 120,
            enlargeCenterPage: true,
            viewportFraction: 0.33,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
              widget.onSelected(widget.avatars[index]);
            },
          ),
          itemBuilder: (context, index, realIdx) {
            final isSelected = index == currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: CircleAvatar(
                radius: isSelected ? 55 : 45,
                backgroundImage: AssetImage(widget.avatars[index]),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        Text(
          "Avatar",
          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
