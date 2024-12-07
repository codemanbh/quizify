import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizify/pages/AllQuizQuestionsPage.dart';
import 'package:quizify/pages/SignupPage.dart';

class loginPage extends StatefulWidget {
  loginPage({super.key});

  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController EmailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  String? errorMessage; // To display login error message

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _forgotPassword(context),
              if (errorMessage != null) _errorMessage(context), // Display error
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome to login page",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Please enter your email and password"),
      ],
    );
  }

  _inputField(context) {
    return Form(
      key: _formKey, // Attach the form key
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.email),
            ),
            controller: EmailCtrl,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email cannot be empty";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.password),
            ),
            controller: passwordCtrl,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password cannot be empty";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Form is valid, perform login
                validate(EmailCtrl.text, passwordCtrl.text, context);
              }
            },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.purple,
            ),
            child: const Text(
              "Login",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Colors.purple),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignupPage()),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.purple),
          ),
        )
      ],
    );
  }

  _errorMessage(context) {
    return Text(
      errorMessage ?? "",
      style: const TextStyle(color: Colors.red, fontSize: 16),
    );
  }

  void validate(String mail, String pass, BuildContext context) async {
    try {
      AuthService authSrv = AuthService();
      User? user = await authSrv.signIn(mail, pass);
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AllQuizQuestionsPage()),
        );
      } else {
        setState(() {
          errorMessage = "The email or password is incorrect";
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        errorMessage = "An error occurred. Please try again.";
      });
    }
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Check if the user is signed in
  User? get currentUser => _auth.currentUser;

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Error in signIn: ${e.message}");
      return null;
    }
  }
}
