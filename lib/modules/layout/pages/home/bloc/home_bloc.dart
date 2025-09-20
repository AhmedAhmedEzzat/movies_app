import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie.dart';
import '../repositories/movie_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieRepository repository;
  static const String _prefsKey = 'home_genre_offset';

  HomeBloc({required this.repository}) : super(HomeInitial()) {
    on<HomeLoadEvent>(_onLoad);
    on<HomeRotateSectionsEvent>(_onRotate);
    on<ChangeBackgroundEvent>(_onChangeBackground);
    on<HomeShuffleSectionsEvent>(_onShuffle);
  }

  Future<void> _onLoad(HomeLoadEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final movies = await repository.fetchMovies(limit: 100);
      final grouped = repository.groupByGenre(movies);

      final genres = grouped.keys.toList();

      genres.shuffle();

      final List<String> chosen = genres.take(3).toList();

      final Map<String, List<Movie>> sections = {};
      for (final g in chosen) {
        sections[g] = grouped[g]!.take(10).toList();
      }

      movies.sort((a, b) => b.dateUploadedUnix.compareTo(a.dateUploadedUnix));
      final carousel = movies.take(7).toList();

      emit(HomeLoaded(
          sectionGenres: chosen,
          sections: sections,
          carouselMovies: carousel,
          currentBackgroundIndex: 0
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onRotate(HomeRotateSectionsEvent event, Emitter<HomeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final offset = prefs.getInt(_prefsKey) ?? 0;
    await prefs.setInt(_prefsKey, offset + 1);
    add(const HomeLoadEvent(forceRefresh: true));
  }

  void _onChangeBackground(ChangeBackgroundEvent event, Emitter<HomeState> emit) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(currentState.copyWith(currentBackgroundIndex: event.index));
    }
  }

  void _onShuffle(HomeShuffleSectionsEvent event, Emitter<HomeState> emit) {
    add(const HomeLoadEvent(forceRefresh: true));
  }
}