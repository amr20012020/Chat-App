import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/room.dart';

class RoomWidget extends StatelessWidget {
  Room room;
  RoomWidget(this.room);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * .4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0,3),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/images/${room.catId}.png",
                width: MediaQuery.of(context).size.width*.3,
                height: MediaQuery.of(context).size.height * .3,
              ),
          ),
          Text(room.title),
        ],
      ),
    );
  }
}
