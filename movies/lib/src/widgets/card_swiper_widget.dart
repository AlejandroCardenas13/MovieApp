import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  CardSwiper({@required this.movies});

  @override
  build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.only(top: 10.0),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) => ClipRRect(
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(movies[index].getPosterImg()),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          itemCount: movies.length,
          //pagination: SwiperPagination(),
          //control: SwiperControl(),
          layout: SwiperLayout.STACK,
          itemWidth: _screenSize.width * 0.60,
          itemHeight: _screenSize.height * 0.40,
        ));
  }
}
