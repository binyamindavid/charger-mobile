import 'dart:convert';

import 'package:charger/screens/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:charger/animation/animations.dart';
import 'package:charger/screens/signup.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_file_storage/flutter_secure_file_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final feature = ["Se connecter", "Compte"];
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  int i = 0;
  String loginErrorMessage = '';

  bool _loggedIn = false;

  void _handleLoginSuccess(String token) async {
    final storage = FlutterSecureFileStorage(const FlutterSecureStorage());
    storage.write(key: 'jwt', value: token);

    final jwt = await storage.read<String>(key: 'jwt');

    if (kDebugMode) {
      print('Stored JWT: $jwt');
    }

    setState(() {
      _loggedIn = true;
    });

  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    if (_loggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      });
    }
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            backgroundColor: const Color(0xFFFFFFFF),
            body: i == 0
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(25),
                          child: Column(
                            children: [
                              Row(
                                  // TabBar Code
                                  children: [
                                    SizedBox(
                                      height: height / 19,
                                      width: width / 2,
                                      child: TopAnime(
                                        2,
                                        5,
                                        child: ListView.builder(
                                          itemCount: feature.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  i = index;
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20),
                                                    child: Text(
                                                      feature[index],
                                                      style: TextStyle(
                                                        color: i == index
                                                            ? Colors.black
                                                            : Colors.grey,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  i == index
                                                      ? Container(
                                                          height: 3,
                                                          width: width / 9,
                                                          color: Colors.black,
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                  ]),

                              const SizedBox(
                                height: 50,
                              ),

                              // Top Text
                              Container(
                                padding: const EdgeInsets.only(left: 15),
                                width: width,
                                child: TopAnime(
                                  1,
                                  20,
                                  curve: Curves.fastOutSlowIn,
                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Bienvenue,",
                                          style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.w300,
                                          )),
                                      Text(
                                        "BenjaminDavid",
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height / 14,
                              ),
                              // TextFiled
                              Column(
                                children: [
                                  SizedBox(
                                    width: width / 1.2,
                                    height: height / 2.45,
                                    //  color: Colors.red,
                                    child: TopAnime(
                                      1,
                                      15,
                                      curve: Curves.easeInExpo,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextField(
                                            controller: phoneNumberController,
                                            keyboardType: TextInputType.phone,
                                            maxLength: 11,
                                            cursorColor: Colors.black,
                                            style:
                                                const TextStyle(color: Colors.black),
                                            showCursor: true,
                                            //cursorColor: mainColor,
                                            decoration:
                                                kTextFiledInputDecoration,
                                          ),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          TextField(
                                              controller: passwordController,
                                              // readOnly: true, // * Just for Debug
                                              cursorColor: Colors.black,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              showCursor: true,
                                              //cursorColor: mainColor,
                                              decoration:
                                                  kTextFiledInputDecoration
                                                      .copyWith(
                                                          labelText:
                                                              "Mot de passe")),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            loginErrorMessage,
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),

                        // Bottom
                        i == 0
                            ? TopAnime(
                                2,
                                5,
                                curve: Curves.fastOutSlowIn,
                                child: SizedBox(
                                  height: height / 6,
                                  // color: Colors.red,
                                  child: Stack(
                                    children: [
                                      const Positioned(
                                        left: 30,
                                        top: 15,
                                        child: Text(
                                          "Mot de passe oublié?",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 43),
                                        child: Container(
                                            height: height / 9,
                                            color: const Color(0xff0593ca)),
                                      ),
                                      Positioned(
                                        left: 280,
                                        top: 10,
                                        child: GestureDetector(
                                          onTap: () async {
                                            try {
                                              final phoneNumber =
                                                  phoneNumberController.text;
                                              final password =
                                                  passwordController.text;

                                              final responseData =
                                                  await sendLoginForm(
                                                      phoneNumber, password);
                                              final token =
                                                  responseData['token']
                                                      as String;

                                              // Save the token to SharedPreferences or other storage
                                              final storage = FlutterSecureFileStorage(const FlutterSecureStorage());
                                              await storage.write(key: 'jwt', value: token);

                                              // final jwt = await storage.read<String>(key: 'jwt');
                                              //
                                              // if (kDebugMode) {
                                              //   print('JWT: $jwt');
                                              // }

                                              _handleLoginSuccess(token);


                                            } catch (error) {
                                              // Use this error to show the user that login was no good
                                              if (kDebugMode) {
                                                print('Error: $error');
                                              }

                                              setState(() {
                                                loginErrorMessage = 'Numéro de téléphone ou mot de passe invalide';
                                              });
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: const Color(0xff054652),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            width: width / 4,
                                            height: height / 12,
                                            child: const Icon(
                                              Icons.arrow_forward,
                                              size: 25,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SignUPScreen()
                      ],
                    ),
                  )
                : const SignUPScreen()),
      ),
    );
  }
}

Future<Map<String, dynamic>> sendLoginForm(
    String phoneNumber, String password) async {
  final url = Uri.parse('https://5850-82-30-133-213.ngrok-free.app/v1/auth');
  final response = await http.post(
    url,
    body: {
      'phone': phoneNumber,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    return responseData;
  } else {
    throw Exception('Failed to login');
  }
}
