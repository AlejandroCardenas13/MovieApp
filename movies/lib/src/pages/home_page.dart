import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';
import 'package:movies/src/widgets/horizontal_movie.dart';

/**
 * if (snapshot.connectionState == ConnectionState.done)Una forma de comprobar si ya respondio el future
 * snapshot.data?.forEach((p) => print(p.title)); El signo de interrogación es para especificarle que ejecute el forEach si EXTISTE data
 * El StreamBuilder se va a ejecutar cada vez que se emita un valor en el stream
 * Cuando una función la declaramos moviesProvider.getPopularMovies es porque unicamente la estamos definidiendo 
 * mientras que si la pasamos moviesProvider.getPopularMovies() es para que se ejecute de una vez
 */

class HomePage extends StatelessWidget {
  final moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    moviesProvider.getPopularMovies();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Container(
            margin: EdgeInsets.only(top: 15.0),
            child: Text('Movies on Cinemax')),
        actions: [
          Container(
            margin: EdgeInsets.only(top: 15.0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () => null,
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _swiperCards(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperCards() {
    return FutureBuilder(
        future: moviesProvider.getOnMovies(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          
          if (snapshot.hasData)
            return CardSwiper(
              movies: snapshot.data,
            );
          else
            return Container(
              height: 380.0,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                ),
              ),
            );
        });
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Popular',
                  style: Theme.of(context).textTheme.subtitle1)),
          SizedBox(
            height: 9.0,
          ),
          StreamBuilder(
            
            stream: moviesProvider.getPopularMoviesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
      
              if (snapshot.hasData)
                return HorizontalMovie(
                  movies: snapshot.data,
                  nextPage: moviesProvider
                      .getPopularMovies, //Aqui paso la definición de la función, no la ejecución ()
                );
              else
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey,
                    ),
                  ),
                );
            },
          ),
          /* FutureBuilder(Usando FutreBuilder solo se ejecuta una vez
            future: moviesProvider.getPopularMovies(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData)
                return HorizontalMovie(
                  movies: snapshot.data,
                );
              else
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey,
                    ),
                  ),
                );
            },
          ),*/
        ],
      ),
    );
  }
}
