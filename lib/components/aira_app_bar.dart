import 'package:accessibility/components/text_size.dart';
import 'package:flutter/material.dart';

class AiraAppBar extends AppBar {
  Widget leftNav;
  Widget rightNav;
  String titleIn;

  AiraAppBar({this.titleIn = "Accessibility Test", this.leftNav, this.rightNav})
      : super(
            title: Row(children: [
          leftNav ?? Row(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage('images/airaName.png'),
              height: 30.0,
              semanticLabel: "Aira logo",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Center(
              child: Text(
                titleIn,
                style: TextStyle(fontSize: AiraTextSize.get()),
              ),
            ),
          ),

          rightNav ?? Row()
        ]));
}
