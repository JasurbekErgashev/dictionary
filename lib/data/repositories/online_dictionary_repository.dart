import 'package:dartz/dartz.dart';
import 'package:dictionary/data/apis/online_dictionary_api.dart';
import 'package:dictionary/data/dto/online_dictionary.dart';

enum Failure { error, e404 }

class OnlineDictionaryRepository {
  final OnlineDictionaryApiProvider apiProvider = OnlineDictionaryApiProvider();

  Future<Either<Failure, List<OnlineDictionary>>> searchKeyword({
    required String keyword,
  }) async {
    try {
      var result = await apiProvider.searchKeyword(keyword: keyword);
      return result.fold(
        (l) {
          if (l == 404) {
            return left(Failure.e404);
          }
          return left(Failure.error);
        },
        (result) {
          return right(result);
        },
      );
    } on Exception {
      return left(Failure.error);
    }
  }
}
