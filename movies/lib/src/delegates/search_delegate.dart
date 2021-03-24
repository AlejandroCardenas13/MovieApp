import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  String selection = '';

  final movies = [
    'Spiderman',
    'Captain America',
    'Ironman',
    'Shazam!',
    'Batman',
    'Superman',
    'Hulk'
  ];

  final recentMovies = ['Spiderman', 'Captain America'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar

    return Center(
        child: Container(
      height: 100.0,
      width: 100.0,
      color: Colors.amberAccent,
      child: Container(
        child: Text(selection),
        alignment: Alignment.center,
      ),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe

    final suggestedList = (query.isEmpty)
        ? recentMovies
        : movies
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (BuildContext context, int i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(suggestedList[i]),
          onTap: () {
            selection = suggestedList[i];
            showResults(context);
          },
        );
      },
      itemCount: suggestedList.length,
    );
  }
}
