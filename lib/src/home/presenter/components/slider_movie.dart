import 'package:flutter/material.dart';
import 'package:paysmart_challenge/src/home/domain/entities/movies_model_entity.dart';

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
      height: 271,
      width: 400,
      child: PageView.builder(
        controller: pageController,
        itemCount: widget.listMovies.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: pageController,
            builder: (context, child) {
              double value = 1;
              if (pageController.position.haveDimensions) {
                value = pageController.page! - index;
                value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
              }
              return Center(
                child: SizedBox(
                  height: Curves.easeOut.transform(value) * 300,
                  width: Curves.easeOut.transform(value) * 250,
                  child: child,
                ),
              );
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w200${widget.listMovies[index].posterPath}'))),
            ),
          );
          // // MovieItem(

          //     movieTitle: widget.listMovies[index].title,
          //     posterPath: widget.listMovies[index].posterPath));
        },
      ),
    );
  }
}
