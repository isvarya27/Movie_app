import 'package:dartz/dartz.dart';
import 'package:movie_catalog/movie/models/movie_model.dart';

abstract class MovieRepository {
  Future<Either<String, MovieResponseModels>> getDiscover({int page = 1});
}
