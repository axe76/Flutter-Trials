import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final key;
  final String username;
  final String userImage;

  MessageBubble(this.message,this.username,this.userImage,this.isMe,{this.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
        mainAxisAlignment: isMe?MainAxisAlignment.end:MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isMe? Colors.grey[300]: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: !isMe?Radius.circular(0):Radius.circular(12),
                bottomRight: isMe?Radius.circular(0):Radius.circular(12)
              )
            ),
            width: 140,
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
            margin: EdgeInsets.symmetric(vertical: 14,horizontal: 8),
            child: Column(
              crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
              children: [
                Text(
                      username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe? Colors.black:Theme.of(context).accentTextTheme.title.color,
                        )
                ),
                Text(
                  message,
                  style: TextStyle(color: isMe? Colors.black:Theme.of(context).accentTextTheme.title.color),
                  textAlign: isMe? TextAlign.end:TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    Positioned(//allows positioning of widgets in stack with respect to widget below in stack, in 2d space
      top: 0,
      left: isMe? null:120,
      right: isMe?120:null,
      child: CircleAvatar(
        backgroundImage: NetworkImage(userImage),
      )
    )  
    ],
    overflow: Overflow.visible,//allows widgets in stack that are clipped off to be visible
    );
  }
}