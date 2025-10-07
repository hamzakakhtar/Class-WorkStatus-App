import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'students-screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  var _hightWidth=double.infinity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title:  Text('Assignment Dashboard',style: TextStyle(color: Colors.white),),
      centerTitle: true,
      backgroundColor: Colors.blue,),

      floatingActionButton: FloatingActionButton(
        child:  Icon(Icons.people,color: Colors.white,),backgroundColor: Colors.blue,
        onPressed: () => Get.to(() => StudentsScreen()),
      ),

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
        Expanded(child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('data').snapshots(),
            builder: (context,snapshot){
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                    final doc = snapshot.data!.docs[index];
                    final name = doc['name'] ?? '';
                    final status = doc['workStatus'] ?? 'incomplete';
                  return Card(
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          Expanded(child: Text(name,style: TextStyle(fontSize: 20,color: Colors.blue),)),
                          status=="complete"?Icon(Icons.check,color: Colors.green,size: 40,):Icon(Icons.close,color: Colors.red,size: 40,)
                        ],
                      ),
                    )
                  );
                  },

              );
            })
        )],
            )
      )
    );
  }
}
