import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  String seleccion = '';
  final peliculasProvider = new PeliculasProvider();

  final peliculas = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam',
    'Iron-Man',
    'Capitan America'
  ];

  final peliculasRecientes = ['Spiderman', 'Capitan America'];
  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones de nuestro appBar (Btn limpiar cuadro de busqueda o cancelar)
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
    ];
    // throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izq del app bar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });

    // throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultado de busqueda
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blue,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suguerencias que aparecen cuando la persona escribe
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshopt) {
        if (snapshopt.hasData) {
          final peliculas = snapshopt.data;

          return ListView(
              children: peliculas.map((pelicula) {
            return ListTile(
              leading: FadeInImage(
                placeholder: AssetImage('assets/img/no-img.jpg'),
                image: NetworkImage(pelicula.getBgIMg()),
                width: 50.0,
                fit: BoxFit.contain,
              ),
              title: Text(pelicula.title),
              subtitle: Text(pelicula.originalTitle),
              onTap: () {
                close(context, null);
                Navigator.pushNamed(context, 'detalle', arguments: pelicula);
              },
            );
          }).toList());
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
