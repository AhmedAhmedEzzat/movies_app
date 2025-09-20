// movie_details_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/theme/color_pallete.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/modules/layout/pages/home/models/movie.dart';
import 'package:movies_app/modules/layout/pages/movie_details/bloc/movie_details_bloc.dart';
import 'package:movies_app/modules/layout/pages/movie_details/bloc/movie_details_event.dart';
import 'package:movies_app/modules/layout/pages/movie_details/bloc/movie_details_state.dart';


class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;
  final List<Movie>? similarMoviesPool;

  const MovieDetailsScreen({
    Key? key,
    required this.movie,
    this.similarMoviesPool,
  }) : super(key: key);

  static Route route(Movie movie, {List<Movie>? similarPool}) {
    return MaterialPageRoute(
      builder: (_) => MovieDetailsScreen(movie: movie, similarMoviesPool: similarPool),
    );
  }

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String _bestImage(Movie m) {
    return (m.largeCover?.isNotEmpty == true
        ? m.largeCover!
        : (m.backgroundImage?.isNotEmpty == true ? m.backgroundImage! : (m.mediumCover ?? '')))
        .toString();
  }

  Widget _statItem(IconData icon, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(10)),
      child: Row(children: [Icon(icon, color: ColorPallete.primaryColor), const SizedBox(width: 8), Text(value, style: const TextStyle(color: Colors.white))]),
    );
  }

  Widget _screenshotBlock(String? url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: double.infinity,
          height: 180,
          child: (url != null && url.isNotEmpty)
              ? Image.network(url, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: Colors.grey[800]))
              : Container(color: Colors.grey[800]),
        ),
      ),
    );
  }

  Widget _similarCard(Movie m, void Function(Movie) onTap) {
    final img = _bestImage(m);
    return GestureDetector(
      onTap: () => onTap(m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 100,
              height: 140,
              child: (img.isNotEmpty)
                  ? Image.network(img, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: Colors.grey[900]))
                  : Container(color: Colors.grey[900]),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 100,
            child: Text(
              m.title ?? '—',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _castRow(Map<String, String> cast) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        CircleAvatar(backgroundColor: Colors.grey[800], child: const Icon(Icons.person)),
        const SizedBox(width: 12),
        Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Name : ${cast['name'] ?? '—'}', style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 4),
              Text('Character : ${cast['character'] ?? '—'}', style: const TextStyle(color: Colors.white70)),
            ]))
      ]),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Align(alignment: Alignment.centerLeft, child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieDetailsBloc>(
      create: (_) => MovieDetailsBloc(initialMovie: widget.movie, pool: widget.similarMoviesPool),
      child: BlocListener<MovieDetailsBloc, MovieDetailsState>(
        listenWhen: (previous, current) {
          // لما يجهز الـ Loaded نرجع لفوق
          return current is MovieDetailsLoaded && previous != current;
        },
        listener: (context, state) {
          if (state is MovieDetailsLoaded) {
            _scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
          }
        },
        child: Scaffold(
          backgroundColor: ColorPallete.backgroundColor,
          body: SafeArea(
            child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
              builder: (context, state) {
                if (state is MovieDetailsLoading || state is MovieDetailsInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MovieDetailsError) {
                  return Center(child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.white)));
                } else if (state is MovieDetailsLoaded) {
                  final movie = state.movie;
                  final similar = state.similar;
                  final cover = _bestImage(movie);

                  return SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Poster full (بدون أي overlay)
                        if (cover.isNotEmpty)
                          SizedBox(
                            width: double.infinity,
                            height: 360,
                            child: Stack(
                              children: [
                                Positioned.fill(child: Image.network(cover, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: Colors.grey[900]))),
                                // top controls (back/bookmark) فوق الصورة
                                Positioned(
                                  left: 12,
                                  top: 12,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black38,
                                    child: IconButton(
                                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 12,
                                  top: 12,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black38,
                                    child: IconButton(
                                      icon: const Icon(Icons.bookmark_border, color: Colors.white),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                                // play button centered bottom
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 20,
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        // play action
                                      },
                                      child: Container(
                                        width: 76,
                                        height: 76,
                                        decoration: BoxDecoration(
                                          color: ColorPallete.primaryColor,
                                          shape: BoxShape.circle,
                                          boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(0, 4))],
                                        ),
                                        child: const Icon(Icons.play_arrow, color: Colors.white, size: 40),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Container(height: 240, color: Colors.grey[900], child: const Center(child: Icon(Icons.movie, size: 64, color: Colors.white70))),

                        const SizedBox(height: 12),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              Text(
                                movie.title ?? 'No title',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                movie.year?.toString() ?? '',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                              ),
                              const SizedBox(height: 12),
                              CustomButton(
                                onTap: () {},
                                backgroundColor: Colors.red,
                                borderColor: Colors.red,
                                child: Text('Watch', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorPallete.textWhiteColor)),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _statItem(Icons.favorite, '15'),
                                  _statItem(Icons.access_time, (movie.runtime?.toString() ?? '—')),
                                  _statItem(Icons.star, (movie.rating != null ? movie.rating!.toStringAsFixed(1) : '—')),
                                ],
                              ),
                              const SizedBox(height: 18),
                            ],
                          ),
                        ),

                        // Similar
                        if (similar.isNotEmpty) ...[
                          _sectionTitle('Similar'),
                          SizedBox(
                            height: 200,
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              scrollDirection: Axis.horizontal,
                              itemCount: similar.length,
                              separatorBuilder: (_, __) => const SizedBox(width: 12),
                              itemBuilder: (_, i) => _similarCard(similar[i], (m) {
                                // لما يدوس نبعث حدث للبلوك لتحميل الفيلم الجديد
                                context.read<MovieDetailsBloc>().add(LoadMovieDetails(m));
                              }),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],

                        // Screen shots (متراصة عمودياً)


                        const SizedBox(height: 12),

                        // Summary
                        _sectionTitle('Summary'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            (movie.descriptionFull?.isNotEmpty == true) ? movie.descriptionFull! : (movie.summary ?? 'No summary available'),
                            style: const TextStyle(color: Colors.white70, height: 1.4),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Cast


                        // Genres
                        if ((movie.genres ?? []).isNotEmpty) ...[
                          _sectionTitle('Genres'),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: (movie.genres ?? []).map((g) {
                                return Chip(
                                  backgroundColor: Colors.grey[850],
                                  label: Text(g, style: const TextStyle(color: Colors.white)),
                                );
                              }).toList(),
                            ),
                          ),
                        ],

                        const SizedBox(height: 30),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
