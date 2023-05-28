import 'package:flutter/material.dart';



import 'dart:convert';

import 'package:finalgpt/pages/scrappafe.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';



// for resume genearator

class ResumeGeneratorScreen extends StatefulWidget {
  final String storeusername2;

  ResumeGeneratorScreen({required this.storeusername2});


  @override
  State<ResumeGeneratorScreen> createState() => _ResumeGeneratorScreenState();
}

class _ResumeGeneratorScreenState extends State<ResumeGeneratorScreen> {


  TextEditingController mainController = TextEditingController();
  

// for resume generator
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
          'content': 'Your ${mainController.text} is . Your task is to generate the resume for the given user. The username is taken up from GitHub and generates the brief details as follows<content>Name: in Bold FormatJob Role: Bio: Upto 100 wordsWork Experience:Education:Achievements/Certifications:Project:</content>',
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
      appBar: AppBar(title: Text("Generating Resume ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),),



      body:  Center(
            child: SingleChildScrollView(
              child: FutureBuilder(
              future: sendPostRequest(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Center(
                      child: Transform.scale(
                        scale: 4.5,
                        child: Column(
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



                Container(
                   height: MediaQuery.of(context).size.height *0.1,
                    width: MediaQuery.of(context).size.width *0.9,
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400.withOpacity(0.3),
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(28.0)
                    ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:18.0),
                    child: TextField(
                      controller: mainController,
                      decoration: InputDecoration(
                                  
                        icon: FaIcon(FontAwesomeIcons.git),
                        hintText: "Enter Github User name"
                                  
                      ),
                                  
                    ),
                  ),
                ),


                SizedBox(height: 40,),
          
                  Container(
                     width: MediaQuery.of(context).size.width*0.9,
                    margin: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
                    child: TextButton(onPressed: (){
                       setState(() {
                      isPressed= true;
                      });
                  
                    }, 
                    child:Container(
                      child: const  Text("Generate Resume With AI", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),))),
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