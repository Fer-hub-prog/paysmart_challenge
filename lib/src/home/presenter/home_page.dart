import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paysmart_challenge/src/home/presenter/bloc/home_controller.dart';
import 'package:paysmart_challenge/src/home/presenter/bloc/home_event.dart';
import 'package:paysmart_challenge/src/home/presenter/bloc/home_state.dart';
import 'package:paysmart_challenge/src/home/presenter/components/movie_item.dart';
import 'package:paysmart_challenge/src/home/presenter/components/slider_movie.dart';

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
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text(
                'Discover >',
                style: TextStyle(color: Colors.orange),
              ),
            ),
            body:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Movies",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Tv Shows",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Anime",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "MyList",
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Filtre",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliderMovie(
                listMovies: state.moviesList!,
              ),
              buildBullets(),

              // CarouselSlider(
              //   options: CarouselOptions(height: 200.0),
              //   items: state.moviesList!
              //       .map((e) => MovieItem(
              //             movieTitle: e.title,
              //             posterPath: e.posterPath,
              //           ))
              //       .toList(),
              // ),
              Expanded(
                child: GridView.count(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 30,
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 3,
                  children: state.moviesList!
                      .map((e) => MovieItem(
                          movieTitle: e.title, posterPath: e.posterPath))
                      .toList(),
                ),
              )
            ]),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.orange,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                  backgroundColor: Colors.black,
                  icon: Icon(Icons.favorite),
                  label: 'Favorite',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        }
        return const SizedBox.expand();
      },
    );
  }

  Widget buildBullets() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 21,
            height: 7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.red,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey,
            ),
          ),
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
