import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _fb = FirebaseFirestore.instance;

  void showStudents() async {
    await _fb.collection('data').snapshots();
  }
}
