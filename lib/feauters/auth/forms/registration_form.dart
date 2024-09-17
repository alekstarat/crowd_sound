import 'package:crowd_sound/feauters/auth/components/custom_textfield.dart';
import 'package:flutter/material.dart';

class RegistrationForm extends StatelessWidget {

  final TextEditingController loginController, passwordController, passwordCheckController;

  const RegistrationForm({super.key, required this.loginController, required this.passwordController, required this.passwordCheckController});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Регистрация",
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
          SizedBox(height: MediaQuery.of(context).size.height*0.03,),
          CustomTextfield(
            controller: passwordCheckController, 
            title: "Повтор пароля", 
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