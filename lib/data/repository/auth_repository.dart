import 'package:zeydal_ecom/data/data_source/auth_data_source.dart';

class AuthRepository {
  final _dataSource = AuthDataSource();

  Future<Map<String, dynamic>> login(String email, String password) {
    return _dataSource.login(email, password);
  }

}
