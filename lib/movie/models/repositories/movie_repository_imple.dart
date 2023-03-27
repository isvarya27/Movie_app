import 'package:dartz/dartz.dart';
import 'package:movie_catalog/movie/models/movie_model.dart';
import 'package:movie_catalog/movie/models/repositories/movie_repository.dart';
import 'package:dio/dio.dart';

class MovieRepositoryImple implements MovieRepository {
  final Dio _dio;

  MovieRepositoryImple(this._dio);

  @override
  Future<Either<String, MovieResponseModels>> getDiscover({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/discover/movie',
        queryParameters: {'page': page},
      );
      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModels.fromJson(result.data);
        return Right(model);
      }
      return const Left('Error get discover Movies');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return left('another error on get discover movies');
    }
  }
}
