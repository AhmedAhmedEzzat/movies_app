// movie_details_event.dart
import 'package:equatable/equatable.dart';
import 'package:movies_app/modules/layout/pages/home/models/movie.dart';

abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();
  @override
  List<Object?> get props => [];
}

/// يطلب تحميل / عرض فيلم معين
class LoadMovieDetails extends MovieDetailsEvent {
  final Movie movie;
  const LoadMovieDetails(this.movie);

  @override
  List<Object?> get props => [movie];
}
