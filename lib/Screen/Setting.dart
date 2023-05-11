import 'package:api_dio/Constants.dart';
import 'package:api_dio/Network/Remote/Dio_helper.dart';
import 'package:api_dio/Screen/Home.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  String? name, phone, email;

  Setting({Key? key, this.name, this.email, this.phone}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  TextEditingController firstcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  // firstcontroller.text = 'saa';
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Update Data',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextFormField(
                    // initialValue: 'ahmessd',
                    controller: firstcontroller..text = widget.name ?? '',
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: phonecontroller..text = widget.phone ?? '',
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        labelText: 'Phone'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your Phone';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: emailcontroller..text = widget.email ?? '',
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
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        await DioHelper.putData(
                                endPoint: UPDATE,
                                data: {
                                  "name": firstcontroller.text.toString(),
                                  "phone": phonecontroller.text.toString(),
                                  "email": emailcontroller.text.toString()
                                },
                                token: Static.TOKEN)
                            .then((value) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(
                                phone: phonecontroller.text.toString(),
                                email: emailcontroller.text.toString(),
                                name: firstcontroller.text.toString(),
                              ),
                            ),
                          );
                        });
                      }
                    },
                    child: const Text("Update"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
