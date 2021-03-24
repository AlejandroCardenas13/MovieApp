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
        padding: EdgeInsets.only(top: 1.0),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            movies[index].uniqueId = '${movies[index].id}-swiper';

            return Hero(
              tag: movies[index].uniqueId,
              child: ClipRRect(
                child: GestureDetector(
                  child: FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(movies[index].getPosterImg()),
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'detail',
                        arguments: movies[index]);
                  },
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
            );
          },
          itemCount: movies.length,
          //pagination: SwiperPagination(),
          //control: SwiperControl(),
          layout: SwiperLayout.STACK,
          itemWidth: _screenSize.width * 0.70,
          itemHeight: _screenSize.height * 0.50,
        ));
  }
}
