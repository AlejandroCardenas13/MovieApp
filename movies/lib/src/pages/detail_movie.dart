import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:movies/src/models/movie_model.dart';

class DetailMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _createAppBar(movie),
        SliverList(
            delegate: SliverChildListDelegate([
          _postTitle(movie, context),
          _descriptionMovie(movie),
          _descriptionMovie(movie),
          _descriptionMovie(movie),
          _descriptionMovie(movie),
          _descriptionMovie(movie),
          _descriptionMovie(movie),
          _descriptionMovie(movie),
        ]))
      ],
    ));
  }

  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.bottomCenter,
          child: Text(
            movie.title,
            style: TextStyle(fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        background: FadeInImage(
          fit: BoxFit.cover,
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.getBackgroundImage()),
          fadeInDuration: Duration(milliseconds: 250),
        ),
      ),
    );
  }

  Widget _postTitle(Movie movie, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        children: [
          SizedBox(height: 20),
          ClipRRect(
            child:
                Image(image: NetworkImage(movie.getPosterImg()), height: 150.0),
            borderRadius: BorderRadius.circular(20),
          ),
          SizedBox(width: 20.0), //It's like a Div
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(movie.title,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.visible),
              Text(movie.originalTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis),
              Row(
                children: [
                  Icon(Icons.star_half),
                  Text(movie.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle1)
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _descriptionMovie(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
      child: Text(movie.overview, textAlign: TextAlign.justify),
    );
  }
}
