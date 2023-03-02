
import 'dart:developer';

import 'package:bookshop/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  var email = "";
  var password = "";
  var confirmpassword = "";

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  registration() async {
    if (password == confirmpassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print(UserCredential);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.blue,
            content: Text(
              "Reistration Successfully.. Please Log-in",
              style: TextStyle(fontSize: 19),
            )));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } on FirebaseAuthException catch (e) {
        if (e.code == "weak-password") {
          print("Password is too weak");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Password is too weak",
                style: TextStyle(fontSize: 19),
              )));
        } else if (e.code == "email-already-in-use") {
          print("Account already exist");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Account already exist",
                style: TextStyle(fontSize: 19),
              )));
        }
      }
    } else {
      print("Password and confirm Password does not match");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Password and confirm Password does not match",
            style: TextStyle(fontSize: 19),
          )));
    }
  }

  String radioClickedValue = "";
  bool? checkBoxValue1 = false;
  bool? checkBoxValue2 = false;

  // ignore: unused_elementa
  _handleGoogleBtnClick() {
    _signInWithGoogle().then((user) {
      log('\nUser: ${user.user} ');
      log('\nUserAdditionalInfo: ${user.additionalUserInfo} ');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  Future<UserCredential> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/oh.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.displaySmall,
                    children: [

                      TextSpan(
                        text: "Sign",
                      ),
                      TextSpan(
                        text: "up.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(213, 194, 194, 1.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your email",
                        prefixIcon: Icon(Icons.mail_outline_outlined),

                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    )
                ),

                SizedBox(
                  height: 30,
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(213, 194, 194, 1.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your password",
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            child: Icon(
                              _passwordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 8){
                          return 'Password must be 8 characters';
                        }
                        return null;
                      },
                    )
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(213, 194, 194, 1.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      controller: _confirmpasswordController,
                      obscureText: !_passwordVisible,
                      decoration:  InputDecoration(
                        border: InputBorder.none,
                        hintText: "Confirm your password",
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          child: Icon(
                            _passwordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        )
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    )
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  height: 40,
                  width: 150,
                  child: ElevatedButton(
                      onPressed: (){
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            email = _emailController.text;
                            password = _passwordController.text;
                            confirmpassword = _confirmpasswordController.text;
                          });
                          registration();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:  Color.fromRGBO(182, 156, 154, 1.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),

                          )
                      ),
                      child: Text("Signup", style: TextStyle(color: Colors.white, fontSize: 20),)),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push( context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      children: [
                        TextSpan(
                          text: "Login!",
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 18,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                            },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
