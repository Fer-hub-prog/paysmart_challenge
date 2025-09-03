import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/tmdb_api.dart';
import 'data/movie_repository.dart';
import 'data/models/movie.dart';
import '../../core/result.dart';

final apiProvider = Provider((_) => TmdbApi());
final repoProvider = Provider((ref) => MovieRepository(ref.read(apiProvider)));

/// Favoritos (armazenados localmente)
final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, Set<int>>(
  (ref) => FavoritesNotifier(),
);

class FavoritesNotifier extends StateNotifier<Set<int>> {
  FavoritesNotifier() : super({}) {
    _load();
  }

  Future<void> _load() async {
    final sp = await SharedPreferences.getInstance();
    final ids = sp.getStringList('fav_ids')?.map(int.parse).toSet() ?? <int>{};
    state = ids;
  }

  Future<void> toggle(int id) async {
    final sp = await SharedPreferences.getInstance();
    final s = {...state};
    if (s.contains(id)) {
      s.remove(id);
    } else {
      s.add(id);
    }
    state = s;
    await sp.setStringList('fav_ids', s.map((e) => e.toString()).toList());
  }
}

/// Paginação (upcoming)
class PagedMoviesState {
  final List<Movie> items;
  final int page;
  final int totalPages;
  final bool loading;
  final Object? error;
  const PagedMoviesState({
    this.items = const [],
    this.page = 0,
    this.totalPages = 1,
    this.loading = false,
    this.error,
  });
  bool get canLoadMore => !loading && page < totalPages;
}

final upcomingProvider =
    StateNotifierProvider<UpcomingNotifier, PagedMoviesState>(
  (ref) => UpcomingNotifier(ref),
);

class UpcomingNotifier extends StateNotifier<PagedMoviesState> {
  UpcomingNotifier(this.ref) : super(const PagedMoviesState());
  final Ref ref;

  Future<void> loadNext() async {
    if (state.loading) return;
    final next = state.page + 1;
    if (next > state.totalPages) return;

    state = PagedMoviesState(
      items: state.items,
      page: state.page,
      totalPages: state.totalPages,
      loading: true,
    );

    final repo = ref.read(repoProvider);
    final res = await repo.upcoming(next);

    switch (res) {
      case Ok(value: final v):
        state = PagedMoviesState(
          items: [...state.items, ...v.$1],
          page: v.$2,
          totalPages: v.$3,
          loading: false,
        );
      case Err(error: final e):
        state = PagedMoviesState(
          items: state.items,
          page: state.page,
          totalPages: state.totalPages,
          loading: false,
          error: e,
        );
    }
  }
}

/// Busca
final queryProvider = StateProvider<String>((_) => '');

final searchProvider =
    StateNotifierProvider<SearchNotifier, PagedMoviesState>(
  (ref) => SearchNotifier(ref),
);

class SearchNotifier extends StateNotifier<PagedMoviesState> {
  SearchNotifier(this.ref) : super(const PagedMoviesState());
  final Ref ref;

  String _currentQ = '';

  Future<void> start(String q) async {
    _currentQ = q.trim();
    state = const PagedMoviesState();
    await loadNext();
  }

  Future<void> loadNext() async {
    if (_currentQ.isEmpty || state.loading) return;

    final next = state.page + 1;

    state = PagedMoviesState(
      items: state.items,
      page: state.page,
      totalPages: state.totalPages,
      loading: true,
    );

    final repo = ref.read(repoProvider);
    final res = await repo.search(_currentQ, next);

    switch (res) {
      case Ok(value: final v):
        state = PagedMoviesState(
          items: [...state.items, ...v.$1],
          page: v.$2,
          totalPages: v.$3,
          loading: false,
        );
      case Err(error: final e):
        state = PagedMoviesState(
          items: state.items,
          page: state.page,
          totalPages: state.totalPages,
          loading: false,
          error: e,
        );
    }
  }
}