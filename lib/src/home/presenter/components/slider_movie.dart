// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:paysmart_challenge/src/home/domain/entities/movies_model_entity.dart';
import 'package:paysmart_challenge/src/home/presenter/components/movie_page.dart';

class SliderMovie extends StatefulWidget {
  final List<MoviesModelEntity> listMovies;
  const SliderMovie({Key? key, required this.listMovies}) : super(key: key);

  @override
  _SliderMovieState createState() => _SliderMovieState();
}

class _SliderMovieState extends State<SliderMovie> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.6);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 251,
      width: 400,
      child: PageView.builder(
        controller: pageController,
        itemCount: widget.listMovies.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MoviePage(
                      movie: widget.listMovies[index],
                    ),
                  ),
                );
              },
              child: Hero(
                tag: 'movieImage_${widget.listMovies[index].id}',
                child: AnimatedBuilder(
                  animation: pageController,
                  builder: (context, child) {
                    double value = 1;
                    if (pageController.position.haveDimensions) {
                      value = pageController.page! - index;
                      value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                    }
                    double imageSize =
                        Curves.easeOut.transform(value) * 50 + 125;
                    double spacing = Curves.easeOut.transform(value) * 50 + 5;

                    return Center(
                      child: Expanded(
                        child: SizedBox(
                          height: Curves.easeOut.transform(value) * 260,
                          width: Curves.easeOut.transform(value) * 210,
                          child: Column(
                            children: [
                              Container(
                                height: imageSize,
                                width: imageSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w200${widget.listMovies[index].posterPath}',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: spacing),
                              Expanded(
                                child: Text(
                                  widget.listMovies[index].title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ));
        },
      ),
    );
  }
}
