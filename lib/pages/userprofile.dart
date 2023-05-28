import 'package:finalgpt/components/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  TextEditingController nameuser = TextEditingController();
  TextEditingController emailUser = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.9),


        drawer:MyDrawer(),
        
    
        body: Container(
    
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
    
              children: [
    
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:58.0, vertical: 18.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                  
                        color: Colors.grey..withOpacity(0.9),
                        borderRadius: BorderRadius.circular(48.0),
                        border: Border.all(color: Colors.black.withOpacity(0.7), width: 2),
                        boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 2,
                          offset: Offset(0, 3), // changes the position of the shadow
                        ),
                      ],
                      ),
                  
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: CircleAvatar(
                          radius: 35,
                          child: Lottie.asset("assets/useraccount.json"),
                        ),
                      ),
                    ),
                  ),



                  Container(

                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                    ),
                    child: TextField(
                      style: TextStyle(fontSize: 20, color: Colors.black),

                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade800)),
                        hintText: "Name"
                      ),
                    ),
                  ),


                   Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                    ),
                    child: TextField(
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade800)),
                        hintText: "Email"
                      ),
                    ),
                  ),




                    Padding(
                      padding: const EdgeInsets.only(top:18.0),
                      child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(onPressed: (){}, 
                      child: const Text('Register', 
                      style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold, 
                      color: Colors.black),))
                                      ),
                    ),





              ],
          
              
            ),
          ),
        ),
      ),
    );
  }
}