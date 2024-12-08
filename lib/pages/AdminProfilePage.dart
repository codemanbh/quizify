import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizify/pages/LoginPage.dart';
import '../components/AdminCustom.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});

  @override
  _AdminProfilePageState createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? userName = "Loading..."; // Placeholder for the user name
  String? email = "Loading..."; // Placeholder for the user email
  String? role = "Loading..."; // Placeholder for the user role

  bool isLoading = true; 

  @override
  void initState() {
    super.initState();
    FetchAdminName(); // Fetch the user's name when the widget initializes
  }

  Future<void> FetchAdminName() async {
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
      bottomNavigationBar: AdminCustom(),
      body: isLoading
          ? Center(child: CircularProgressIndicator()): 
          Column(
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
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.grade_sharp, size: 40, color: Colors.white),
                              ),
                              SizedBox(width: 20), 
                              Card(
                                shape: CircleBorder(),
                                clipBehavior: Clip.antiAlias,
                                child: Image.asset(
                                  'assets/diddy.jpg',
                                  fit: BoxFit.cover,
                                  width: 175,
                                  height: 175,
                                ),
                              ),
                              SizedBox(width: 20),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.settings, color: Colors.white, size: 40),
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
                  "Email: $email", 
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Role: $role", 
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                  ElevatedButton(onPressed: (){
            signOut(context);
          }, 
          child: Text("SignOut",style: TextStyle(color: Colors.red,fontSize: 20),))
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
Navigator.pushReplacement(context,          
 MaterialPageRoute(builder: (context) => LoginPage()),
);
} catch (e) {
print("Error in signOut: ${e.toString()}");
}
}