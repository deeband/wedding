import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProvider extends ChangeNotifier {
  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

  get userData => null;

  void setUser(GoogleSignInAccount user) {
    _user = user;
    notifyListeners();
  }

  void signOut() {
    _user = null;
    notifyListeners();
  }
}
