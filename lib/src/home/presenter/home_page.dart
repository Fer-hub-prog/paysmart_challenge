import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paysmart_challenge/src/home/presenter/bloc/home_controller.dart';
import 'package:paysmart_challenge/src/home/presenter/bloc/home_event.dart';
import 'package:paysmart_challenge/src/home/presenter/bloc/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = HomeController();
  @override
  void initState() {
    super.initState();
    bloc.add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeController, HomeState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const CircularProgressIndicator();
        }
        if (state is HomeSuccessState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('DISCOVER >'),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Movies   Tv Shows   Anime   MyList   Filtre",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    physics: const BouncingScrollPhysics(),
                    crossAxisCount: 3,
                    children: state.moviesList!
                        .map(
                          (e) => Container(
                            height: 171.0,
                            width: 171.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w200${e.posterPath}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
