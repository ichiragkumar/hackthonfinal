import 'package:finalgpt/pages/scrappafe.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:finalgpt/pages/userprofile.dart';

import '../pages/coverlater.dart';



class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
            backgroundColor: Colors.grey.shade300,
            child: ListView(children:
             [
    
                UserAccountsDrawerHeader(
                  accountName: const Text("Faizan"), accountEmail: Text("Faizan@dev.com"),
                  decoration: BoxDecoration(
                    color: Colors.green.shade800
                  ),
    
                  currentAccountPicture: Lottie.asset("assets/useraccount.json")
                  ),



                   SizedBox(height: 15,),

                  ListTile(
                    onTap: () => Get.to(CoverLaterScreen()),
                    tileColor: Colors.grey.shade100,

                    leading: FaIcon(FontAwesomeIcons.fileSignature),
                    title: Text("Generate Cover Later", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
                  ),

                  SizedBox(height: 15,),

                  Divider(height: 3,indent: 20, endIndent: 10,color: Colors.grey,),


                  SizedBox(height: 20,),
                  ListTile(
                    onTap:() => Get.to(UserGithubStatsScreen()),
                    tileColor: Colors.grey.shade100,

                    leading: FaIcon(FontAwesomeIcons.layerGroup),
                    title: Text("Generate Resume", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
                  ),

                  SizedBox(height: 20,),

                  Divider(height: 3,indent: 20, endIndent: 10,color: Colors.grey,),
                  




    
            ]
            
            ),
    
          )
    ;
  }
}