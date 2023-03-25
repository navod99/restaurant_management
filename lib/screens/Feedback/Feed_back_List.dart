import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:restaurant_management/model/feedbackmodel.dart' as feedbk;
import 'package:restaurant_management/screens/Feedback/Feed_backs.dart';
import 'package:restaurant_management/screens/Feedback/Feed_backs_update.dart';

class FeedbackList extends StatelessWidget {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('feedback');

  // List<Feedback> feedbacks =
  //     feed.Feedback(id: 'id', category: 'category', description: 'description')
  //         as List<Feedback>;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Suggestions"),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _reference.get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data!;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;
            List<feedbk.Feedback> feedbacks = documents
                .map((e) => feedbk.Feedback(
                    id: e['id'],
                    category: e['category'],
                    description: e['description']))
                .toList();
            return _getBody(feedbacks);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        // child: _getBody()
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (() {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => const AddFeedback(),
      //         ));
      //   }),
      //   child: const Icon(Icons.add),
      // )
    );
  }

  Widget _getBody(feedbacks) {
    return feedbacks.isEmpty
        ? const Center(
            child: Text(
              "No feedbacks available",
            ),
          )
        : ListView.builder(
            itemCount: feedbacks.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                title: Text(feedbacks[index].category),
                subtitle: Text('Description: ${feedbacks[index].description}'),
                leading: const Icon(
                  Icons.account_circle_sharp,
                  size: 35,
                ),
                contentPadding: const EdgeInsets.all(15),
                tileColor: Color.fromARGB(255, 239, 245, 247),
                trailing: SizedBox(
                    width: 60,
                    child: Row(
                      children: [
                        InkWell(
                          child: const Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                          onTap: () {
                            //navigator
                          },
                        ),
                        InkWell(
                          child: const Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 78, 68, 67),
                          ),
                          onTap: () {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.confirm,
                              text: 'This will permanently delete this data.',
                            );
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => FeedbackList(),
                            //     ));
                          },
                        ),
                      ],
                    )),
              ),
            ),
          );
  }
}
