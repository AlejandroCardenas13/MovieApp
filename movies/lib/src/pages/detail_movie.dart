import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/actors_provider.dart';

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
          _createCasting(movie),
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
          Hero(
            tag: movie.id,
            child: ClipRRect(
              child:
                  Image(image: NetworkImage(movie.getPosterImg()), height: 150.0),
              borderRadius: BorderRadius.circular(20),
            ),
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

  Widget _createCasting(Movie movie) {
    final ActorProvider _actorProvider = new ActorProvider();

    return FutureBuilder(
        future: _actorProvider.getActors(movie.id),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return _createActorsPageView(snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.1,
              ),
            );
          }
        });
  }

  Widget _createActorsPageView(List<Actor> actors) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
          pageSnapping: false,
          controller: PageController(viewportFraction: 0.2, initialPage: 1),
          itemCount: actors.length,
          itemBuilder: (BuildContext context, int i) => _actorCard(actors[i])),
    );
  }

  Widget _actorCard(Actor actor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: NetworkImage(
                  'https://i.pinimg.com/originals/fc/0c/77/fc0c7762eae4affd716151ef68be93b6.png'),
              image: NetworkImage(actor.getPosterActorImg()),
              height: 100,
              width: 150,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          SizedBox(height: 10),
          Text(
            actor.name,
            textAlign: TextAlign.start,
          )
        ],
      ),
    );
  }
}
