import 'package:flutter/material.dart';

class ParticipantCard extends StatefulWidget {
  final String name;
  final int cups;
  final bool isCurrentUser;
  final int rank;
  final VoidCallback onIncrement;

  ParticipantCard({
    required this.name,
    required this.cups,
    required this.isCurrentUser,
    required this.rank,
    required this.onIncrement,
  });

  @override
  _ParticipantCardState createState() => _ParticipantCardState();
}

class _ParticipantCardState extends State<ParticipantCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  void animate() {
    _controller.forward().then((_) => _controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    Color medalColor;
    switch(widget.rank) {
      case 0: medalColor = Colors.amber; break;
      case 1: medalColor = Colors.grey; break;
      case 2: medalColor = Colors.brown; break;
      default: medalColor = Colors.blueAccent;
    }

    return ScaleTransition(
      scale: _animation,
      child: Card(
        color: widget.isCurrentUser ? Colors.red[100] : Colors.white,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        elevation: 4,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: medalColor,
            child: Text('${widget.rank + 1}'),
          ),
          title: Text(widget.name, style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${widget.cups} 🍺', style: TextStyle(fontSize: 18)),
              if(widget.isCurrentUser)
                IconButton(
                  icon: Icon(Icons.add, color: Colors.green),
                  onPressed: () {
                    widget.onIncrement();
                    animate();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
