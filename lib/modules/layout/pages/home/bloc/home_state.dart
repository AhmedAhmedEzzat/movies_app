import 'package:equatable/equatable.dart';
import '../models/movie.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeLoaded extends HomeState {
  final List<String> sectionGenres;
  final Map<String, List<Movie>> sections;
  final List<Movie> carouselMovies;
  final int currentBackgroundIndex;

  const HomeLoaded({
    required this.sectionGenres,
    required this.sections,
    required this.carouselMovies,
    required this.currentBackgroundIndex,
  });

  HomeLoaded copyWith({
    List<String>? sectionGenres,
    Map<String, List<Movie>>? sections,
    List<Movie>? carouselMovies,
    int? currentBackgroundIndex,
  }) {
    return HomeLoaded(
      sectionGenres: sectionGenres ?? this.sectionGenres,
      sections: sections ?? this.sections,
      carouselMovies: carouselMovies ?? this.carouselMovies,
      currentBackgroundIndex: currentBackgroundIndex ?? this.currentBackgroundIndex,
    );
  }

  @override
  List<Object?> get props => [sectionGenres, sections, carouselMovies, currentBackgroundIndex];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
  @override
  List<Object?> get props => [message];
}