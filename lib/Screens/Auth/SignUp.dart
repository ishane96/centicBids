import 'package:centic_bids/Controllers/Authentication.dart';
import 'package:centic_bids/Utilities/Validators.dart';
import 'package:centic_bids/screens/Main/home.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPwTextController = TextEditingController();

  var authHandler = new AuthService();
  var _signUpFormKey = GlobalKey<FormState>();

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
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text("Sign Up"),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _signUpFormKey,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                textCapitalization: TextCapitalization.words,
                controller: _nameTextController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                ),
                validator: (value) {
                  return AuthValidator.validateName(value);
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                autocorrect: false,
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
                autocorrect: false,
                controller: _passwordTextController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  return AuthValidator.validatePassword(value);
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                autocorrect: false,
                controller: _confirmPwTextController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                ),
                validator: (value) {
                  return AuthValidator.validateRetypePassword(
                      _passwordTextController.text, value);
                },
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () {
                    if (_signUpFormKey.currentState.validate()) {
                      FocusScope.of(context).unfocus();
                      try {
                        authHandler
                            .signUp(
                          _emailTextController.text.toString().trim(),
                          _passwordTextController.text.trim(),
                          _nameTextController.text.toString().trim(),
                        )
                            .then((value) {
                          if (value == true) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => Home()));
                          }
                        });
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: Text(
                    'Sign up',
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
                onPressed: () {},
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
