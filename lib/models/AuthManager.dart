import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizify/pages/SignupPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> fetchUserRole() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        DocumentSnapshot doc =
            await _firestore.collection('users').doc(user.uid).get();

        if (doc.exists) {
          if (doc.get('role') == "Student") {
            return 'Student';
          } else if (doc.get('role') == "Admin") {
            return 'Admin';
          }
        }
      }
    } catch (e) {
      print("Error fetching user role: $e");
    }
    return null;
  }
}
