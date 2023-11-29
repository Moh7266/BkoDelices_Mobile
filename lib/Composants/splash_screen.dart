import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0.588888, 1], // Mettez les deux valeurs à 0.5 pour obtenir un dégradé centré
              colors: [
                Colors.white,
                Color.fromARGB(176, 255, 128, 0),
              ],
            ),
          ),
          // Ajoutez d'autres widgets ici...
          child: Center(child: ListView(children: [
            
          ]),)
        ),
      ),
    );
  }
}
