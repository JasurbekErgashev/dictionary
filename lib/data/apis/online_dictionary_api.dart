import 'package:dartz/dartz.dart';
import 'package:dictionary/data/dto/online_dictionary.dart';
import 'package:dictionary/shared/logger.dart';
import 'package:http/http.dart' as http;

class OnlineDictionaryApiProvider {
  Future<Either<int, List<OnlineDictionary>>> searchKeyword({
    required String keyword,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };
    try {
      final response = await http.get(
        Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$keyword'),
        headers: headers,
      );
      logger.d(
        () => '${response.statusCode} ${response.body}',
        'Get vocabuary',
      );
      if (response.statusCode == 404) {
        return left(response.statusCode);
      }
      return right(onlineDictionaryFromJson(response.body));
    } catch (e) {
      logger.e(() => '$e', 'Get vocabuary error');
      rethrow;
    }
  }
}
