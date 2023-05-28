import 'package:finalgpt/components/mydrawer.dart';
import 'package:finalgpt/models/apimodel.dart';
import 'package:finalgpt/pages/coverlater.dart';
import 'package:finalgpt/pages/scrappafe.dart';
import 'package:finalgpt/pages/sppechtotext.dart';
import 'package:finalgpt/pages/testdisplay.dart';
import 'package:finalgpt/pages/userprofile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController promptEntered = TextEditingController();
  final url = 'https://api.openai.com/v1/chat/completions';
  final String token =
      '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'; // Replace with your authorization token

  String store = "chirag";

  Map<String, dynamic> jsondatastored = {};


  bool isPressed = false;

  Future<String> sendPostRequest() async {
    final Map<String, dynamic> requestBody = {
       

      'model': 'gpt-3.5-turbo',
      
      'messages': [
        //  {
        //   'role': 'system',
        //   'content':"create resume for given role",
        // },
        {
          'role': 'user',
          'content': promptEntered.text,
        },
      ],
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        jsondatastored = responseBody;

        print(jsondatastored);

        store = responseBody.toString();

      } else {
        print('POST request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred during POST request: $e');
    }

    // print(store);
    return store;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey.shade600,
          appBar: AppBar(
            title: const Text("Generative Gen "),
            actions: [
    
             

              IconButton(onPressed: (){
                Get.to(UserGithubStatsScreen());
              }, icon: FaIcon(FontAwesomeIcons.github)),


               IconButton(onPressed: (){
                Get.to(UserProfileScreen());
              }, icon: FaIcon(FontAwesomeIcons.user)),

            ],
          ), 
    
    
          drawer:MyDrawer(),
    
          body: Center(
            child: SingleChildScrollView(
              child: FutureBuilder(
              future: sendPostRequest(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Center(
                      child: Transform.scale(
                        scale: 2.5,
                        child: Column(
                          children: [
                            CircularProgressIndicator(color: Colors.orange,),
                            SizedBox(height: 16.0),
                            Center(
                              child: Text("Jarvis is Working ",
                                style: TextStyle(
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                          ); // Show a loading indicator while waiting for the response
                } else if (snapshot.hasError) {
                  return Text(
                      'Error: ${snapshot.error}'); // Show an error message if an error occurred
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [




                        SizedBox(height: 130.0,),
                        Container(
                        padding:const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                          height: MediaQuery.of(context).size.height *0.09,
                          width: MediaQuery.of(context).size.width *0.9,
              
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(21.0),
                            color: Colors.grey.shade200
                          ),
                          child: ListTile(
                            title: TextField(
                              controller: promptEntered,
                              decoration:
                                  const InputDecoration(hintText: "Enter Your Prompt Here"),
                            ),
              
                            trailing:  IconButton(onPressed: (){
                                setState(() {
                                  Text(promptEntered.text);

                                  isPressed = true;

                                });
                        }, icon: const Icon(Icons.send)), 
                          ),
                        ),
                  
                        SizedBox(height: 30,),
                    
                        Visibility(
                          visible: isPressed,
                          child: Text("${jsondatastored['choices'][0]['message']['content']}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),)
              
                  ])); // Display the response data on the screen
                }
              },
            )),
          ),


          ),

          

    );
  }
}




