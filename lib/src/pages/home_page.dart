import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.teal,
          title: Text("Peliculas en cine"),
          actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
        ),
        body: Container(
          child: Column(
            children: [
              _swipeTarjetas(),
            ],
          ),
        ));
  }

  Widget _swipeTarjetas() {
    return Container();
  }
}
