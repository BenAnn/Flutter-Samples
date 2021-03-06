import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/carousel/Carousel.dart';
import 'package:flutter_samples/singlecarousel/SingleCarousel.dart';
import 'package:flutter_samples/FloatNavigator.dart';
import 'package:flutter_samples/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Effects',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.black),
              textTheme: TextTheme(
                  title: TextStyle(color: Colors.black, fontSize: 18.0)))),
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: {
        '/navigator': (BuildContext context) => FloatNavigator(),
        '/carousel': (BuildContext context) => Carousel(),
        '/singlecarousel': (BuildContext context) => SingleCarousel(),
      },
    );
  }
}
