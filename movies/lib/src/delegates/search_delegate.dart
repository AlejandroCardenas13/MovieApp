import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {
  String selection = '';
  final MoviesProvider _moviesProvider = new MoviesProvider();

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

/*  @override
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
  }*/

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
    final detail = FutureBuilder(
        future: _moviesProvider.searchMovie(query),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          final movies = snapshot.data;
          return (snapshot.hasData)
              ? ListView(
                  children: movies.map((movie) {
                    return ListTile(
                      leading: FadeInImage(
                        image: NetworkImage(movie.getPosterImg()),
                        placeholder: AssetImage('assets/no-image.jpg'),
                        width: 50.0,
                        fit: BoxFit.contain,
                      ),
                      title: Text(movie.title),
                      subtitle: Text(movie.originalTitle),
                      onTap: () {
                        close(context, null);
                        movie.uniqueId = '${movie.id}-search';
                        Navigator.pushNamed(context, 'detail',
                            arguments: movie);
                      },
                    );
                  }).toList(),
                )
              : Center(child: CircularProgressIndicator(strokeWidth: 2.1));
        });
    return (query.isEmpty) ? Container() : detail;
  }
}
