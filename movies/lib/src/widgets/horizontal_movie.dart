import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';

class HorizontalMovie extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;

  HorizontalMovie({@required this.movies, @required this.nextPage});

  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.30,

      //La diferencia entre el PageView y el PageView.builder es que el PageView va a renderizar todos los elementos que contenga Movies de forma simultanea lo que podría generar problemas de memoria
      //mientras que el PageView.builder los va a renderizar conforme son necesarios (A demanda)
      child: PageView.builder(
        //PageView(
        pageSnapping: false,
        controller: _pageController,
        //children: _cards(context)
        itemCount: movies.length,
        itemBuilder: (context, index) =>
            _createCard(context, movies[index], _screenSize),
      ),
    );
  }

  Widget _createCard(BuildContext context, Movie movie, Size size) {
    movie.uniqueId = '${movie.id}-card';
    final card = Container(
      padding: EdgeInsets.only(top: size.height * 0.022),
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.getPosterImg()),
                fit: BoxFit.cover,
                height: 170,
              ),
            ),
          ),
          SizedBox(
            height: 7.0,
          ),
          Center(
            child: Text(
              movie.title,
              style: Theme.of(context).textTheme.caption,
              //overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
    return GestureDetector(
      child: card,
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
    );
  }

  List<Widget> _cards(BuildContext context) => movies
      .map(
        (movie) => Container(
          margin: EdgeInsets.only(right: 15.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.getPosterImg()),
                  fit: BoxFit.cover,
                  height: 170,
                ),
              ),
              SizedBox(
                height: 7.0,
              ),
              Center(
                child: Text(
                  movie.title,
                  style: Theme.of(context).textTheme.caption,
                  //overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      )
      .toList();
}
