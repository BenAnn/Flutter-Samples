import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final String cover;
  final String title;
  final String path;
  final Color color;

  GridItem(
      {@required this.title,
      @required this.path,
      @required this.cover,
      this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            image:
                DecorationImage(image: AssetImage(cover), fit: BoxFit.cover)),
        child: Text(title, style: TextStyle(height: 1.5, color: color)),
      ),
      onTap: () {
        Navigator.pushNamed(context, path);
      },
    );
  }
}
