import 'package:flutter/material.dart';
import 'package:gp2_mobile_app/auth/auth.dart';
import 'package:gp2_mobile_app/shared/components.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool _isLoading = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  AuthMethods authMethods = AuthMethods();
  bool _showPassword = false;

  Future<void> signInUser() async {
    print('In');
    setState(() {
      _isLoading = true;
    });
    String res = await authMethods.loginUser(
      context: context,
      email: email.text,
      password: password.text,
    );
    print(res);
    if (res == 'Success') {
      print(res);
      setState(() {
        _isLoading = false;
      });
    } else if (res ==
        '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
      print(res);

      setState(() {
        _isLoading = false;
      });

      final snackBar = SnackBar(
        content: Text(res),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // displayErrorMotionToast(
      // context, 'Wrong password', 'Make sure your credentials are right');
    } else if (res == 'No user found') {
      print(res);
      setState(() {
        _isLoading = false;
      });
      final snackBar = SnackBar(
        content: Text(res),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // displayErrorMotionToast(
      //     context, res, 'Make sure your credentials are right');
    } else if (res == 'Some error occured') {
      print(res);
      setState(() {
        _isLoading = false;
      });
      final snackBar = SnackBar(
        content: Text(res),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // displayWarningMotionToast(
      // context, res, 'Make sure your credentials are right');
    } else if (res ==
        '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
      setState(() {
        _isLoading = false;
        const snackBar = SnackBar(
          content: Text('No user found'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    } else {
      setState(() {
        _isLoading = false;
        final snackBar = SnackBar(
          content: Text(res),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.only(left: 35, top: 80, right: 35),
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('images/logo.png'),
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Container(
                padding: EdgeInsets.only(
                    right: 35,
                    left: 35,
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(children: [
                  TextFormField(
                    controller: email,
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}')
                              .hasMatch(value)) {
                        return 'Invalid email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: password,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 8) {
                        return "Enter a Password";
                      } else if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                          .hasMatch(value)) {
                        return "Enter a Valid Password";
                      }
                      return null;
                    },
                    obscureText: !_showPassword,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          size: 30,
                          color: _showPassword ? Colors.black : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() => _showPassword = !_showPassword);
                        },
                      ),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Color(0xff4c505b),
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : CircleAvatar(
                              radius: 30,
                              backgroundColor: const Color(0xff4c505b),
                              child: IconButton(
                                color: Colors.white,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    signInUser();
                                  }
                                },
                                icon: const Icon(Icons.arrow_forward),
                              ),
                            ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'register');
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                          color: Color(0xff4c505b),
                        ),
                      ),
                    ),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: const Text(
                    //     '',
                    //     style: TextStyle(
                    //       decoration: TextDecoration.underline,
                    //       fontSize: 18,
                    //       color: Color(0xff4c505b),
                    //     ),
                    //   ),
                    // ),
                  ]),
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
