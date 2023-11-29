import "package:flutter/material.dart";


class PageNotification extends StatefulWidget {
  const PageNotification({super.key});

  @override
  State<PageNotification> createState() => _PageNotificationState();
}

class _PageNotificationState extends State<PageNotification> {
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
                  left: 90,
                  // right: 50,
                  child: Text('Notifications',
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
                              height: 80,
                              child: Center(
                                child: Text(
                                  'Ma notification',
                                  style: TextStyle(color: Colors.amber),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Card(
                            elevation: 1,
                            child: SizedBox(
                              width: 345,
                              height: 80,
                              child: Center(
                                child: Text(
                                  'Ma notification',
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