import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = "/settings";
  final Function setFilters;
  final Map<String, bool> currentFilters;

  SettingsScreen(this.currentFilters, this.setFilters);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters["isGlutenFreeOn"];
    _lactoseFree = widget.currentFilters["isLactoseFreeOn"];
    _vegan = widget.currentFilters["isVeganOn"];
    _vegetarian = widget.currentFilters["isVegetarianOn"];

    super.initState();
  }

  Widget _buildSwitchListTile(
    String titleText,
    String subtitleText,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile.adaptive(
      title: Text(
        titleText,
        style: Theme.of(context).textTheme.title,
      ),
      subtitle: Text(subtitleText),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: 16,
              top: 16,
              bottom: 4,
            ),
            alignment: Alignment.centerLeft,
            child: Text("filters",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.tealAccent,
                )),
          ),
          Expanded(
            child: ListView(
              //padding: EdgeInsets.all(8),
              children: <Widget>[
                _buildSwitchListTile(
                  "Gluten free",
                  "only include gluten free meals",
                  _glutenFree,
                  (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  "Lactose free",
                  "only include lactose free meals",
                  _lactoseFree,
                  (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  "Vegan",
                  "only include vegan meals",
                  _vegan,
                  (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  "Vegetarian",
                  "only include vegetarian meals",
                  _vegetarian,
                  (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Tooltip(
          message: "save filters",
          verticalOffset: 40,
          child: Builder(
            //used Builder widget only for showing SnackBars
            builder: (BuildContext context) {
              return FloatingActionButton(
                child: Icon(Icons.save),
                onPressed: () {
                  final selectedFilters = {
                    "isGlutenFreeOn": _glutenFree,
                    "isLactoseFreeOn": _lactoseFree,
                    "isVeganOn": _vegan,
                    "isVegetarianOn": _vegetarian,
                  };

                  widget.setFilters(selectedFilters);

                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Filters saved successfully!",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                      duration: Duration(
                        milliseconds: 2000,
                      ),
                    ),
                  );
                },
              );
            },
          )),
    );
  }
}
