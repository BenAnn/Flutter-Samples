import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/GridItem.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Effects'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.all(10.0),
            sliver: SliverGrid.count(
              crossAxisCount: 3,
              children: <Widget>[
                GridItem(
                    cover: 'images/float_navigator.png',
                    title: 'Float Navigator',
                    path: '/navigator'),
                GridItem(
                    cover: 'images/carousel.gif',
                    title: 'Carousel',
                    color: Colors.red,
                    path: '/carousel'),
              ],
              childAspectRatio: 0.78,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
          )
        ],
      ),
    );
  }
}
