import 'package:crowd_sound/components/loading_animation.dart';
import 'package:crowd_sound/components/main_logo.dart';
import 'package:crowd_sound/feauters/auth/components/social_networks.dart';
import 'package:crowd_sound/feauters/auth/form_tile.dart';
import 'package:crowd_sound/pages/home_page/home_page.dart';
import 'package:crowd_sound/components/painter.dart';
import 'package:crowd_sound/pages/welcome_page/welcome_page.dart';
import 'package:crowd_sound/palettes.dart';
import 'package:database_repository/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with SingleTickerProviderStateMixin {

  late final TabController tabController;
  int selectedIndex = 0;
  bool isLoading = true;

  void checkAuthentication() async {
    bool isAuthenticated = await context.read<DatabaseRepository>().getAuthenctiactionData();
    if (isAuthenticated) {
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
    setState(() {
        isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    checkAuthentication();
  }

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
            const Align(
              alignment: Alignment.centerLeft,
              child: SocialNetworks()
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FormTile(
                tabController: tabController,
                // onTap: () {
                //   setState(() {
                //     isLoading = true;
                //     if (selectedIndex == 0) {
                //       Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                //       isLoading = false;
                //       setState(() {});
                //     } else {
                //       Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => 
                //         const WelcomePage(), transitionDuration: const Duration(seconds: 0)
                //       )).then((value) {
                //         setState(() {
                //           isLoading = false;
                //         });
                //       });
                //     }
                //   }
      
                
              
            )
            ),
            if (isLoading) LoadingAnimation(colors: purplePalette, opacity: 1)
            
          ],
        ),
      ),
    );
  }

}