import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SingleCarousel extends StatefulWidget {
  SingleCarousel({Key key}) : super(key: key);

  @override
  _SingleCarouselState createState() {
    return _SingleCarouselState();
  }
}

class _SingleCarouselState extends State<SingleCarousel> {
  List<String> _images = [
    'images/1.png',
    'images/2.png',
    'images/3.png',
    'images/4.png',
    'images/5.png',
    'images/6.png',
    'images/7.png',
    'images/8.png',
    'images/9.png',
  ];
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("ListViewBuilder"),
        ),
        body: new Container(
          child: Scrollable(
            dragStartBehavior: DragStartBehavior.start,
            axisDirection: AxisDirection.right,
            controller: PageController(initialPage: 0, viewportFraction: 0.9),
            physics: PageScrollPhysics(),
            viewportBuilder: (BuildContext context, ViewportOffset position) {
              return Viewport(
                cacheExtent: 0.0,
                axisDirection: AxisDirection.right,
                offset: position,
                slivers: <Widget>[
                  SliverFillViewport(
                    viewportFraction:
                        PageController(initialPage: 1, viewportFraction: 0.9)
                            .viewportFraction,
                    delegate: SliverChildListDelegate(
                      _images
                          .map((item) => Container(
                                margin: EdgeInsets.all(10.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Image.asset(
                                    item,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
