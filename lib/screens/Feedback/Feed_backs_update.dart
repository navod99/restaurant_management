import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_management/model/feedbackmodel.dart' as feedbk;

class UpdateFeedback extends StatelessWidget {
  final Feedback feedback;

  final TextEditingController CategoryController = TextEditingController();

  final TextEditingController DescriptionController = TextEditingController();

  UpdateFeedback({super.key, required this.feedback});

  @override
  Widget build(BuildContext context) {
    //  CategoryController.text = feedback.category;
    //  DescriptionController.text = feedback.description;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Feedback'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 20),
          getMyField(hintText: 'Category', controller: CategoryController),
          getMyField(
              hintText: 'Description', controller: DescriptionController),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    feedbk.Feedback updatedFeedback = feedbk.Feedback(
                        //  id: feedback.id,
                        category: CategoryController.text,
                        description: DescriptionController.text);

                    final CollectionReference =
                        FirebaseFirestore.instance.collection('feedback');
                    CollectionReference.doc(updatedFeedback.id)
                        .update(updatedFeedback.toJson())
                        .whenComplete(() {
                      log('Feedback Updted');
                    });
                    // feedbk.Feedback feedback = feedbk.Feedback(
                    //     category: CategoryController.text,
                    //     description: DescriptionController.text);
                    // //ToDO add student
                    // addfeedbackAndNavigateToHome(feedback, context);
                  },
                  child: const Text('Update')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey),
                  onPressed: () {
                    CategoryController.text = '';
                    DescriptionController.text = '';
                  },
                  child: const Text('Reset')),
            ],
          )
        ],
      )),
    );
  }

  Widget getMyField(
      {required String hintText,
      TextInputType textInputType = TextInputType.name,
      required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: 'Enter Category',
          labelText: hintText,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      ),
    );
  }

  void addfeedbackAndNavigateToHome(
      feedbk.Feedback feedback, BuildContext context) {
    final feedbackRef = FirebaseFirestore.instance.collection('feedback').doc();
    feedback.id = feedbackRef.id;
    final data = feedback.toJson();
    feedbackRef.set(data);
  }
}
