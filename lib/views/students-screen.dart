import 'package:class_attendence_app/controllers/student-controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home-controller.dart';

class StudentsScreen extends StatelessWidget {

  final String todayDate =
      "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";

  StudentsScreen({super.key});
  var _hightWidth=double.infinity;
  @override
  Widget build(BuildContext context) {
    StudentController studentController=Get.put(StudentController());
    return Scaffold(
      appBar: AppBar(title:  Text("Manage Students",style: TextStyle(color: Colors.white),),
      centerTitle: true,
      backgroundColor: Colors.blue,),

      body: Container(
        height:_hightWidth ,
        width: _hightWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [
            Colors.blueGrey,
                Colors.blueGrey,
                Colors.blueGrey.shade500,
                Colors.blueGrey.shade400,
                Colors.blueGrey.shade300,
                Colors.grey
              ])
        ),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: studentController.nameController,
                      decoration: InputDecoration(
                        hintText: 'Student name',
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: (){
                    studentController.addStudents();
                  }, child: Text('Add'))
                ],
              ),
            ),
            Divider(),
            Expanded(child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('data').snapshots(),
                builder: (context,snapshot){
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index){
                      String id=snapshot.data!.docs[index]['id'];
                        final name=snapshot.data!.docs[index]['name'];
                        return Card(
                          shadowColor: Colors.black,
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            child: Obx(()=>Row(
                              children: [
                                SizedBox(width: 10,),
                                Expanded(child: Text(name,style: TextStyle(fontSize: 20,color: Colors.blue),)),
                                 IconButton(onPressed: ()async{
                                   await FirebaseFirestore.instance.collection('data').doc(id).delete();
                                                                 }, icon: Icon(Icons.delete,color: Colors.red,)),
                                IconButton(onPressed: (){
                                  studentController.complete(id);
                                }, icon: Icon(Icons.check,color: Colors.green,)),
                                IconButton(onPressed: (){
                                  studentController.incomplete(id);
                                }, icon:Icon(Icons.close,color: Colors.red,),)
                              ],
                            ),)
                          ),
                        );
                      }
                  );
                }))
          ],
        ),
      ),
    );
  }
}
