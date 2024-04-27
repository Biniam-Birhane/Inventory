import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_inventory/core/errors/api_exception.dart';

abstract class RemoteLoginDataSource {
  RemoteLoginDataSource();
  Future<String> login({required String username, required String password});
  Future<void> logout();
}

class RemoteLoginDSImpl implements RemoteLoginDataSource {
  const RemoteLoginDSImpl();
  @override
  Future<String> login(
      {required String username, required String password}) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final result = await firebaseAuth.signInWithEmailAndPassword(
          email: username, password: password);
      // if(result)
      print(result);
      return result.toString();
    } on APIException {
      rethrow;
    } catch (e) {
      print("Error : $e");
      throw APIException(message: e.toString(), statusCode: 500);
    }
    // try {
    //   // print('$username $password');
    //   if (username == 'kbrom' && password == "admin" ||
    //       username == 'Admin' && password == "admin") {
    //     return "eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c";
    //   } else {
    //     throw const APIException(
    //         message: "invalid credentials", statusCode: 404);
    //   }
    // Response response = await Dio().post('http://localhost:3000/login',
    //     data: {username: username, password: password});
    // if (response.statusCode != 200 || response.statusCode != 201) {
    //   throw APIException(
    //       message: response.data, statusCode: response.statusCode ?? 500);
    // }
    //   } on APIException {
    //     rethrow;
    //   } on Exception catch (e) {
    //     throw APIException(message: e.toString(), statusCode: 500);
    //   }
  }

  Future<void> logout() async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.signOut();
    } on APIException {
      rethrow;
    } on Exception catch (e) {
      throw APIException(message: e.toString(), statusCode: 500);
    }
  }
}
