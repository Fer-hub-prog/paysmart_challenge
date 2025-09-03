import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paysmart_challenge/core/formatters.dart';
import 'package:paysmart_challenge/core/result.dart';
import 'package:paysmart_challenge/features/movies/data/models/movie.dart';
import '../../providers.dart';

class MovieDetailsPage extends ConsumerWidget {
  final int id;
  const MovieDetailsPage({super.key, required this.id});
  String _backdrop(String? path) =>
      path != null ? 'https://image.tmdb.org/t/p/w500$path' : '';
  String _poster(String? path) =>
      path != null ? 'https://image.tmdb.org/t/p/w342$path' : '';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(repoProvider);
    final favs = ref.watch(favoritesProvider);
    return FutureBuilder<Movie>(
      future: () async {
        final res = await repo.details(id);
        if (res case Ok(value: final m)) {
          return m;
        } else {
          throw (res as Err).error;
        }
      }(),
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        if (snap.hasError) {
          return Scaffold(
              appBar: AppBar(),
              body: Center(child: Text('Erro ao carregar: ${snap.error}')));
        }

        final m = snap.data!;
        return Scaffold(
          appBar: AppBar(
            title: Text(m.title),
            actions: [
              IconButton(
                icon: Icon(favs.contains(m.id)
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () =>
                    ref.read(favoritesProvider.notifier).toggle(m.id),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (m.backdropPath != null)
                  CachedNetworkImage(
                      imageUrl: _backdrop(m.backdropPath),
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (m.posterPath != null)
                        CachedNetworkImage(
                            imageUrl: _poster(m.posterPath), width: 120),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(m.title,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Builder(
                              builder: (context) {
                                final list = (m.genres ?? [])
                                    .map((g) => (g as Map)['name'])
                                    .cast<String>()
                                    .toList();
                                return Text(list.join(', '),
                                    style:
                                        TextStyle(color: Colors.grey.shade700));
                              },
                            ),
                            const SizedBox(height: 8),
                            Row(children: [
                              const Icon(Icons.event, size: 16),
                              const SizedBox(width: 4),
                              Text(formatDate(m.releaseDate))
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Sinopse',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(m.overview?.isNotEmpty == true
                      ? m.overview!
                      : 'Sem sinopse.'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
