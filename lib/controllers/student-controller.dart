import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class StudentController extends GetxController{
  TextEditingController nameController=TextEditingController();

  addStudents()async{
    String id=DateTime.now().millisecond.toString();
    await FirebaseFirestore.instance.collection('data').doc(id).set({
      "name":nameController.text,
      'id':id,
      'workStatus':"incomplete"
    }).then((onValue){}).onError((e,handleError){});
  }

  Future<void> complete(String status) async{
    await complete('complete');
  }

  Future<void> incomplete(String status)async{
    await incomplete('incomplete');
  }
}