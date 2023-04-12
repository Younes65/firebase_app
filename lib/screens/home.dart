import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var users = FirebaseFirestore.instance.collection('user');
  var user = FirebaseAuth.instance.currentUser!;

  void signOut ( ){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: users.doc('${user.uid}').get(),
          builder: (context , snapShot) {
          if(snapShot.connectionState==ConnectionState.done){
              var data = snapShot.data!.data();
              return Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.amber,
                    title: Text('User info '),
                    actions: [
                      IconButton(onPressed: () {
                        setState(() {
                          signOut();
                          Get.off(Login(), transition: Transition.leftToRight);
                        });
                      }, icon: Icon(Icons.logout))
                    ],
                  ),
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/avatar.jpg'),
                                fit:BoxFit.fill
                              ),
                              borderRadius: BorderRadius.circular(30)
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('${data!['name']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.black
                          ),),
                          SizedBox(
                            height:10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                              height: 2,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.phone),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Phone  :', style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                  ),
                                  ),
                                ),
                                Text('${data['phone']}',
                                    style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black
                                ),)

                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.email),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Email :', style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),
                                  ),
                                ),
                                Text('${user.email}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black
                                  ),)

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
              );
            }
            else if (snapShot.hasError) {
              return Scaffold(
                appBar: AppBar(title: Text('user')),
                body: Center(child: Text('An error occurred: ${snapShot.error}')),
              );
            }

            return Scaffold(
              body: Center(child: RefreshProgressIndicator(),) ,
            );
          }
      ),
    );
  }


}
