import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_samples/carousel/CustomPageView.dart';

class Carousel extends StatefulWidget {
  Carousel(
      {this.autoPlay = false, loop, this.delay = 4, this.speed = 400, Key key})
      : loop = autoPlay ? true : false,
        super(key: key);
  final bool autoPlay;
  final bool loop;
  final int delay;
  final int speed;
  @override
  _State createState() => _State();
}

class _State extends State<Carousel> {
  PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.9);
  int _currentIndex = 1;
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
  Timer _timer;

  @override
  void initState() {
    if (_images.length > 0 && widget.autoPlay) {
      _setTimer();
      _pageController = PageController(initialPage: 1, viewportFraction: 0.9);
    }
    super.initState();
  }

//设置定时器
  _setTimer() {
    _timer = Timer.periodic(Duration(seconds: widget.delay), (_) {
      _pageController.animateToPage(_currentIndex + 1,
          duration: Duration(milliseconds: widget.speed),
          curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    List addedImages = [];
    if (_images.length > 0 && widget.autoPlay) {
      addedImages
        ..add(_images[_images.length - 1])
        ..addAll(_images)
        ..add(_images[0]);
    } else {
      addedImages.addAll(_images);
    }
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Carousel'),
          centerTitle: true,
        ),
        body: Container(
          child: NotificationListener(
              onNotification: (ScrollNotification notification) {
                if (widget.autoPlay) {
                  if (notification.depth == 0 &&
                      notification is ScrollStartNotification) {
                    if (notification.dragDetails != null) {
                      _timer.cancel();
                    }
                  } else if (notification is ScrollEndNotification) {
                    _timer.cancel();
                    _setTimer();
                  }
                }
              },
              child: CustomPageView(
                loop: widget.loop,
                physics: BouncingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (page) {
                  if (widget.loop) {
                    int newIndex;
                    if (page == addedImages.length - 1) {
                      newIndex = 1;
                      _pageController.jumpToPage(newIndex);
                    } else if (page == 0) {
                      newIndex = addedImages.length - 2;
                      _pageController.jumpToPage(newIndex);
                    } else {
                      newIndex = page;
                    }
                    setState(() {
                      _currentIndex = newIndex;
                    });
                  } else {
                    setState(() {
                      _currentIndex = page;
                    });
                  }
                },
                children: addedImages
                    .map((item) => Container(
                          margin: EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.asset(
                              item,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ))
                    .toList(),
              )),
        ));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
