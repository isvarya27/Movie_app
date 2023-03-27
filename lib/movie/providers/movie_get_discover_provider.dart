import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_catalog/movie/models/movie_model.dart';
import 'package:movie_catalog/movie/models/repositories/movie_repository.dart';

class MovieGetDiscoverProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieGetDiscoverProvider(this._movieRepository);

  bool _isLoading = false; //for check use this var or no
  bool get isLoading => _isLoading;
  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  void getDicover(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    final result = await _movieRepository.getDiscover();

    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          errorMessage,
        )));
        _isLoading = false;
        notifyListeners();
        return;
      },
      (response) {
        _movies.clear();
        _movies.addAll(response.results);
        _isLoading = false;
        notifyListeners();
        return null;
      },
    );
  }

  void getDiscoverWithPagination(
    BuildContext context,
    PagingController pagingController,
    int pages,
  ) async {
    final result = await _movieRepository.getDiscover(page: pages);

    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          errorMessage,
        )));
        return;
      },
      (response) {
        if (response.results.length < 20) {
          pagingController.appendLastPage(response.results);
        } else {
          // final nextPage = response.results.length + pages;
          pagingController.appendPage(response.results, pages = pages + 1);
        }
      },
    );
  }
}

class MovieGetDiscoverStateNotifierProvider extends StateNotifier<List<MovieModel>> {
  final MovieRepository _movieRepository;

  MovieGetDiscoverStateNotifierProvider(this._movieRepository) : super([]);

  bool _isLoading = false; //for check use this var or no
  bool get isLoading => _isLoading;
  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  // void getDicover(BuildContext context) async {
  //   _isLoading = true;
  //   notifyListeners();
  //   final result = await _movieRepository.getDiscover();

  //   result.fold(
  //     (errorMessage) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text(
  //         errorMessage,
  //       )));
  //       _isLoading = false;
  //       notifyListeners();
  //       return;
  //     },
  //     (response) {
  //       _movies.clear();
  //       _movies.addAll(response.results);
  //       _isLoading = false;
  //       notifyListeners();
  //       return null;
  //     },
  //   );
  // }

  void getDiscoverWithPagination(
    BuildContext context,
    PagingController pagingController,
    int pages,
  ) async {
    final result = await _movieRepository.getDiscover(page: pages);

    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          errorMessage,
        )));
        return;
      },
      (response) {
        if (response.results.length < 20) {
          pagingController.appendLastPage(response.results);
        } else {
          // final nextPage = response.results.length + pages;
          pagingController.appendPage(response.results, pages = pages + 1);
        }
      },
    );
  }
}

// final getDiscoverWithPaginationProvider = FutureProvider.family<List<MovieModel>, int>((ref, pages) async {
//   final MovieRepository _movieRepository;
//   final result = await _movieRepository.getDiscover(page: pages);
//   return [];
// });
