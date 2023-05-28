import 'package:finalgpt/pages/finalresume.dart';
import 'package:finalgpt/pages/testdisplay.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lottie/lottie.dart';



class UserGithubStatsScreen extends StatefulWidget {
  const UserGithubStatsScreen({super.key});

  @override
  State<UserGithubStatsScreen> createState() => _UserGithubStatsScreenState();
}

class _UserGithubStatsScreenState extends State<UserGithubStatsScreen> {
 
   TextEditingController _usernameController = TextEditingController();


  Future<Map<String, dynamic>> fetchUserDetails(String username) async {
  final url = Uri.parse('https://api.github.com/users/$username');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final userDetails = json.decode(response.body);
    return userDetails;
  } else {
    throw Exception('Failed to retrieve user details');
  }
}

  void _submitUsername() {


    String username = _usernameController.text.trim();
    
  
    // Pass the username to the next screen or perform desired actions
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailsScreen(username: username),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [


              Lottie.asset("assets/github.json"),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),

      
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
      
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 1,
      
                  decoration: BoxDecoration(
      
                    color: Colors.grey.shade300.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(28.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListTile(
                      title: TextField(
                        
                        controller: _usernameController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200)),
                                  
                          icon: FaIcon(FontAwesomeIcons.userAstronaut),
                          
                          labelText: 'GitHub Username',
                        ),
                      ),
      
                      trailing:  IconButton(
                        onPressed: _submitUsername,
                        icon: FaIcon(FontAwesomeIcons.share),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
             
               ],
          ),
        ),
      ),
    );

  
  }
}