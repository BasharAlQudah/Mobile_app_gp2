import 'package:flutter/material.dart';
import 'package:gp2_mobile_app/auth/auth.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isDoctor = false;
  final _signUpFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/register.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: Stack(children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.only(left: 35, right: 35, bottom: 80),
                child: const CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('images/logo-register.png'),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _signUpFormKey,
                    child: Container(
                      padding: EdgeInsets.only(
                          right: 35,
                          left: 35,
                          top: MediaQuery.of(context).size.height * 0.27),
                      child: Column(children: [
                        TextFormField(
                          controller: name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Can't be empty";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            hintText: 'Name',
                            hintStyle: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
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
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            hintText: 'Email',
                            hintStyle: const TextStyle(color: Colors.white),
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
                          obscureText: true,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: isDoctor,
                              onChanged: (newValue) {
                                setState(() {
                                  isDoctor = newValue ?? false;
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                            Text(
                              isDoctor ? 'Sign in as a Doctor' : 'Doctor',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
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
                                    if (_signUpFormKey.currentState!
                                        .validate()) {
                                      if (isDoctor) {
                                        AuthMethods().signUpDoctor(
                                          email: email.text,
                                          name: name.text,
                                          password: password.text,
                                          context: context,
                                        );
                                      } else {
                                        AuthMethods().signUpUser(
                                          name: name.text,
                                          email: email.text,
                                          password: password.text,
                                          context: context,
                                        );
                                      }
                                      Navigator.pushNamed(context, 'login');
                                      print('object');
                                    }
                                    // Navigator.pushNamed(context, 'homepage');
                                  },
                                  icon: const Icon(Icons.arrow_forward),
                                ),
                              ),
                            ]),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'login');
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ]),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
