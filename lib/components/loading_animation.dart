import 'dart:math';

import 'package:flutter/material.dart';

class LoadingAnimation extends StatefulWidget {

  final List<Color> colors;

  const LoadingAnimation({super.key, required this.colors});

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> with TickerProviderStateMixin {

  late AnimationController _controller1, _controller2, _controller3, _controller4;
  late Animation<double> _animation1, _animation2, _animation3, _animation4;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500)
    );
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500)
    );
    _controller3 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500)
    );
    _controller4 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500)
    );



    _animation1 = Tween(begin: 1.0, end: 10.0).animate(_controller1)..addListener(() {
      setState(() {
        
      });
    });

    _animation2 = Tween(begin: 1.0, end: 10.0).animate(_controller2)..addListener(() {
      setState(() {
        
      });
    });

    _animation3 = Tween(begin: 1.0, end: 10.0).animate(_controller3)..addListener(() {
      setState(() {
        
      });
    });

    _animation4 = Tween(begin: 1.0, end: 10.0).animate(_controller4)..addListener(() {
      setState(() {
        
      });
    });
    
    Future.delayed(
      const Duration(milliseconds: 0),
      () => {
        _controller1.repeat(reverse: true)
      }
    );
    Future.delayed(
      const Duration(milliseconds: 200),
      () => {
        _controller2.repeat(reverse: true)
      }
    );
    Future.delayed(
      const Duration(milliseconds: 400),
      () => {
        _controller3.repeat(reverse: true)
      }
    );
    Future.delayed(
      const Duration(milliseconds: 600),
      () => {
        _controller4.repeat(reverse: true)
      }
    );
    
  }

  

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black.withOpacity(0.9), Colors.black.withOpacity(0.6),],
          transform: const GradientRotation(pi/4)
        )
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: SizedBox(
          width: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 10,
                height: _animation1.value*10,
                decoration: BoxDecoration(
                  color: widget.colors[_animation1.value.toInt()],
                  borderRadius: BorderRadius.circular(90),
                  border: Border.all(color: widget.colors[_animation1.value.toInt()%10], width: _animation1.value )
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 10,
                height: _animation2.value*10,
                decoration: BoxDecoration(
                  color: widget.colors[_animation2.value.toInt()],
                  borderRadius: BorderRadius.circular(90),
                  border: Border.all(color: widget.colors[_animation2.value.toInt()%10], width: _animation2.value )
                ),
              ),
              
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 10,
                height: _animation3.value*10,
                decoration: BoxDecoration(
                  color: widget.colors[_animation3.value.toInt()],
                  borderRadius: BorderRadius.circular(90),
                  border: Border.all(color: widget.colors[_animation3.value.toInt()%10], width: _animation3.value)
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 10,
                height: _animation4.value*10,
                decoration: BoxDecoration(
                  color: widget.colors[_animation4.value.toInt()],
                  borderRadius: BorderRadius.circular(90),
                  border: Border.all(color: widget.colors[_animation4.value.toInt()%10], width: _animation4.value )
                ),
              ),
            ]
          ),
        ),
      ),
    );

    
   
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
    
  }
}