import 'dart:io';
import 'dart:typed_data';
import 'package:finalgpt/pages/testview.dart';

import 'package:get/get.dart';



import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'coverlater.dart';

import 'package:flutter/material.dart';




class FinalCoverLater extends StatefulWidget {
    final Map<String, dynamic> jsonMap;
    FinalCoverLater({required this.jsonMap});

  @override
  State<FinalCoverLater> createState() => _FinalCoverLaterState();
}

class _FinalCoverLaterState extends State<FinalCoverLater> {

  
 
  @override
  Widget build(BuildContext context) {
    final jsonData = widget.jsonMap;

    print(jsonData);


    return Scaffold(
      backgroundColor: Colors.grey.shade200,


      appBar: AppBar(),

      drawer: Drawer(),


      body:  SingleChildScrollView(

          child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 1,
              margin: EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                border: Border.all(color: Colors.grey, width: 2)
                

              ),
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Text("${jsonData['choices'][0]['message']['content']}"),
              ))  

        ]),

        ),


      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ListTile(
        leading: FloatingActionButton(
          onPressed: (){
          },
          child: FaIcon(FontAwesomeIcons.download),
        ),
        subtitle: FloatingActionButton(
          onPressed: () {
            // Action to be performed when FAB is pressed
          },
          child: FaIcon(FontAwesomeIcons.share),
        ),
      ),
    
    );
  }
}
