
import 'package:bookshop/screens/login_register/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../home/home_screen.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>(); // create a GlobalKey for the Form widget
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your password",
                      prefixIcon: Icon(Icons.remove_red_eye_outlined),
                    ),
                  )
              ),
              SizedBox(
                height: 80,
              ),
              Container(
                height: 40,
                width: 150,
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
