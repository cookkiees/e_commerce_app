import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:e_commerce_app/app/core/firebase/firebase_service_request.dart';
import 'package:e_commerce_app/app/core/helpers/app_prefs.dart';
import 'package:image_picker/image_picker.dart';

import '../../modules/authentication/data/models/auth_user_models.dart';
import 'firebase_service_method_type.dart';

class FirestoreUseCase {
  static final FirestoreUseCase _instance = FirestoreUseCase._();
  FirestoreUseCase._();
  static FirestoreUseCase get instance => _instance;
  final firestore = FirebaseFirestore.instance;

  Future<T?> getFirestoreUseCase<T>(
      {FirestoreUseCaseType? usecaseType,
      required FirebaseRequest request}) async {
    final collectionUser = firestore.collection('Users');
    final collectionProduct = firestore.collection('Products');
    final email = await AppPrefs.getEmail();
    switch (usecaseType) {
      case FirestoreUseCaseType.getUser:
        final data = await collectionUser.doc(email).get();
        return data.data() as T;
      case FirestoreUseCaseType.getActivity:
        final data = await collectionUser
            .doc(email)
            .collection('Activity')
            .doc('Transaction')
            .get();
        return data.data() as T;
      case FirestoreUseCaseType.getProduct:
        final snapshot = await collectionProduct.doc(email).get();

        return snapshot.data() as T;
      case FirestoreUseCaseType.getCustomers:
        final data = await collectionUser
            .doc(email)
            .collection('Customers')
            .doc('customers')
            .get();
        return data.data() as T;
      default:
        return null;
    }
  }

  Future<T?> postFirestoreUseCase<T>(
      {FirestoreUseCaseType? usecaseType,
      AuthUserModels? user,
      required FirebaseRequest request,
      String? username,
      String? dateofBirth}) async {
    final collectionUser = firestore.collection('Users');
    final collectionProducts = firestore.collection('Products');
    switch (usecaseType) {
      case FirestoreUseCaseType.postUser:
        final data = await collectionUser.doc(user?.email).set(user!.toJson(
              username: username,
              dateofBirth: dateofBirth,
            ));
        return data as T;
      case FirestoreUseCaseType.postActivity:
        final email = await AppPrefs.getEmail();
        final collectionActivity =
            collectionUser.doc(email).collection('Activity');

        final DocumentReference activitytDocRef =
            collectionActivity.doc('Transaction');

        final existingData = await activitytDocRef.get();

        if (existingData.exists) {
          final existingActivity = existingData.data() as Map<String, dynamic>;

          int newId = 1;
          if (existingActivity['activity'] != null) {
            final lastProduct = existingActivity['activity'].last;
            final lastProductId = lastProduct['id'];
            newId = (lastProductId ?? 0) + 1;
          }

          final updatedActivity = existingActivity['activity'] ?? [];
          final Map<String, dynamic> newProduct = {
            ...request.params!,
            'id': newId,
          };
          updatedActivity.add(newProduct);

          final snapshot = await activitytDocRef.update({
            'activity': updatedActivity,
          });
          return snapshot as T;
        } else {
          final newActivity = {
            ...request.params!,
            'id': 1,
          };

          final snapshot = await activitytDocRef.set({
            'activity': [newActivity]
          }, SetOptions(merge: true));
          return snapshot as T;
        }
      case FirestoreUseCaseType.postProduct:
        final email = await AppPrefs.getEmail();

        final DocumentReference productDocRef = collectionProducts.doc(email);

        final existingData = await productDocRef.get();
        final int timestamp = DateTime.now().millisecondsSinceEpoch;

        XFile? image = request.params?['image_url'];
        String downloadURL = '';
        if (image != null) {
          Reference storageRef = FirebaseStorage.instance
              .ref(email)
              .child('products/$timestamp.jpg');
          await storageRef.putFile(File(image.path));
          downloadURL = await storageRef.getDownloadURL();
        }

        if (existingData.exists) {
          final existingProducts = existingData.data() as Map<String, dynamic>;

          int newId = 1;
          if (existingProducts['products'] != null) {
            final lastProduct = existingProducts['products'].last;
            final lastProductId = lastProduct['id'];
            newId = (lastProductId ?? 0) + 1;
          }

          final updatedProducts = existingProducts['products'] ?? [];
          final Map<String, dynamic> newProduct = {
            ...request.params!,
            'id': newId,
            'image_url': downloadURL,
          };
          updatedProducts.add(newProduct);

          final snapshot = await productDocRef.update({
            'products': updatedProducts,
          });
          return snapshot as T;
        } else {
          final newProduct = {
            ...request.params!,
            'id': 1,
            'image_url': downloadURL,
          };

          final snapshot = await productDocRef.set({
            'products': [newProduct]
          }, SetOptions(merge: true));
          return snapshot as T;
        }

      case FirestoreUseCaseType.postCustomers:
        final email = await AppPrefs.getEmail();
        final collectionCustomers =
            collectionUser.doc(email).collection('Customers');
        final DocumentReference customersDocRef =
            collectionCustomers.doc('customers');

        final existingData = await customersDocRef.get();

        if (existingData.exists) {
          final existingCustomers = existingData.data() as Map<String, dynamic>;

          int newId = 1;
          List<dynamic> updatedCustomers = [];
          DateTime now = DateTime.now();
          String payDate = now.toLocal().toString().split(' ')[0];

          if (existingCustomers['customers'] != null) {
            updatedCustomers = List.from(existingCustomers['customers']);

            final String newCustomerName = request.params!['name'];

            for (var customer in updatedCustomers) {
              if (customer['name'] == newCustomerName) {
                customer['last_order'] = payDate;
                customer.addAll(request.params!);
                return await customersDocRef.update({
                  'customers': updatedCustomers,
                }) as T;
              }
            }

            final lastCustomers = existingCustomers['customers'].last;
            final lastCustomersId = lastCustomers['id'];
            newId = (lastCustomersId ?? 0) + 1;
          }

          final Map<String, dynamic> newCustomers = {
            ...request.params!,
            'id': newId,
          };
          updatedCustomers.add(newCustomers);

          final snapshot = await customersDocRef.update({
            'customers': updatedCustomers,
          });
          return snapshot as T;
        } else {
          final newCustomers = {
            ...request.params!,
            'id': 1,
          };

          final snapshot = await customersDocRef.set({
            'customers': [newCustomers]
          }, SetOptions(merge: true));
          return snapshot as T;
        }

      default:
        return null;
    }
  }

  Future<T?> putFirestoreUseCase<T>(
      {FirestoreUseCaseType? usecaseType,
      required FirebaseRequest request}) async {
    final collectionUser = firestore.collection('Users');
    final email = request.params?['email'];
    final displayName = request.params?['display_name'];
    final phoneNumber = request.params?['phone_number'];

    switch (usecaseType) {
      case FirestoreUseCaseType.putUser:
        final int timestamp = DateTime.now().millisecondsSinceEpoch;

        XFile? image = request.params?['image_url'];
        String downloadURL = '';
        if (image != null) {
          Reference storageRef = FirebaseStorage.instance
              .ref(email)
              .child('products/$timestamp.jpg');
          await storageRef.putFile(File(image.path));
          downloadURL = await storageRef.getDownloadURL();
        }
        final data = await collectionUser.doc(email).update({
          'photo_url': downloadURL,
          "display_name": displayName,
          "phone_number": phoneNumber,
        });
        return data as T;
      case FirestoreUseCaseType.puActivity:
        final email = await AppPrefs.getEmail();
        final collectionActivity =
            collectionUser.doc(email).collection('Activity');

        final int activityId = request.params!['id'];
        final DocumentReference activityDocRef =
            collectionActivity.doc('Transaction');

        final existingData = await activityDocRef.get();

        if (existingData.exists) {
          final existingActivity = existingData.data() as Map<String, dynamic>;
          final List<Map<String, dynamic>> updatedActivity =
              List<Map<String, dynamic>>.from(
                  existingActivity['activity'] ?? []);

          int indexOfActivityToUpdate = -1;
          for (int i = 0; i < updatedActivity.length; i++) {
            if (updatedActivity[i]['id'] == activityId) {
              indexOfActivityToUpdate = i;
              break;
            }
          }

          if (indexOfActivityToUpdate != -1) {
            updatedActivity[indexOfActivityToUpdate]['cash'] =
                request.params!['cash'];
            updatedActivity[indexOfActivityToUpdate]['refund_amount'] =
                request.params!['refund_amount'];
            updatedActivity[indexOfActivityToUpdate]['is_pay'] =
                request.params!['is_pay'];

            final snapshot = await activityDocRef.update({
              'activity': updatedActivity,
            });

            return snapshot as T;
          } else {
            return null;
          }
        } else {
          return null;
        }
      default:
        return null;
    }
  }

  Future<T?> deleteFirestoreUseCase<T>(
      {FirestoreUseCaseType? usecaseType,
      required FirebaseRequest request}) async {
    final collectionUser = firestore.collection('Users');
    final collectionProducts = firestore.collection('Products');
    final collectionCustomers = firestore.collection('Customers');
    final email = await AppPrefs.getEmail();
    switch (usecaseType) {
      case FirestoreUseCaseType.deleteUser:
        final data = await collectionUser.doc(email).delete();
        return data as T;
      case FirestoreUseCaseType.deleteProduct:
        final String productId = request.params?['id'] as String;

        final email = await AppPrefs.getEmail();
        final DocumentReference productDocRef = collectionProducts.doc(email);

        final existingData = await productDocRef.get();
        if (existingData.exists) {
          final existingProducts = existingData.data() as Map<String, dynamic>;

          final updatedProducts = List<Map<String, dynamic>>.from(
              existingProducts['products'] ?? []);
          updatedProducts.removeWhere((product) => product['id'] == productId);
          final snapshot = await productDocRef.update({
            'products': updatedProducts,
          });
          return snapshot as T;
        } else {
          return null;
        }
      case FirestoreUseCaseType.deleteActivity:
        final data = await collectionUser
            .doc(email)
            .collection('Activity')
            .doc('activity')
            .delete();
        return data as T;
      case FirestoreUseCaseType.deleteCustomers:
        final carts = collectionCustomers.doc(email).delete();
        return carts as T;
      default:
        return null;
    }
  }
}
