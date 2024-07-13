import 'package:crowd_sound/feauters/auth/components/custom_textfield.dart';
import 'package:flutter/material.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 170),
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
            controller: TextEditingController(), 
            title: "Имя пользователя", 
            obscure: false, 
            icon: const Icon(Icons.person_2_outlined, 
            color: Colors.white,
          ),),
          SizedBox(height: MediaQuery.of(context).size.height*0.03,),
          CustomTextfield(
            controller: TextEditingController(), 
            title: "Пароль", 
            obscure: true, 
            icon: const Icon(Icons.lock, color: Colors.white,)
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.03,),
          CustomTextfield(
            controller: TextEditingController(), 
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