import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers.dart';
import 'movie_card.dart';
import 'movie_details_page.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});
  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _controller = TextEditingController();
  final _scroll = ScrollController();
  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 400) {
        ref.read(searchProvider.notifier).loadNext();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar filmes')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                      hintText: 'Digite otítulo do filme...',
                      border: OutlineInputBorder()),
                  onSubmitted: (v) =>
                      ref.read(searchProvider.notifier).start(v),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () =>
                    ref.read(searchProvider.notifier).start(_controller.text),
                icon: const Icon(Icons.search),
                label: const Text('Buscar'),
              ),
            ]),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              itemCount: state.items.length + (state.canLoadMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= state.items.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final m = state.items[index];
                return MovieCard(
                  movie: m,
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => MovieDetailsPage(id: m.id))),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
