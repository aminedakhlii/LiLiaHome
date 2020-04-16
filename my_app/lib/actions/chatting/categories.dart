import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget{
  @override
  CategorySelectorState  createState() => CategorySelectorState();
}
class CategorySelectorState extends State<CategorySelector> {
  int selected_index = 0 ;
  final List<String> categories = ['Messages','Online','Groups' , 'Settings'];
  Widget build(BuildContext context){
      return Container(
        height: 90.0,
        color: Theme.of(context).primaryColor,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (BuildContext context , int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selected_index = index ;
                    });
                  },
                  child : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0 , vertical: 30.0),
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      color: index == selected_index ? Colors.white : Colors.white60 ,
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.6
                    ),
                  ),
                ),
                );
            } ),
      );
  }
}

