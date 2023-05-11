import 'package:api_dio/Network/Local/Cache_helper.dart';
import 'package:api_dio/Network/Remote/Dio_helper.dart';
import 'package:api_dio/Screen/Home.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';
import 'SignUp.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(14.0),
            child: Text(
              "Login",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Center(
            child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailcontroller,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          labelText: 'email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: passwordcontroller,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          labelText: 'password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your password';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          await DioHelper.postData(endPoint: LOGIN, data: {
                            "email": emailcontroller.text.toString(),
                            "password": passwordcontroller.text.toString(),
                          }).then(
                            (value) {
                              Static.TOKEN = value!.data['data']['token'];
                              CacheHelper.putData(
                                      'token', value.data['data']['token'])
                                  .then(
                                (value1) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home(
                                            name: value.data['data']['name'],
                                            phone: value.data['data']['phone'],
                                            email: value.data['data']
                                                ['email'])),
                                  );
                                },
                              );
                            },
                          );
                        }
                      },
                      child: const Text("Sign in"),
                    ),
                    Row(
                      children: [
                        const Text("Don't have an account "),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()),
                            );
                          },
                          child: const Text("RIGISTER"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
