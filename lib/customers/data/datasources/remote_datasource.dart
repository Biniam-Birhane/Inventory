import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_inventory/core/errors/api_exception.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/customers/data/models/customer_model.dart';
import 'package:simple_inventory/customers/domain/entities/customer_entity.dart';
import 'package:uuid/uuid.dart';

class RemoteDataSource {
  RemoteDataSource();
  CollectionReference customerRef =
      FirebaseFirestore.instance.collection('customers');
  Future<void> addCustomer(
      {required String name, required String phoneNumber}) async {
    try {
      var uuid = const Uuid();
      final String id = uuid.v4();
      final data = {'id': id, 'name': name, 'phoneNumber': phoneNumber};
      await customerRef.doc(id).set(data);
    } on APIException catch (e) {
      print("response error: ${e.message}");
      throw APIException(message: e.message, statusCode: e.statusCode);
    }
  }

  Future<void> updateCustomer(
      {required String id,
      required String name,
      required String phoneNumber}) async {
    try {
      final data = {'id': id, 'name': name, 'phoneNumber': phoneNumber};
      await customerRef.doc(id).update(data);
    } on APIException catch (e) {
      print("response error: ${e.message}");
      throw APIException(message: e.message, statusCode: e.statusCode);
    }
  }

  Future<void> deleteCustomer({required String id}) async {
    try {
      await customerRef.doc(id).delete();
    } on APIException catch (e) {
      print("response error: ${e.message}");
      throw APIException(message: e.message, statusCode: e.statusCode);
    }
  }

  Future<List<CustomerEntity>> getCustomers() async {
    try {
      QuerySnapshot querySnapshot = await customerRef.get();
      List<CustomerEntity> customers = querySnapshot.docs.map((doc) {
        return CustomerModel.fromMap(doc.data() as DataMap);
      }).toList();
      return customers;
    } on APIException {
      rethrow;
    } on Exception catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
