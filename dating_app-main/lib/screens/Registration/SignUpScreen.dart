import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignupScreen extends StatefulWidget {
  String screenid = "signupscreen";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  bool _agreeToTAndC = false;

  Future<void> _createAccount() async {
    if (_formKey.currentState!.validate()) {
      if (_agreeToTAndC) {
        // Handle create account logic here
        String firstName = _firstNameController.text;
        String lastName = _lastNameController.text;
        String idNumber = _idNumberController.text;
        String email = _emailController.text;
        String phone = _phoneController.text;

        final sign = Signup();
        final res =
            await sign.signup(firstName, lastName, idNumber, email, phone);
        if (res != 'Failed') {
          print('success');
          Navigator.pushReplacementNamed(context, '/otpvalidate');
        } else {
          if (res == 'User With Account Already Exist') {
            print('User With Account Already Exist');
          } else {}
        }
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Terms and Conditions'),
            content: SingleChildScrollView(
              child: Text(
                // Dummy T&C content, you can replace it with your own T&C text
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris '
                'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in '
                'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
                'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui '
                'officia deserunt mollit anim id est laborum.',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      }
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
          color: Colors.grey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          width: 2,
          color: Colors.pink,
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

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final RegExp emailRegExp = RegExp(
      r'^[^@]+@[^@]+\.[^@]+',
    );
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email';
    }
    return null;
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
                    'Create an Account',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    decoration: _boxDecoration(),
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: _inputDecoration('First Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    decoration: _boxDecoration(),
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: _inputDecoration('Last Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                  ),
                                   SizedBox(height: 8.0),
                  Container(
                    decoration: _boxDecoration(),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: _inputDecoration('Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    decoration: _boxDecoration(),
                    child: IntlPhoneField(
                      focusNode: _phoneFocusNode,
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
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
                            width: 1.5,
                            color: Colors.pink,
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
                      initialCountryCode: 'ZA',
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                      onCountryChanged: (country) {
                        print('Country changed to: ${country.name}');
                      },
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Checkbox(
                        value: _agreeToTAndC,
                        onChanged: (value) {
                          setState(() {
                            _agreeToTAndC = value!;
                          });
                        },
                        activeColor: Colors.pink,
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Color.fromARGB(39, 0, 181, 184)),
                      ),
                      Text('I agree to the '),
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('Terms and Conditions'),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                        '1. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                                    Text(
                                        '2. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
                                    Text(
                                        '3. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris'),
                                    Text(
                                        '4. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                                    Text(
                                        '5. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
                                    Text(
                                        '6. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris'),
                                    Text(
                                        '7. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                                    Text(
                                        '8. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
                                    Text(
                                        '9. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris'),
                                    Text(
                                        '10. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                                     Text(
                                        '1. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                                    Text(
                                        '2. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
                                    Text(
                                        '3. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris'),
                                    Text(
                                        '4. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                                    Text(
                                        '5. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
                                    Text(
                                        '6. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris'),
                                    Text(
                                        '7. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                                    Text(
                                        '8. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
                                    Text(
                                        '9. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris'),
                                    Text(
                                        '10. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                                 
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Close'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text(
                          'Terms and Conditions',
                          style: TextStyle(color: Colors.pink),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  ElevatedButton(
                    onPressed: _createAccount,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      elevation: 4,
                      padding: EdgeInsets.all(18),
                      shadowColor: Colors.black,
                    ),
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 17
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already registered?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/signin');
                        },
                        child: Text(
                          'Login',
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

class Signup {
  signup(String firstName, String lastName, String idNumber, String email, String phone) {}
}
