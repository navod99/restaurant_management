import 'dart:developer';
import 'package:quickalert/quickalert.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_management/model/feedbackmodel.dart' as feedbk;
import 'package:restaurant_management/screens/Feedback/Feed_back_List.dart';

class AddFeedback extends StatefulWidget {
  const AddFeedback({super.key});

  @override
  State<AddFeedback> createState() => _AddFeedbackState();
}

class _AddFeedbackState extends State<AddFeedback> {
  final TextEditingController CategoryController = TextEditingController();
  final TextEditingController DescriptionController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final Color firstColor = Color.fromARGB(255, 95, 156, 192);
  final Color secondColor = Color.fromARGB(255, 14, 156, 133);
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //upto here
        children: [
          ClipPath(
            clipper: MyClipper(),
            child: Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [firstColor, secondColor]),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 82, 165, 49),
                          blurRadius: 12,
                          offset: Offset(0, 6))
                    ])),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 50, 10),
            child: Positioned(
                top: 1,
                left: 25,
                child: Text(
                  'Help us improve the Service!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 18.0,
                      color: Colors.black),
                )),
          ),
          getMyField(
              focusNode: focusNode,
              hintText: 'Category',
              controller: CategoryController),
          getMyField(
              hintText: 'Description', controller: DescriptionController),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 25, 164, 182)),
                  onPressed: () {
                    setState(() {
                      CategoryController.text.isEmpty
                          ? _validate = true
                          : _validate = false;
                    });

                    feedbk.Feedback feedback = feedbk.Feedback(
                        category: CategoryController.text,
                        description: DescriptionController.text);
                    addfeedbackAndNavigateToHome(feedback, context);
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Fonts/Oswald-Bold.ttf',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 59, 209, 164)),
                  onPressed: () {
                    CategoryController.text = '';
                    DescriptionController.text = '';
                    focusNode.requestFocus();
                  },
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Fonts/Oswald-Bold.ttf',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          )
        ],
      )),
    );
  }

  Widget getMyField({
    required String hintText,
    TextInputType textInputType = TextInputType.name,
    required TextEditingController controller,
    FocusNode? focusNode,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: 'Enter Text',
          labelText: hintText,
          errorText: _validate ? 'Value Can\'t Be Empty' : null,
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
    feedbackRef.set(data).whenComplete(() {
      if (_validate = true) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Thank you!',
        );
      }
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => FeedbackList(),
      //     ));
    });
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 70);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 300);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}





// class AddFeedback extends StatefulWidget {
//   const AddFeedback({super.key});

//   @override
//   State<AddFeedback> createState() => _AddFeedbackState();
// }

// class _AddFeedbackState extends State<AddFeedback> {
//   final TextEditingController CategoryController = TextEditingController();
//   final TextEditingController DescriptionController = TextEditingController();
//   final TextEditingController RatingController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Feedback'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//           child: Column(
//         children: [
//           getMyField(hintText: 'Category', controller: CategoryController),
//           getMyField(
//               hintText: 'Description', controller: DescriptionController),
//           getMyField(
//               hintText: 'Rating',
//               textInputType: TextInputType.number,
//               controller: RatingController),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                   onPressed: () {
//                     feedbk.Feedback feedback = feedbk.Feedback(
//                       category: CategoryController.text,
//                       description: DescriptionController.text,
//                       rating: double.parse(RatingController.text),
//                     );
//                     //ToDO add student
//                     addfeedbackAndNavigateToHome(feedback, context);
//                   },
//                   child: const Text('Submit')),
//               ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blueGrey),
//                   onPressed: () {
//                     CategoryController.text = '';
//                     DescriptionController.text = '';
//                     RatingController.text = '';
//                   },
//                   child: const Text('Reset')),
//             ],
//           )
//         ],
//       )),
//     );
//   }

//   Widget getMyField(
//       {required String hintText,
//       TextInputType textInputType = TextInputType.name,
//       required TextEditingController controller}) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: TextField(
//         controller: controller,
//         keyboardType: textInputType,
//         decoration: InputDecoration(
//           hintText: 'Enter Category',
//           labelText: hintText,
//           border: const OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(5))),
//         ),
//       ),
//     );
//   }

//   void addfeedbackAndNavigateToHome(
//       feedbk.Feedback feedback, BuildContext context) {
//     final feedbackRef =
//         FirebaseFirestore.instance.collection('feedbacks').doc();
//     feedback.id = feedbackRef.id;
//     final data = feedback.toJson();
//     feedbackRef.set(data).whenComplete(() {
//       QuickAlert.show(
//         context: context,
//         type: QuickAlertType.success,
//         text: 'Thank you! Feedback Submitted Successfully.',
//       );
//       // Navigator.pushReplacement(
//       //     context,
//       //     MaterialPageRoute(
//       //       builder: (context) => FeedbackList(),
//       //     ));
//     });
//   }
// }