// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:crowd_sound/feauters/auth/forms/login_form.dart';
import 'package:crowd_sound/feauters/auth/forms/registration_form.dart';
import 'package:crowd_sound/pages/home_page/home_page.dart';
import 'package:database_repository/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormTile extends StatefulWidget {

  final TabController tabController;

  const FormTile({super.key, required this.tabController});

  @override
  State<FormTile> createState() => _FormTileState();
}

class _FormTileState extends State<FormTile> {

  final TextEditingController loginController1 = TextEditingController(), passwordController1 = TextEditingController();
  final TextEditingController loginController2 = TextEditingController(), passwordController2 = TextEditingController(), passwordCheckController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.72+50,
      width: MediaQuery.of(context).size.width*0.72,
      child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.72,
                      height: MediaQuery.of(context).size.height*0.72,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.8), blurRadius: 30)
                        ],
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(36), bottomLeft: Radius.circular(36)),
                        gradient: LinearGradient(
                          transform: const GradientRotation(2*pi/7),
                          colors: [Theme.of(context).primaryColorDark, Theme.of(context).scaffoldBackgroundColor ]
                        )
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.07),
                            child: TabBar(
                              dividerColor: Colors.transparent,
                              indicatorColor: Colors.white.withOpacity(0.5),
                              unselectedLabelColor: Colors.white.withOpacity(0.4),
                              labelColor: Colors.white,
                              labelStyle: const TextStyle(
                                fontFamily: 'PoiretOne',
                                fontWeight: FontWeight.bold
                              ),
                              controller: widget.tabController,
                              tabs: const [
                                Tab(text: "Вход"),
                                Tab(text: "Регистрация")
                              ]
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.72,
                            height: MediaQuery.of(context).size.height*0.72,
                            child: TabBarView(
                              controller: widget.tabController,
                              children: [
                                LoginForm(loginController: loginController1, passwordController: passwordController1,),
                                RegistrationForm(loginController: loginController2, passwordController: passwordController2, passwordCheckController: passwordCheckController,)
                              ]
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (widget.tabController.index == 0) {
                        if (loginController1.text.length > 5 && loginController1.text.length < 17 && passwordController1.text.length < 33 && passwordController1.text.length > 5) {
                          dynamic response = await context.read<DatabaseRepository>().authenticate(loginController1.text, passwordController1.text);
                          if (response) {
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                          }
                        } else {
                          print("Некорректный логин!");
                        }
                      } else {
                        if  (loginController2.text.length > 5 && 
                            loginController2.text.length < 17 && 
                            passwordController2.text.length < 33 && 
                            passwordController2.text.length > 5 && 
                            passwordCheckController.text == passwordController2.text
                            ) {
                              bool v = await context.read<DatabaseRepository>().registration(loginController2.text, passwordController2.text);
                              if (v) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                              } else {
                                print("нетнетнет");
                              }
                              
                              
                            }
                      }
                    },
                    child: Container(
                      width: 200,
                      height: kToolbarHeight-10,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(
                          color: Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
                          blurRadius: 10
                        )],
                        borderRadius: BorderRadius.circular(90)
                      ),
                      child: Center(
                        child: Text(
                          "Продолжить",
                          style: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor,
                            fontFamily: "PoiretOne",
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),

                        ),
                      ),
                    ),
                  )
                ],
              ),
    );
  }
}