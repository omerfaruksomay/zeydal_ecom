import 'package:flutter/material.dart';

class CreateCommentPageViewModel with ChangeNotifier {
  int _raiting = 0;

  int get raiting => _raiting;

  void setRaiting(int newRaiting) {
    _raiting = newRaiting;
    notifyListeners();
  }

  void createComment(BuildContext context, String comment, int raiting) {
    print("Puan: $raiting $comment");
    // Navigator.pop(context);
  }
}
