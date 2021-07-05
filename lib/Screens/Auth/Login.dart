import 'package:centic_bids/Controllers/Authentication.dart';
import 'package:centic_bids/Utilities/Validators.dart';
import 'package:centic_bids/screens/Main/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  var authHandler = new AuthService();
  var _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: _buildBody(),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: TextButton(
          onPressed: () {
            Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => Home(),
              ),
            );
          },
          child: Text(
            'Browse as a guest',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text("Login"),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _loginFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailTextController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  return AuthValidator.validateEmail(value);
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordTextController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  return AuthValidator.validatePassword(value);
                },
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgotPassword');
                  },
                  child: Text('Forgot Password?'),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () async {
                    if (_loginFormKey.currentState.validate()) {
                      FocusScope.of(context).unfocus();
                      try {
                        authHandler
                            .signIn(
                          _emailTextController.text.trim(),
                          _passwordTextController.text.trim(),
                        )
                            .then((value) {
                          if (value == true) {
                            Navigator.pushReplacement<void, void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => Home(),
                              ),
                            );
                          }
                        });
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
