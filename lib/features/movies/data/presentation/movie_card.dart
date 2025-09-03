import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:paysmart_challenge/core/formatters.dart';
import 'package:paysmart_challenge/features/movies/data/models/movie.dart';
import 'package:paysmart_challenge/features/movies/providers.dart';

class MovieCard extends ConsumerWidget {
  final Movie movie;
  final VoidCallback onTap;
  const MovieCard({super.key, required this.movie, required this.onTap});
  String _poster(String? path) =>
      path != null ? 'https://image.tmdb.org/t/p/w342$path' : '';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favs = ref.watch(favoritesProvider);
    final repo = ref.read(repoProvider);
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (movie.posterPath != null)
              CachedNetworkImage(
                imageUrl: _poster(movie.posterPath),
                width: 100,
                height: 150,
                fit: BoxFit.cover,
                placeholder: (_, __) => const SizedBox(
                    width: 100,
                    height: 150,
                    child: Center(
                        child: CircularProgressIndicator(strokeWidth: 1))),
              )
            else
              Container(
                  width: 100,
                  height: 150,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.image_not_supported)),
            const SizedBox(width: 12),
            Expanded(
              child: FutureBuilder(
                future: repo.genres(),
                builder: (context, snap) {
                  final genres = snap.data ?? [];
                  final names = movie.genres != null && movie.genres!.isNotEmpty
                      ? movie.genres!.map((g) => (g as Map)['name']).join(',')
                      : genres
                          .where((g) => movie.genreIds.contains(g.id))
                          .map((e) => e.name)
                          .join(', ');
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(movie.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 4),
                        Text(names,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey.shade700)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.event, size: 16),
                            const SizedBox(width: 4),
                            Text(formatDate(movie.releaseDate)),
                            const Spacer(),
                            IconButton(
                              icon: Icon(favs.contains(movie.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border),
                              onPressed: () => ref
                                  .read(favoritesProvider.notifier)
                                  .toggle(movie.id),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
