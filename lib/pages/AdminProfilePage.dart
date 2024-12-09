import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizify/pages/LoginPage.dart';
import '../components/AdminCustomNavBar.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});

  @override
  _AdminProfilePageState createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? userName = "Loading...";
  String? email = "Loading...";
  String? role = "Loading...";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    FetchName();
  }

  Future<void> FetchName() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        DocumentReference doc = _firestore.collection("users").doc(user.uid);

        doc.get().then((value) {
          setState(() {
            userName = value.get('name');
            email = value.get('email');
            role = value.get('role');
            isLoading = false;
          });
        }).catchError((e) {
          print("Error fetching user name: $e");
          setState(() {
            userName = "Error fetching name";
            isLoading = false;
          });
        });
      } else {
        setState(() {
          userName = "User not logged in";
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching user name: $e");
      setState(() {
        userName = "Error fetching name";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AdminCustomNavBar(page_url: '/adminProfilePage'),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  child: Card(
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.antiAlias,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'assets/mountain.jpg',
                          fit: BoxFit.cover,
                        ),
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                        
                              Card(
                                shape: CircleBorder(),
                                clipBehavior: Clip.antiAlias,
                                child: Image.asset(
                                  'assets/anonymous.jpg',
                                  fit: BoxFit.cover,
                                  width: 175,
                                  height: 175,
                                ),
                              ),
                           
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  "Username: $userName",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "email: $email",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Role: $role",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                    onPressed: () {
                      signOut(context);
                    },
                    child: Text(
                      "SignOut",
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ))
              ],
            ),
    );
  }
}

Future<void> signOut(BuildContext context) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    await _auth.signOut();
    _auth.authStateChanges();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  } catch (e) {
    print("Error in signOut: ${e.toString()}");
  }
}
