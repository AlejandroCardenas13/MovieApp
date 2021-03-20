import 'package:flutter/material.dart';
import 'package:movies/src/pages/detail_movie.dart';
import 'package:movies/src/pages/home_page.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  build(BuildContext context) => MaterialApp(
        title: 'Movies',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => HomePage(),
          'detail': (BuildContext context) => DetailMovie()
        },
      );
}
