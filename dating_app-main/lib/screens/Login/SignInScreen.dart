import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  @override
  State<SigninScreen> createState() => _SigninScreenState();
  String screenid = "signinscreen";
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> _createAccount() async {
    if (_formKey.currentState!.validate()) {
      // Handle create account logic here
      String userName = _userNameController.text;
      String password = _passwordController.text;

      // final log = Login();
      // final res = await log.login(userName, password);
      // if (res == 'Success') {
      Navigator.pushReplacementNamed(context, '/home');
      // } else if (res == 'DiffIP') {
      //   print(
      //       'A verification code has been sent to your registered email. Please enter the code to proceed.');
      //   Navigator.pushReplacementNamed(context, '/otpvalidate');
      // } else {}
    }
  }

  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: const Color.fromARGB(255, 255, 255, 255),
      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: Colors.grey.shade400,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: Colors.pink,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(30.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 2,
          offset: Offset(0, 1), // changes position of shadow
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              child: Image.asset('images/logo.png'),
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 8.0),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    decoration: _boxDecoration(),
                    child: TextFormField(
                      controller: _userNameController,
                      decoration: _inputDecoration('Username'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    decoration: _boxDecoration(),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            color: Colors.pink,
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 255, 255, 255),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            color: Colors.pink,
                            width: 1.5,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _createAccount,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                      padding: EdgeInsets.all(18),
                      shadowColor: Colors.black,
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle navigation to forgot password screen
                    },
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: Colors.pink,
                      ),
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 2.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/signup');
                        },
                        child: Text(
                          'Create account',
                          style: TextStyle(
                            color: Colors.pink,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
