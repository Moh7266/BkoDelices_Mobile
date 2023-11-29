import 'package:flutter/material.dart';

class PageCommandes extends StatefulWidget {
  const PageCommandes({super.key});

  @override
  State<PageCommandes> createState() => _PageCommandesState();
}

class _PageCommandesState extends State<PageCommandes>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              stops: [0.9000, 1.2585],
              colors: [
                Colors.white,
                Color.fromARGB(176, 255, 128, 0),
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  left: 25,
                  child: SizedBox(
                    height: 50,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                const Positioned(
                  top: 20,
                  right: 0,
                  child: SizedBox(
                    height: 50,
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/profil.png'),
                      radius: 30,
                    ),
                  ),
                ),
                const Positioned(
                  top: 100,
                  left: 70,
                  // right: 50,
                  child: Text('Mes commandes',
                  style: TextStyle(
                    color: Color.fromARGB(176, 255, 128, 0),
                    fontSize: 30
                  ),)
                  ),
                Positioned(
                  top: 150,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height - 150, // Utilisez la hauteur disponible du bas de l'écran
                    child: ListView(
                      children: const [
                        Center(
                          child: Card(
                            elevation: 1,
                            child: SizedBox(
                              width: 345,
                              height: 100,
                              child: Center(
                                child: Text(
                                  'Ma commande',
                                  style: TextStyle(color: Colors.amber),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )

                   
                ]
    )
    )
    )
    )
    );
  }
}