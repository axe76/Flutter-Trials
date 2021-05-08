import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters-screen';

  final Function saveFilters;

  final Map<String,bool> currentFilters;

  FiltersScreen(this.currentFilters,this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegetarian = false;
  bool _vegan = false;

  @override
  initState(){
    _glutenFree = widget.currentFilters['glutenFree'];
    _lactoseFree = widget.currentFilters['lactoseFree'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    super.initState();

  }

  Widget _buildSwitchListTile(String title, String description, bool currentVal, Function onChange){
    return SwitchListTile(
                  title: Text(title),
                  subtitle: Text(description),
                  value: currentVal, 
                  onChanged: onChange);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
            icon: Icon(Icons.save), 
            onPressed: (){
              Map<String,bool> newFilters = {
                'glutenFree':_glutenFree,
                'lactoseFree':_lactoseFree,
                'vegetarian':_vegetarian,
                'vegan':_vegan
              };
              widget.saveFilters(newFilters);
            },
            )
        ],
        ),
      drawer: MainDrawer(),
      body:Column(
        children:[
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Customize meals',style: Theme.of(context).textTheme.title,)
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  'Gluten-Free',
                  'Show only Gluten-Free meals',
                  _glutenFree,
                  (newVal){
                    setState(() {
                      _glutenFree = newVal;
                    });
                  }
                ),
                _buildSwitchListTile(
                  'Lactose-Free',
                  'Show only Lactose-Free meals',
                  _lactoseFree,
                  (newVal){
                    setState(() {
                      _lactoseFree = newVal;
                    });
                  }
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Show only Vegetarian meals',
                  _vegetarian,
                  (newVal){
                    setState(() {
                      _vegetarian= newVal;
                    });
                  }
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Show only Vegan meals',
                  _vegan,
                  (newVal){
                    setState(() {
                      _vegan = newVal;
                    });
                  }
                ),
              ],
            )
          )
        ]
      ),
    );
  }
}