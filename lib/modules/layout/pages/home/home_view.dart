// lib/modules/layout/pages/home/home_view.dart
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/constants/app_assets.dart';
import 'package:movies_app/core/theme/color_pallete.dart';
import 'package:movies_app/modules/layout/pages/home/bloc/home_bloc.dart';
import 'package:movies_app/modules/layout/pages/home/bloc/home_event.dart';
import 'package:movies_app/modules/layout/pages/home/bloc/home_state.dart';
import 'package:movies_app/modules/layout/pages/home/models/movie.dart';
import 'package:movies_app/modules/layout/pages/movie_details/movie_details_screen.dart';
import 'package:movies_app/modules/layout/pages/home/widgets/movie_card.dart';
import 'repositories/movie_repository.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const routeName = '/homeView';

  @override
  State<HomeView> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeView> with WidgetsBindingObserver {
  late HomeBloc bloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    bloc = HomeBloc(repository: MovieRepository());
    bloc.add(const HomeRotateSectionsEvent());
    bloc.add(const HomeLoadEvent());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      bloc.add(const HomeRotateSectionsEvent());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        backgroundColor: ColorPallete.backgroundColor,
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading || state is HomeInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeError) {
                return Center(
                  child: Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              } else if (state is HomeLoaded) {
                return _buildLoaded(state);
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoaded(HomeLoaded state) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _buildCarouselSection(state)),
        SliverToBoxAdapter(child: _buildWatchNowSection()),
        // Genre Sections
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final genre = state.sectionGenres[index];
              return _buildGenreSection(genre, state.sections[genre] ?? []);
            },
            childCount: state.sectionGenres.length,
          ),
        ),
      ],
    );
  }

  Widget _buildCarouselSection(HomeLoaded state) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Stack(
        children: [
          // الخلفية تتغيّر بحسب currentBackgroundIndex في الـ state
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) {
              return current is HomeLoaded &&
                  previous is HomeLoaded &&
                  (previous as HomeLoaded).currentBackgroundIndex !=
                      (current as HomeLoaded).currentBackgroundIndex;
            },
            builder: (context, s) {
              if (s is HomeLoaded) {
                final currentMovie = s.carouselMovies[s.currentBackgroundIndex];
                final bgUrl = currentMovie.largeCover.isNotEmpty
                    ? currentMovie.largeCover
                    : currentMovie.mediumCover;
                return Positioned.fill(
                  child: bgUrl.isNotEmpty
                      ? Image.network(
                    bgUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (_, __, ___) => Container(color: Colors.black),
                  )
                      : Container(color: Colors.black),
                );
              }
              return Container();
            },
          ),

          // تظليل فوق الخلفية
          Positioned.fill(child: Container(color: Colors.black.withOpacity(0.7))),

          // محتوى الـ carousel (AvailableNow + slider)
          Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Image.asset(AppAssets.availableNow, height: 100),
              ),
              const SizedBox(height: 12),

              CarouselSlider.builder(
                itemCount: state.carouselMovies.length,
                itemBuilder: (context, index, realIndex) {
                  final movie = state.carouselMovies[index];

                  // خليك ضايف onTap: تفتح تفاصيل الفيلم
                  return GestureDetector(
                    onTap: () {
                      final movieTapped = movie;
                      final similar = _collectSimilarMovies(state, movieTapped, limit: 6);
                      Navigator.push(
                        context,
                        MovieDetailsScreen.route(movieTapped, similarPool: similar),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        movie.largeCover.isNotEmpty ? movie.largeCover : movie.mediumCover,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(color: Colors.transparent),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.4,
                  enlargeCenterPage: true,
                  viewportFraction: 0.6,
                  onPageChanged: (index, reason) {
                    bloc.add(ChangeBackgroundEvent(index: index));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWatchNowSection() {
    return Column(
      children: [
        Image.asset(
          AppAssets.watchNow,
          width: double.infinity,
          height: 140,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildGenreSection(String genre, List<Movie> movies) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                genre,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to See More
                },
                child: Text(
                  'See More →',
                  style: TextStyle(color: ColorPallete.primaryColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieCard(
                  movie: movie,
                  width: 150,
                  onTap: () {
                    final similar = _collectSimilarMoviesFromAllSections(context, movie, );
                    Navigator.push(context, MovieDetailsScreen.route(movie, similarPool: similar));
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // يجمع أفلام مشابهة من carousel + sections ثم يرجع قائمة بدون الفيلم الحالي
  List<Movie> _collectSimilarMovies(HomeLoaded state, Movie current, {int limit = 4}) {
    final Map<int, Movie> map = {};

    // إضافة carousel
    for (final m in state.carouselMovies) {
      map[m.id] = m;
    }

    // إضافة كل الأقسام
    for (final list in state.sections.values) {
      for (final m in list) {
        map[m.id] = m;
      }
    }

    // استثناء الفيلم الحالي
    map.remove(current.id);

    // ترتيب افتراضي: حسب تاريخ التحميل newest -> oldest لو موجود الحقل dateUploadedUnix
    final sorted = map.values.toList()
      ..sort((a, b) => b.dateUploadedUnix.compareTo(a.dateUploadedUnix));

    return sorted.take(limit).toList();
  }

  // نسخة أخرى تستخدم الـ HomeBloc state الموجود في ال context لو احتجت (احتياط)
  List<Movie> _collectSimilarMoviesFromAllSections(BuildContext context, Movie current, {int limit = 4, HomeLoaded? excludeState}) {
    final state = excludeState ?? (BlocProvider.of<HomeBloc>(context).state as HomeLoaded);
    return _collectSimilarMovies(state, current, limit: limit);
  }
}
