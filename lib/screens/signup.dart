// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:charger/animation/animations.dart';
import 'package:charger/screens/login.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_file_storage/flutter_secure_file_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:email_validator/email_validator.dart';

import '../constant.dart';

class SignUPScreen extends StatefulWidget {
  SignUPScreen({Key? key}) : super(key: key);

  @override
  State<SignUPScreen> createState() => _SignUPScreenState();
}

class _SignUPScreenState extends State<SignUPScreen> {
  final feature = ["Se connecter", "Compte"];
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  void Validate(String email) {
    bool isvalid = EmailValidator.validate(email);
    print(isvalid);
  }

  int i = 1;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            backgroundColor: Color(0xfffdfdfdf),
            body: i == 1
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(25),
                          child: Column(
                            children: [
                              // TabBar Code
                              Row(children: [
                                SizedBox(
                                  height: height / 19,
                                  width: width / 2,
                                  child: TopAnime(
                                    2,
                                    5,
                                    child: ListView.builder(
                                      itemCount: feature.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              i = index;
                                            });
                                          },
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: Text(
                                                  feature[index],
                                                  style: TextStyle(
                                                    color: i == index
                                                        ? Colors.black
                                                        : Colors.grey,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
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

                                // Profile
                                RightAnime(
                                  1,
                                  15,
                                  curve: Curves.easeInOutQuad,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.red[400],
                                      child: i == 0
                                          ? Image(
                                              image: NetworkImage(
                                                  "https://i.pinimg.com/564x/5d/a3/d2/5da3d22d08e353184ca357db7800e9f5.jpg"),
                                            )
                                          : Icon(
                                              Icons.account_circle_outlined,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                    ),
                                  ),
                                ),
                              ]),

                              SizedBox(
                                height: 30,
                              ),

                              // Top Text
                              Container(
                                padding: EdgeInsets.only(left: 15),
                                width: width,
                                child: TopAnime(
                                  1,
                                  20,
                                  curve: Curves.fastOutSlowIn,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("station",
                                          style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.w300,
                                          )),
                                      Text(
                                        "de charge",
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Créez un compte gratuit pour louer votre borne \nde recharge et trouver la borne la plus proche.",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: height / 18,
                              ),

                              // TextFiled
                              SizedBox(
                                width: width / 1.2,
                                height: height / 2.65,
                                child: TopAnime(
                                  1,
                                  16,
                                  curve: Curves.easeInExpo,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextField(
                                        controller: phoneNumberController,
                                        keyboardType: TextInputType.phone,
                                        maxLength: 10,
                                        // readOnly: true, // * Just for Debug
                                        cursorColor: Colors.black,
                                        style: TextStyle(color: Colors.black),
                                        showCursor: true,
                                        //cursorColor: mainColor,
                                        decoration: kTextFiledInputDecoration,
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      TextField(
                                        controller: emailController,
                                        cursorColor: Colors.black,
                                        style: TextStyle(color: Colors.black),
                                        showCursor: true,
                                        //cursorColor: mainColor,
                                        decoration:
                                        kTextFiledInputDecoration.copyWith(
                                            labelText:
                                            "Addresse E-mail"),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      TextField(
                                          controller: passwordController,
                                          cursorColor: Colors.black,
                                          style: TextStyle(color: Colors.black),
                                          showCursor: true,
                                          //cursorColor: mainColor,
                                          decoration: kTextFiledInputDecoration
                                              .copyWith(
                                              labelText: "Mot de passe")),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Bottom
                        i == 1
                            ? TopAnime(
                                2,
                                29,
                                curve: Curves.fastOutSlowIn,
                                child: Container(
                                  height: height / 6,
                                  // color: Colors.red,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 43),
                                        child: Container(
                                            height: height / 9,
                                            color:
                                                Colors.grey.withOpacity(0.4)),
                                      ),
                                      Positioned(
                                        left: 280,
                                        top: 10,
                                        child: GestureDetector(
                                          onTap: () async {
                                            try {

                                              Validate(emailController.text);

                                              final phoneNumber =
                                                  phoneNumberController.text;
                                              final password =
                                                  passwordController.text;
                                              final email =
                                                  emailController.text;

                                              final responseData =
                                                  await sendSignUpForm(
                                                  phoneNumber, password, email);
                                              final token = responseData['token'] as String;

                                              // Save the token to SharedPreferences or other storage
                                              final storage =
                                              FlutterSecureFileStorage(
                                                  FlutterSecureStorage());

                                              await storage.write(
                                                  key: 'jwt', value: token);

                                              final jwt = await storage
                                                  .read<String>(key: 'jwt');

                                              // Print only on dev
                                              if (kDebugMode) {
                                                print('JWT: $jwt');
                                              }

                                              // Handle token storage as needed
                                            } catch (error) {
                                              if (kDebugMode) {
                                                print('Error: $error');
                                              }
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xff0593ca),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            width: width / 4,
                                            height: height / 12,
                                            child: Icon(
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
                            : LoginScreen()
                      ],
                    ),
                  )
                : LoginScreen()),
      ),
    );
  }
}

Future<Map<String, dynamic>> sendSignUpForm(
    String phoneNumber,  String email, String password) async {
  final url = Uri.parse('https://5850-82-30-133-213.ngrok-free.app/v1/register');
  final response = await http.post(
    url,
    body: {
      'phone': phoneNumber,
      'email': email,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    return responseData;
  } else {
    throw Exception('Failed to sign up customer');
  }
}