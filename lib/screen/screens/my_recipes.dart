import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/models/Recipe.dart';

import '../../const/const.dart';
import '../../design/color.dart';
import '../widget/app_bar_design.dart';

class MyRecipes extends StatefulWidget {
  const MyRecipes({Key? key}) : super(key: key);

  @override
  State<MyRecipes> createState() => _MyRecipesState();
}

class _MyRecipesState extends State<MyRecipes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBar('My Recipes'),
      body: FirebaseAnimatedList(
        query: FirebaseDatabase.instance.reference().child(users)
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child(recipes),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          if (snapshot.exists && snapshot.value != null) {
            Recipe recipe = Recipe.fromJson(snapshot.value);

            //list item design
            return Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Appointment date',
                        style: TextStyle(
                            fontSize: 18, color: CustomColors.primaryBlackColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        recipe.appointmentDate ?? '',
                        style: TextStyle(
                            fontSize: 18, color: CustomColors.lightBlueColor),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Appointment Type',
                        style: TextStyle(
                            fontSize: 18, color: CustomColors.primaryBlackColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        recipe.appointmentType ?? '',
                        style: TextStyle(
                            fontSize: 18, color: CustomColors.lightBlueColor),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Doctor Name',
                        style: TextStyle(
                            fontSize: 18, color: CustomColors.primaryBlackColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        recipe.doctorName ?? '',
                        style: TextStyle(
                            fontSize: 18, color: CustomColors.lightBlueColor),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Diagnosis',
                        style: TextStyle(
                            fontSize: 18, color: CustomColors.primaryBlackColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        recipe.diagnosis ?? '',
                        style: TextStyle(
                            fontSize: 18, color: CustomColors.lightBlueColor),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Recipe',
                        style: TextStyle(
                            fontSize: 18, color: CustomColors.primaryBlackColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        recipe.recipe ?? '',
                        style: TextStyle(
                            fontSize: 18, color: CustomColors.lightBlueColor),
                      ),
                    ),
                  ],
                ),

              ],
            );
          } else {
            return const Text('no data ');
          }
        },
      ),
    );
  }
}
