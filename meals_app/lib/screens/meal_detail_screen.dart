import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../models/meal.dart';

class MealDetail extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFav;
  final Function isfavourite;


  MealDetail(this.isfavourite,this.toggleFav);


  @override
  Widget build(BuildContext context) {

    final String mealId = ModalRoute.of(context).settings.arguments as String;

    final selectedMeal = DUMMY_MEALS.firstWhere((meal) {
      return meal.id == mealId;
    });

    Widget buildSectiontitle(String text){
      return Container(
            margin: EdgeInsets.all(10),
            child: Text(text,
                    style: Theme.of(context).textTheme.title,
                  ),
          );
    }

    Widget buildContainer(Widget child){
      return Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            
            decoration: BoxDecoration(color: Colors.white,
            border: Border.all(color:Colors.grey),
            borderRadius: BorderRadius.circular(10)),
            height:150,
            width:300,
            child:child);
    }

    return Scaffold(
      appBar: AppBar(title: Text("${selectedMeal.title}"),),
      body:SingleChildScrollView(
          child: Column(
          children:[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
                ),
            ),
            buildSectiontitle('Ingredients'),
            buildContainer(ListView.builder(
                itemBuilder: (ctx,index){
                  return Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical:5
                      ),
                      child: Text(selectedMeal.ingredients[index],style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  );
                },
                itemCount: selectedMeal.ingredients.length,
              )
            ),
            buildSectiontitle('Steps'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx,index){
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(child: Text('${index+1}'),),
                        title: Text('${selectedMeal.steps[index]}'),
                      ),
                      Divider(thickness: 2,)
                    ],
                  );
                },
                itemCount: selectedMeal.steps.length,
              )
            )
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isfavourite(mealId)? Icons.star: Icons.star_border
          ),
        onPressed: () => toggleFav(mealId),
        ),
    );
  }
}