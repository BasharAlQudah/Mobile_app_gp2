import 'package:flutter/material.dart';
import 'package:gp2_mobile_app/auth/auth.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  AuthMethods authMethods = AuthMethods();
  Future<void> signInUser() async {
    await authMethods.loginUser(
      context: context,
      email: email.text,
      password: password.text,
    );
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
                    obscureText: true,
                    decoration: InputDecoration(
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
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xff4c505b),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              signInUser().then((value) =>
                                  Navigator.pushNamed(context, 'homepage'));
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
