

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/firebase/model/user.dart';


class MyUsersFireStore extends StatefulWidget {
  const MyUsersFireStore({Key? key}) : super(key: key);

  @override
  _MyUsersFireStoreState createState() => _MyUsersFireStoreState();
}

class _MyUsersFireStoreState extends State<MyUsersFireStore> {
  TextEditingController? _name;
  TextEditingController? _mob;
  TextEditingController? _email;

  @override
  Widget build(BuildContext context) {

    _name=TextEditingController( );
    _mob=TextEditingController();
    _email=TextEditingController();
    var _keyform=GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore demo'),
      ),
      body: SafeArea(
        child: Center(
          child:Form(
            key: _keyform,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _name,
                    keyboardType: TextInputType.text,
                    validator: (value){
                      if(value!.isEmpty)
                        return 'must enter name';
                    },
                    decoration: InputDecoration(
                        labelText: 'full name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _mob,
                    keyboardType: TextInputType.phone,
                    validator: (value){
                      if(value!.isEmpty)
                        return 'must enter mobile';
                    },
                    decoration: InputDecoration(
                        labelText: 'mobile number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value){
                      if(value!.isEmpty)
                        return 'must enter email';
                    },
                    decoration: InputDecoration(
                        labelText: 'email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: TextButton.styleFrom(backgroundColor: Colors.green),
                          onPressed: (){
                            if(_keyform.currentState!.validate()) {
                              User user = User(userName: _name!.value.text,
                                  userMob: _mob!.value.text,
                                  userEmail: _email!.value.text);
                              saveData(user);
                            }
                          },
                          child: Text('Save')),
                      ElevatedButton(
                          style: TextButton.styleFrom(backgroundColor: Colors.amber),
                          onPressed: (){
                            if(_keyform.currentState!.validate()) {
                              User user = User(
                                  userMob: _mob!.value.text,
                                  userEmail: _email!.value.text);
                              updateData(user);
                            }
                          },
                          child: Text('Update')),
                      ElevatedButton(
                          style: TextButton.styleFrom(backgroundColor: Colors.red),
                          onPressed: (){
                            if(_keyform.currentState!.validate()) {
                              if(_keyform.currentState!.validate()) {
                                User user = User(userName: _name!.value.text);
                                deleteData(user);
                              }
                            }
                          },
                          child: Text('Delete')),
                    ],
                  ),
                  SizedBox(height: 25,),
                  SingleChildScrollView(
                    child: Container(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            var list=snapshot.data!.docs;
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: list.length,
                              itemBuilder: (context,index){
                                QueryDocumentSnapshot dsnapshot=snapshot.data!.docs[index];
                                return Card(
                                  child: InkWell(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(dsnapshot['userName'],style: TextStyle(color: Colors.red,fontSize: 30),),
                                        Text(dsnapshot['userMob'],style: TextStyle(color: Colors.blue,fontSize: 25),),
                                        Text(dsnapshot['userEmail'],style: TextStyle(color: Colors.green,fontSize: 25),),
                                      ],
                                    ),
                                    onTap: (){
                                      _name!.text=dsnapshot['userName'];
                                      _mob!.text=dsnapshot['userMob'];
                                      _email!.text=dsnapshot['userEmail'];

                                    },
                                  ),
                                );
                              },
                            );
                          }else if(snapshot.hasError){
                            return Center(
                              child: Container(
                                color: Colors.yellow,
                                child: Text('${snapshot.error.toString()}',style: TextStyle(color: Colors.blue,fontSize: 35),),
                              ),
                            );
                          }else{
                            return Center(child: CircularProgressIndicator(),);
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void saveData(User user) async {
    try {
      await FirebaseFirestore.instance.collection('Users')
          .doc(user.userName)
          .set(user.toMap());
    }catch(error){
      print(error.toString());
    }
  }

  void updateData(User user) async {
    try {
      await FirebaseFirestore.instance.collection('Users')
          .doc(user.userName).update(user.toMap());
    }catch(error){
      print(error.toString());
    }
  }

  void deleteData(User user) async {
    try{
      await FirebaseFirestore.instance.collection('Users')
          .doc(user.userName).delete();
    }catch(error){
      print(error.toString());
    }
  }
}