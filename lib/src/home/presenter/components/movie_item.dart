import 'package:flutter/material.dart';

class MovieItem extends StatefulWidget {
  final String movieTitle;
  final String posterPath;
  final Function()? onTap;

  const MovieItem(
      {super.key,
      required this.movieTitle,
      required this.posterPath,
      this.onTap});

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) => InkWell(
        onTap: widget.onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 250.0,
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
