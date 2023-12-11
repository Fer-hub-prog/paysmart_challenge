import 'package:flutter/material.dart';
import 'package:paysmart_challenge/src/home/domain/entities/movies_model_entity.dart';
import 'package:paysmart_challenge/src/home/presenter/components/movie_page.dart';

class MovieItem extends StatefulWidget {
  final String movieTitle;
  final String posterPath;
  final Function()? onTap;
  final MoviesModelEntity movie;

  const MovieItem(
      {super.key,
      required this.movieTitle,
      required this.posterPath,
      required this.movie,
      this.onTap,      
      required Size imageSize});
  

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MoviePage(movie: widget.movie),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 450.0,
                width: 90.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://image.tmdb.org/t/p/w200${widget.posterPath}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              widget.movieTitle,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      );
}
