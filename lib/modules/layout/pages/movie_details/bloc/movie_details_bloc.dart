// movie_details_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/modules/layout/pages/home/models/movie.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  /// pool من الأفلام الّي بنستخدمها لاستخراج الـ similar
  final List<Movie> pool;

  MovieDetailsBloc({required Movie initialMovie, List<Movie>? pool})
      : pool = pool ?? [],
        super(MovieDetailsLoaded(movie: initialMovie, similar: _computeSimilar(initialMovie, pool ?? []))) {
    on<LoadMovieDetails>(_onLoad);
  }

  Future<void> _onLoad(LoadMovieDetails event, Emitter<MovieDetailsState> emit) async {
    try {
      emit(MovieDetailsLoading());
      // لو العملية ممكن تكون async (fetch) تحط await هنا
      final similar = _computeSimilar(event.movie, pool);
      emit(MovieDetailsLoaded(movie: event.movie, similar: similar));
    } catch (e) {
      emit(MovieDetailsError(e.toString()));
    }
  }

  // Helper: نفس لوجيك الفرز اللي اتفقنا عليه
  static List<Movie> _computeSimilar(Movie current, List<Movie> pool) {
    final curGenres = (current.genres ?? []).map((g) => g.toLowerCase()).toSet();
    final candidates = pool.where((m) => m.id != current.id).toList();

    candidates.sort((a, b) {
      final overlapA = (a.genres ?? []).map((e) => e.toLowerCase()).toSet().intersection(curGenres).length;
      final overlapB = (b.genres ?? []).map((e) => e.toLowerCase()).toSet().intersection(curGenres).length;
      if (overlapB != overlapA) return overlapB.compareTo(overlapA);
      final at = a.dateUploadedUnix ?? 0;
      final bt = b.dateUploadedUnix ?? 0;
      return bt.compareTo(at); // الأحدث أولاً
    });

    return candidates.take(8).toList();
  }
}
