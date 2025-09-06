import 'package:movies_app/core/constants/app_assets.dart';

class OnBoardingModel {
  final String imagePath;
  final String title;
  final String description;

  OnBoardingModel({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

class OnBoardingData {
  static final List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(
      imagePath: AppAssets.onBoard1,
      title: "Find Your Next Favorite Movie Here",
      description:
          "Get access to a huge library of movies to suit all tastes. You will surely like it.",
    ),
    OnBoardingModel(
      imagePath: AppAssets.onBoard2,
      title: "Discover Movies",
      description:
          "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
    ),
    OnBoardingModel(
      imagePath: AppAssets.onBoard3,
      title: "Explore All Genres",
      description:
          "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
    ),
    OnBoardingModel(
      imagePath: AppAssets.onBoard4,
      title: "Create Watchlists",
      description:
          "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
    ),
    OnBoardingModel(
      imagePath: AppAssets.onBoard5,
      title: "Rate, Review, and Learn",
      description:
          "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
    ),
    OnBoardingModel(
      imagePath: AppAssets.onBoard6,
      title: "Start Watching Now",
      description: "",
    ),
  ];
}
