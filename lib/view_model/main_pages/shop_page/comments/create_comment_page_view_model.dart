import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zeydal_ecom/data/api_constants/api_constants.dart';

import '../../../../data/local_storage/storage.dart';

class CreateCommentPageViewModel with ChangeNotifier {
  final _storage = Storage();
  int _raiting = 0;

  int get raiting => _raiting;

  void setRaiting(int newRaiting) {
    _raiting = newRaiting;
    notifyListeners();
  }

  Future<void> createComment(BuildContext context, String comment, int raiting,
      String productId) async {
    final url = Uri.parse(ApiConstants.createComment);
    final String token = await _storage.readSecureData('user_token');
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': token,
        },
        body: {
          'productId': productId,
          'rating': raiting.toString(),
          'comment': comment,
        },
      );
      if (response.statusCode == 200) {
        print('Yorum kaydedildi');
      } else {
        print('Bir hata oluştu');
      }
    } catch (err) {
      throw Exception(err);
    }
  }
}
