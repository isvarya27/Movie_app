import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_catalog/app_constants.dart';
import 'package:movie_catalog/movie/models/movie_model.dart';
import 'package:movie_catalog/movie/pages/movie_pagination.dart';

import 'package:movie_catalog/movie/providers/movie_get_discover_provider.dart';
import 'package:movie_catalog/widget/image_widget.dart';
import 'package:movie_catalog/widget/item_movie_widget.dart';
import 'package:provider/provider.dart';

class MoviePage extends StatelessWidget {
  MoviePage({super.key});

  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 30,
                child: Image.asset(
                  'assets/images/moviedb.png',
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text('Movie DB Application'),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Discover Movies",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blueGrey,
                  ),
                ),
                OutlinedButton(
                  onHover: (value) {
                    Color(0xFF214563);
                  },
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MoviePagination(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blueGrey,
                    shape: const StadiumBorder(),
                    side: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                  child: const Text("See All"),
                )
              ],
            ),
          ),
        ),
        const WidgetDiscoverMovie(),
      ],
    ));
  }
}

class WidgetDiscoverMovie extends StatefulWidget {
  const WidgetDiscoverMovie({super.key});

  @override
  State<WidgetDiscoverMovie> createState() => _WidgetDiscoverMovieState();
}

class _WidgetDiscoverMovieState extends State<WidgetDiscoverMovie> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetDiscoverProvider>().getDicover(context);
    });
    super.initState();
    print("initState()");
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<MovieGetDiscoverProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              height: 300.0,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(15),
              ),
            );
          }
          // debugPrint(provider.toString());
          if (provider.movies.isNotEmpty) {
            return CarouselSlider.builder(
              itemCount: provider.movies.length,
              itemBuilder: (_, index, __) {
                final movie = provider.movies[index];
                return ItemMovieWidget(
                  movie: movie,
                  heightBackdrop: 280,
                  widthBackdrop: double.infinity,
                  heightPoster: 180,
                  widthPoster: 100,
                );
              },
              options: CarouselOptions(
                height: 280,
                viewportFraction: 0.8,
                reverse: false,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            );
          }
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                "Not Found Discover Movies",
              ),
            ),
          );
        },
      ),
    );
  }
}
