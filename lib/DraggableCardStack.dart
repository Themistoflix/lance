import 'package:flutter/material.dart';
import 'DraggableCard.dart';

class DraggableCardStack extends StatefulWidget {
  @override
  _DraggableCardStackState createState() => _DraggableCardStackState();
}

class _DraggableCardStackState extends State<DraggableCardStack> {
  List<Widget> _cards;
  Widget _widgetWhenEmpty;



  void onSwipeLeft(){}

  void onSwipeRight(){}

  void addCard(widget){
    _cards.add(widget);
  }

  void removeTopCard(){
    _cards.removeAt(0);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget>children = _cards;
    children.add(_widgetWhenEmpty);

    return Stack(
      children: children,
    );
  }
}
