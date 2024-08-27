import 'package:crowd_sound/components/loading_animation.dart';
import 'package:crowd_sound/components/main_logo.dart';
import 'package:crowd_sound/feauters/auth/components/social_networks.dart';
import 'package:crowd_sound/feauters/auth/form_tile.dart';
import 'package:crowd_sound/feauters/auth/forms/login_form.dart';
import 'package:crowd_sound/feauters/auth/forms/registration_form.dart';
import 'package:crowd_sound/pages/home_page/home_page.dart';
import 'package:crowd_sound/components/painter.dart';
import 'package:crowd_sound/pages/welcome_page/welcome_page.dart';
import 'package:crowd_sound/palettes.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  int selectedIndex = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5)
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: CustomPaint(
                painter: MyPainter2(),
                size: Size(MediaQuery.of(context).size.width, 200),
              ),
            ),
            const SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 32),
                  child: MainLogo(size: 40),
                )
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomPaint(
                painter: MyPainter1(),
                size: Size(MediaQuery.of(context).size.width, 500),
              ),
            ),
            Row(
              
              children: [
                NavigationRail(
                  backgroundColor: Colors.transparent,
                  indicatorColor: Theme.of(context).scaffoldBackgroundColor,
                  indicatorShape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12))),
                  
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                  groupAlignment: -0.1,
                  minWidth: 50,
                  selectedIndex: selectedIndex,
                  destinations: [
                    NavigationRailDestination( 
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.login_rounded, color: Theme.of(context).primaryColor,), 
                      selectedIcon: Icon(Icons.login_rounded, color: Theme.of(context).primaryColorDark,), 
                      
                      label: const Text(''), 
                    ),
                    NavigationRailDestination( 
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      icon: Icon(Icons.person_add_alt_1_outlined, color: Theme.of(context).primaryColor,), 
                      selectedIcon: Icon(Icons.person_add_alt_1_outlined, color: Theme.of(context).primaryColorDark,), 
                      label: const Text(''), 
                    ),
                  ], 
                )
              ],
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: SocialNetworks()
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FormTile(onTap: () {
                setState(() {
                  isLoading = true;
                  if (selectedIndex == 0) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                    isLoading = false;
                    setState(() {});
                  } else {
                    Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => 
                      const WelcomePage(), transitionDuration: const Duration(seconds: 0)
                    )).then((value) {
                      setState(() {
                        isLoading = false;
                      });
                    });
                  }
                }
      
                );
              },
              form: selectedIndex == 0 ? const LoginForm() : const RegistrationForm()
            )
            ),

            IgnorePointer(ignoring: !isLoading,child: LoadingAnimation(colors: purplePalette, opacity: isLoading ? 1 : 0)),
            
          ],
        ),
      ),
    );
  }

}