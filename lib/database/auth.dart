import 'package:pocketbase/pocketbase.dart';

class PocketBaseAuth {
  final PocketBase pb;

  PocketBaseAuth({required this.pb});

  Future<void> signIn(String email, String password) async {
    try {
      await pb.collection('users').authWithPassword(email, password);
      print('Успешный вход');
      print('Токен: ${pb.authStore.token}');
      print('ID пользователя: ${pb.authStore.record?.id}');
    } on ClientException catch (e) {
      print('Ошибка входа: ${e.response}');
      rethrow;
    } catch (e) {
      print('Неизвестная ошибка входа: $e');
      rethrow;
    }
  }

  Future<void> signUp(
    String email,
    String password,
    String name,
    String confirmPassword,
  ) async {
    try {
      await pb.collection('users').create(
        body: {
          'email': email,
          'password': password,
          'passwordConfirm': confirmPassword,
          'name': name,
          'emailVisibility': true,
        },
      );

      print('Успешная регистрация');
    } on ClientException catch (e) {
      print('Ошибка регистрации: ${e.response}');
      rethrow;
    } catch (e) {
      print('Неизвестная ошибка регистрации: $e');
      rethrow;
    }
  }

  Future<void> logOut() async {
    pb.authStore.clear();
  }
}