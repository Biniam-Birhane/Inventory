import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_inventory/core/errors/api_exception.dart';

abstract class RemoteLoginDataSource {
  RemoteLoginDataSource();
  Future<String> login({required String username, required String password});
  Future<void> logout();
  Future<void> addUser({required String username, required String password});
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
      return result.toString();
    } on APIException {
      rethrow;
    } catch (e) {
      print("Error : $e");
      throw APIException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<void> addUser(
      {required String username, required String password}) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: username, password: password);
      print('registered');
    } on APIException catch (e) {
      throw APIException(message: e.message, statusCode: e.statusCode);
    }
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
