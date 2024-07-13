import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {

  final TextEditingController controller;
  final String title;
  final bool obscure;
  final Icon icon;

  const CustomTextfield({super.key, required this.controller, required this.title, required this.obscure, required this.icon});

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: 240,
      height: kToolbarHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).secondaryHeaderColor,
            blurRadius: 5
          )
        ]
      ),
      child: TextFormField(
        cursorColor: Colors.white,
        cursorWidth: 1,
        controller: widget.controller,
        obscureText: widget.obscure,
        style: TextStyle(
          color: Colors.white,
          fontFamily: "PoiretOne",
        ),
        decoration: InputDecoration(
          focusColor: Colors.white,
          prefixIcon: widget.icon, 
          
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white)
          ),
          
        ),
      ),
    );
  }
}