import 'package:flutter/material.dart';

class CustomStepper extends StatefulWidget {
  const CustomStepper({super.key});

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    return Stepper(
      steps: const [
        Step(
          title: Text("text"), 
          content: SizedBox(width: 100, height: 100,)
        ),
        Step(
          title: Text("text"), 
          content: SizedBox(width: 100, height: 100,)
        ),
      ],
    );
  }
}