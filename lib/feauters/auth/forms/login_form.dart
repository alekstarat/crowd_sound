
import 'package:crowd_sound/feauters/auth/components/custom_textfield.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {

  final TextEditingController loginController, passwordController;

  const LoginForm({super.key, required this.loginController, required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Вход",
            style: TextStyle(
              fontSize: 29,
              fontWeight: FontWeight.bold,
              fontFamily: "PoiretOne",
              color: Colors.white
            )
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.03,),
          CustomTextfield(
            controller: loginController, 
            title: "Имя пользователя", 
            obscure: false, 
            icon: const Icon(Icons.person_2_outlined, 
            color: Colors.white,
          ),),
          SizedBox(height: MediaQuery.of(context).size.height*0.03,),
          CustomTextfield(
            controller: passwordController, 
            title: "Пароль", 
            obscure: true, 
            icon: const Icon(Icons.lock, color: Colors.white,)
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.02,),
          Text(
            "Забыли пароль?",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: "PoiretOne",
              color: Theme.of(context).primaryColor.withOpacity(0.5)
            )
          )
        ],
      ),
    );
  }
}