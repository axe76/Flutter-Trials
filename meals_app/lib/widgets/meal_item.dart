import 'package:flutter/material.dart';
import '../screens/meal_detail_screen.dart';

import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imgUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  String get complexityText{
    switch(complexity){
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText{
    switch(affordability){
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      case Affordability.Luxurious:
        return 'Expensive';
        break;
      default:
        return 'Unknown';
    }
  }

  MealItem({
    @required this.id,
    @required this.title,
    @required this.affordability,
    @required this.imgUrl,
    @required this.complexity,
    @required this.duration});
  
  void selectMeal(BuildContext ctx){
    Navigator.of(ctx).pushNamed(MealDetail.routeName,arguments: id);
  }
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
        children: [
          Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
              child: Image.network(imgUrl,height: 250,fit: BoxFit.cover,width: double.infinity,),
            ),
            Positioned(
                right: 5,
                bottom: 20,
                child: Container(
                  width: 270,
                color: Colors.black54,
                padding: EdgeInsets.all(10),
                child: Text(title,style: TextStyle(
                  fontSize: 26,
                  color: Colors.white
                ),
                softWrap: true,
                overflow: TextOverflow.fade,
                ),
              ),
            ),
          ],),
          Padding(padding: EdgeInsets.all(10),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Row(
              children: [
                Icon(Icons.schedule),
                SizedBox(width:6),
                Text('${duration} min'),
              ],),
            Row(
              children: [
                Icon(Icons.work),
                SizedBox(width:6),
                Text(complexityText),
              ],),
            Row(
              children: [
                Icon(Icons.attach_money),
                SizedBox(width:6),
                Text(affordabilityText),
              ],)
          ],),
          )
        ],
      ),
    )
  );
  }
}