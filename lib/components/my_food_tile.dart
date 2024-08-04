import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shieldhealth/helpers/helper_functions.dart';
import '../models/food.dart';

class FoodTile extends StatelessWidget {
  final Food food;
  final void Function()? onTap;
  final void Function(BuildContext)? onEditPressed;
  final void Function(BuildContext)? onDeletePressed;

  const FoodTile(
      {super.key,
      required this.food,
      required this.onTap,
      required this.onDeletePressed,
      required this.onEditPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              //settings option
              SlidableAction(
                onPressed: onEditPressed,
                icon: Icons.settings,
                foregroundColor: Color(0xffF5BE63),
                backgroundColor: Color(0xff003c3a),
                borderRadius: BorderRadius.circular(4),
              ),
              SlidableAction(
                onPressed: onDeletePressed,
                icon: Icons.delete,
                foregroundColor: Color(0xffF5BE63),
                backgroundColor: Color(0xff003c3a),
                borderRadius: BorderRadius.circular(4),
              ),
              //delete option
            ],
          ),
          child: GestureDetector(
            onTap: onTap,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 25.0, left: 15.0, right: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff003c3a),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff001b1a),
                        offset: Offset(10.0, 10.0),
                        blurRadius: 12.0,
                        spreadRadius: 1.0),
                    BoxShadow(
                        color: Color(0xff004b49),
                        offset: Offset(-10.0, -10.0),
                        blurRadius: 12.0,
                        spreadRadius: 1.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      //text food details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              food.name,
                              style: TextStyle(color: Color(0xffdcc6a7)),
                            ),
                            Text(
                              'Calories: ' +
                                  formatAmount(food.calories).toString() +
                                  ' kcal',
                              style: TextStyle(color: Color(0xffF5BE63)),
                            ),
                            Text(
                              'Carbs: ' +
                                  formatAmount(food.carbs).toString() +
                                  ' g',
                              style: TextStyle(color: Color(0xffF5BE63)),
                            ),
                            Text(
                              'Protein: ' +
                                  formatAmount(food.protein).toString() +
                                  ' g',
                              style: TextStyle(color: Color(0xffF5BE63)),
                            ),
                            Text(
                              'Fat: ' +
                                  formatAmount(food.fat).toString() +
                                  ' g',
                              style: TextStyle(color: Color(0xffF5BE63)),
                            ),
                            Text(
                              'Fiber: ' +
                                  formatAmount(food.fiber).toString() +
                                  ' g',
                              style: TextStyle(color: Color(0xffF5BE63)),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      //food image,
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(
                              0xff003c3a), // Base color for neumorphic effect
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            // Simulating inner shadow effect
                            BoxShadow(
                              color: Color(0xff002a29), // Dark shadow color
                              offset: Offset(-4, -4),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                            BoxShadow(
                              color: Color(0xff004b49), // Light highlight color
                              offset: Offset(4, 4),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(48),
                            child: Image.asset(
                              food.imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
