import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:http/http.dart'  as http;

import 'finalcoverlatr.dart';

class CoverLaterScreen extends StatefulWidget {
  const CoverLaterScreen({super.key});

  @override
  State<CoverLaterScreen> createState() => _CoverLaterScreenState();
}

class _CoverLaterScreenState extends State<CoverLaterScreen> {


  TextEditingController nameofUser = TextEditingController();
  TextEditingController roleofUser = TextEditingController();
  TextEditingController experienceofUser = TextEditingController();



  final url = 'https://api.openai.com/v1/chat/completions';
  final String token =
      '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'; // Replace with your authorization token

  String store = "coverlater";

  Map<String, dynamic> jsondatastored = {};
  
  
  bool isPressed=false;
  Future<String> sendPostRequest() async {
    final Map<String, dynamic> requestBody = {
       

      'model': 'gpt-3.5-turbo',
      
      'messages': [
         {
          'role': 'system',
          'content':"Your Name is ${nameofUser.text}. Your task is to generate the Cover Letter from the GitHub ${nameofUser.text}. The username is taken up from GitHub and generates the brief details for the cover letter which contains the parameters as Name, ${roleofUser.text}, Bio <content>${nameofUser.text}: in Bold Letters${roleofUser.text}:Work ${experienceofUser.text}:Achievements/Certifications</content>"
        }
        // {
        //   'role': 'user',
        //   'content': roleofUser.text,
        // },
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
    return SafeArea(child: 
    
    
    Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(title:Text(nameofUser.text)),



      body:  Center(
            child: SingleChildScrollView(
              child: FutureBuilder(
              future: sendPostRequest(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Center(
                      child: Transform.scale(
                            scale: 4.5,
                            child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(color: Colors.green,),
                          SizedBox(height: 16.0),
                          Text("AI Mode on\n....HoLd On ",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                            )

                          )); // Show a loading indicator while waiting for the response
                } else if (snapshot.hasError) {
                  return Text(
                      'Error: ${snapshot.error}'); // Show an error message if an error occurred
                } else {

          return Padding(
            padding: const EdgeInsets.all(38.0),
            child: Column(
              children: [
          
          
                   TextField(
                    controller: nameofUser,
                    decoration: InputDecoration(
                      hintText: "Name"
                  
                    ),
                  ),
                  
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: roleofUser,

                    decoration: InputDecoration(
                      hintText: "Role"
                  
                    ),
                  ),
                  
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: experienceofUser,
                    decoration: InputDecoration(
                      hintText: "Experience"
                      
                    ),
                  ),
          
          
          
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width *0.8,
                      height: MediaQuery.of(context).size.height*0.1,
                  
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3)
                      ),
                      child:  TextButton(onPressed: (){
                           setState(() {
                      
                          // var sv = "${jsondatastored['choices'][0]['message']['content']}";
                          // Map<String, dynamic> jsonMap = jsonDecode(sv);
                          isPressed= true;
                          
                          });
                      
                        }, child: Text("Generate Cover  Later")),
                      
                    ),
                  ),


                Visibility(
                  visible: isPressed,
                  child: Text("${jsondatastored['choices'][0]['message']['content']}", style: TextStyle(fontSize: 20),))  
                  
              ],
                

                
            ),
          );
                }
              } 
        ),


      ),
      
      )));
  }
}



