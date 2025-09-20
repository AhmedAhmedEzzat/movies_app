// movie_details_state.dart
import 'package:equatable/equatable.dart';
import 'package:movies_app/modules/layout/pages/home/models/movie.dart';

abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();
  @override
  List<Object?> get props => [];
}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final Movie movie;
  final List<Movie> similar;

  const MovieDetailsLoaded({required this.movie, required this.similar});

  MovieDetailsLoaded copyWith({Movie? movie, List<Movie>? similar}) {
    return MovieDetailsLoaded(
      movie: movie ?? this.movie,
      similar: similar ?? this.similar,
    );
  }

  @override
  List<Object?> get props => [movie, similar];
}

class MovieDetailsError extends MovieDetailsState {
  final String message;
  const MovieDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
