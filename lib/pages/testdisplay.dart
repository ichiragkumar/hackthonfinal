import 'dart:convert';

import 'package:finalgpt/pages/finalresume.dart';
import 'package:finalgpt/pages/scrappafe.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';


class UserDetailsScreen extends StatelessWidget {
  final String username;
  late String storeusername = "";




  UserDetailsScreen({required this.username});

  @override
  Widget build(BuildContext context) {


  storeusername = username;
  print(storeusername);

  // TextEditingController roleofUser = TextEditingController();

  Future<Map<String, dynamic>> fetchUserDetails(String username) async {
  
  
  final url = Uri.parse('https://api.github.com/users/$username');
  print(url);
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final userDetails = json.decode(response.body);
    return userDetails;
  } else {
    throw Exception('Failed to retrieve user details');
  }

  
}


    return Scaffold(
      appBar: AppBar(
        title: Text(username),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchUserDetails(username),
        builder: (context, snapshot){
          if (snapshot.hasData) {
            final userDetails = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text('Username: ${userDetails["login"]}'),
                  // Text('Name: ${userDetails["name"]}'),
                  // Text('Bio: ${userDetails["bio"]}'),
                  // Text('Repository url: ${userDetails["repos_url"]}'),
                  // Text("${userDetails}"),
                  // Text('Allollowers: ${userDetails["followers"]}'),
                  // Text('Bio: ${userDetails["following"]}'),
                  // Text('Bio: ${userDetails["received_events_url"]}'),


                  Text("${userDetails["login"]}"),

                  Container(
                    height:MediaQuery.of(context).size.height *0.2,
                    width:MediaQuery.of(context).size.width *0.7,
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(40.0),
                      color: Colors.grey.shade500.withOpacity(0.7)
                    ),
                    child: Center(child: Image.network("${userDetails["avatar_url"]}", fit: BoxFit.cover,))),

                    SizedBox(height: 30.0,),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      width: MediaQuery.of(context).size.width *0.8,
                      height: MediaQuery.of(context).size.height *0.1,


                      decoration: BoxDecoration(

                      color: Colors.grey.shade400.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(28.0)
                      ),


                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children:[
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                               children: [
                                 IconButton(
                                  onPressed: (){},
                                  icon:Icon(Icons.read_more, size: 40,), color: Colors.red,),

                                  Text("${userDetails["followers"]}"),
                               ],
                             ),
                           ),



                            Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                               children: [
                                 IconButton(
                                  onPressed: (){},
                                  icon:FaIcon(FontAwesomeIcons.react, size: 40,color: Colors.green,), color: Colors.red,),


                                  Text("${userDetails["following"]}"),

                               ],
                             ),
                           ),


                            Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                               children: [
                                 IconButton(
                                  onPressed: (){},
                                  icon:FaIcon(FontAwesomeIcons.git, size: 40,color: Colors.black,), color: Colors.red,),

                                  Text("${userDetails["public_repos"]}"),
                                  
                               ],
                             ),
                           ),


                          
                        ]
                          
                      ),
                    ),

                    SizedBox(height: 170.0,),



                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.1,
                      width: MediaQuery.of(context).size.width*0.9, 
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(29.0)
                      ),
                      child: TextButton(onPressed: (){
                          print(storeusername);
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResumeGeneratorScreen(storeusername2:storeusername),
                        ),
                      );
                      }, child: Text("Generate Resume", style: TextStyle(fontSize: 24.0),)),
                    ),
                  )                  
                  // Display other desired user details
                ],
              ),
            );
             } else if (snapshot.hasError) {
            return Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(88.0),
                child:  SingleChildScrollView(
                       child: Column(
                         children: [
                           Padding(
                             padding: const EdgeInsets.all(24.0),
                             child: Center(child:  Text('Error: \n${snapshot.error}.', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
                           ),
                                     
                           Lottie.asset("assets/githuberror.json"),


                            Container(
                            height: MediaQuery.of(context).size.height *0.08,
                            width: MediaQuery.of(context).size.width *0.9,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(29.0),
                              border: Border.all(width: 2, color: Colors.grey.shade200)
                             ),
                             child: Center(child:  ListTile(
                              title: TextButton(onPressed: (){
                                Get.to(
                                  UserGithubStatsScreen()
                                );
                              }, child: Text("Back To", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),)),

                              trailing: FaIcon(FontAwesomeIcons.backward),
                             )
                             )),
                        ],
                       )
                )
              )
            );
  }
  return CircularProgressIndicator();
        }
      ));

  }
}





