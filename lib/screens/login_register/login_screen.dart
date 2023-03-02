
import 'package:bookshop/screens/login_register/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../home/home_screen.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _passwordVisible = false;

  var email;
  var password;

  final _formKey = GlobalKey<FormState>(); // create a GlobalKey for the Form widget
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  userLogin() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print(userCredential);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromRGBO(227, 183, 165, 1.0),
          content: Text(
            "Welcome to Flamingo",
            style: TextStyle(fontSize: 19),
          )));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No User fond for this E-mail");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "No User Found for this Email",
              style: TextStyle(fontSize: 19),
            )));
      }

    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/oh.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 230),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.displaySmall,
                  children: [

                    TextSpan(
                      text: "Log",
                    ),
                    TextSpan(
                      text: "in.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Form(
                key: _formKey,
                child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(213, 194, 194, 1.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your email",
                        prefixIcon: Icon(Icons.mail_outline_outlined),
                      ),
                      controller: _emailController,
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Email";
                        } else if (!value.contains("@")) {
                          return "Please enter valid email";
                        }
                        return null;
                      }),

                    )
                ),
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
                    ),
              ),
              SizedBox(
                height: 80,
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
                        });
                        userLogin();
                      } Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:  Color.fromRGBO(182, 156, 154, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),

                        )
                    ),
                    child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 20),)),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push( context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                },
                child: RichText(
                  text: TextSpan(
                    text: "Dont have account? ",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    children: [
                      TextSpan(
                        text: "Sign Up!",
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 18,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
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
    );
  }
}
