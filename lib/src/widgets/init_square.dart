import 'package:flutter/material.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';

class SqarePrefs extends StatelessWidget {
  final Widget child;
  final HexColor color;

  const SqarePrefs({Key key, this.child, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*.13,
      decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 2),color: color),
      child: child,
    );
  }
}
