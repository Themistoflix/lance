import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class DraggableCard extends StatefulWidget {
  final Widget cardContent;
  Function onSwipeLeft;
  Function  onSwipeRight;

  DraggableCard(this.cardContent, this.onSwipeLeft, this.onSwipeRight);

  @override
  _DraggableCardState createState() => _DraggableCardState();
}


class _DraggableCardState extends State<DraggableCard> with SingleTickerProviderStateMixin{
  AnimationController _controller;

  Animation<Alignment> _springBackAnimation;
  Animation<Alignment> _slideOutAnimation;

  bool _isSpringBackAnimationActive;
  bool _isSlideOutAnimationActive;


  Offset _panStartPosition;
  Alignment _position = Alignment.center;

  double calculateUnitVelocity(Offset pixelsPerSecond, Size size){
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);

    return unitsPerSecond.distance;
  }

  void _runSpringBackAnimation(Offset pixelsPerSecond, Size size){
    _isSlideOutAnimationActive = false;
    _isSpringBackAnimationActive = true;

    _controller.duration = Duration(milliseconds: 250);
    _springBackAnimation = AlignmentTween(
      begin: _position,
      end: Alignment.center,
    ).animate(_controller);


    /*final unitVelocity = calculateUnitVelocity(pixelsPerSecond, size);

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation);*/

    _controller.forward(from: 0.0);

  }

  void _runSlideOutAnimation(Offset pixelsPerSecond, Size size){
    _isSlideOutAnimationActive = true;
    _isSpringBackAnimationActive = false;

    _controller.duration = Duration(milliseconds: 500);
    _slideOutAnimation = (AlignmentTween(
      begin: _position,
      end: Alignment((_position.x - _panStartPosition.dx)*10.0, (_position.y - _panStartPosition.dy)*10.0),
    )).animate(_controller);

    /*final unitVelocity = calculateUnitVelocity(pixelsPerSecond, size);

    const spring = SpringDescription(
        mass: 30,
        stiffness: 1,
        damping: 1
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);*/

    _controller.forward(from: 0.0);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
    _isSlideOutAnimationActive = false;
    _isSpringBackAnimationActive = false;

    _controller.addListener((){
      setState(() {
        if (_isSpringBackAnimationActive == true) {
          _position = _springBackAnimation.value;
        }else if (_isSlideOutAnimationActive == true){
          _position = _slideOutAnimation.value;
        }

      });
    });

    _controller.addStatusListener((status){
      if(status == AnimationStatus.completed){
        _isSlideOutAnimationActive = false;
        _isSpringBackAnimationActive = false;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onPanStart: (details){
        _panStartPosition = Offset(details.localPosition.dx/(screenSize.width/2) - 1.0, details.localPosition.dy/(screenSize.height/2) - 1.0);
        _controller.stop();
      },
      onPanUpdate: (details){
        setState(() {
          _position += Alignment(
            details.delta.dx / (screenSize.width/2),
            details.delta.dy / (screenSize.height/2)
          );
        });
      },

      onPanEnd: (details){
        if((_position.x - _panStartPosition.dx).abs() < 0.2) {
          print('back');
          _runSpringBackAnimation(details.velocity.pixelsPerSecond, screenSize);
        }else{
          _runSlideOutAnimation(details.velocity.pixelsPerSecond, screenSize);
          if(_position.x - _panStartPosition.dx > 0.0){
            _controller.addStatusListener((status){
              if(status == AnimationStatus.completed) {
                widget.onSwipeRight();
                print('right');
              }
            });

          }else{
            _controller.addStatusListener((status){
              if(status == AnimationStatus.completed) {
                widget.onSwipeRight();
                print('left');
              }
            });

          }
        }
      },

      child: Align(
        alignment: _position,
        child: widget.cardContent,
      ),

    );

  }

}
