import "package:flutter/material.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:movie_catalog/movie/models/movie_model.dart";
import "package:movie_catalog/movie/providers/movie_get_discover_provider.dart";
import "package:provider/provider.dart";

import "../../widget/item_movie_widget.dart";

class MoviePagination extends StatefulWidget {
  const MoviePagination({super.key});

  @override
  State<MoviePagination> createState() => _MoviePaginationState();
}

class _MoviePaginationState extends State<MoviePagination> {
  final PagingController<int, MovieModel> _pagingController = PagingController(
    firstPageKey: 1,
  );
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      context.read<MovieGetDiscoverProvider>().getDiscoverWithPagination(
            context,
            _pagingController,
            pageKey,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Discover Movies"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: PagedListView.separated(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<MovieModel>(
            itemBuilder: (context, movie, index) => ItemMovieWidget(
              movie: movie,
              heightBackdrop: 270,
              widthBackdrop: double.infinity,
              heightPoster: 180,
              widthPoster: 100,
            ),
          ),
          separatorBuilder: (context, index) => SizedBox(
            height: 5,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
