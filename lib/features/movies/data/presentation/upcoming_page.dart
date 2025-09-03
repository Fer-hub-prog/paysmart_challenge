import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers.dart';
import 'movie_card.dart';
import 'movie_details_page.dart';
import 'search_page.dart';

class UpcomingPage extends ConsumerStatefulWidget {
  const UpcomingPage({super.key});
  @override
  ConsumerState<UpcomingPage> createState() => _UpcomingPageState();
}

class _UpcomingPageState extends ConsumerState<UpcomingPage> {
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(upcomingProvider.notifier).loadNext();
    _scroll.addListener(() {
      if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 400) {
        ref.read(upcomingProvider.notifier).loadNext();
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(upcomingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lançamentos em breve'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const SearchPage())),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(upcomingProvider);
          await ref.read(upcomingProvider.notifier).loadNext();
        },
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
    );
  }
}
