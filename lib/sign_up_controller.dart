import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  final TextEditingController firstName=TextEditingController();
  final TextEditingController lastName=TextEditingController();
  final TextEditingController number=TextEditingController();
  final TextEditingController email=TextEditingController();

  static register(String firstName,String lastName,String number,String email,String id){

    final db = FirebaseFirestore.instance;
    final user = <String, dynamic>{
      'full_name': firstName,
      'lastName':lastName,// John Doe
      'number': number, // Stokes and Sons
      'email': email,
      "id_resgister":id
    };
    print(user);
    db.collection("register_with_number").doc(id).set(user);
}
}