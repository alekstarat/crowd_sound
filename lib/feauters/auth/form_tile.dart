import 'dart:math';

import 'package:flutter/material.dart';

class FormTile extends StatelessWidget {

  final Widget form;

  final Function? onTap;

  const FormTile({super.key, required this.onTap, required this.form});

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
                      child: form,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => onTap!(),
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