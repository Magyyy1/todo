// ignore_for_file: avoid_print

import 'package:pocketbase/pocketbase.dart';
import 'package:test2/main.dart';

class PocketBaseAuth {
Future signIn(String email,String password)async{
 try 
{ final authData = await pb
.collection('user')
.authWithPassword(email, password);

await pb.collection('users').confirmVerification(pb.authStore.token);
print('Успешный вход');
print('Токен: ${pb.authStore.token}');
print('ID пользователя: ${pb.authStore.record?.id}');
return authData;
} on ClientException catch (e) {print('Ошибка входа: ${e.response['mesage']}');}
}


Future signUp(String email,String password, String name, String confirmPassword)async{
  try{
final regDada = await pb
.collections
.create(
  body: {
    'email': email,
    'password': password,
    'emailVisibility': true,
    'passswordConfirm': password,
    'name': name,
  },
);
print('Успешный вход');
print('Токен: ${pb.authStore.token}');
print('ID пользователя: ${pb.authStore.record?.id}');

return regDada;
} on ClientException catch (e) {print('Ошибка входа: ${e.response['mesage']}');}
}

  Future <void> logOut() async {
    try {
      return pb.authStore.clear();
    } catch (e) {
      return;
    }
  }

}
