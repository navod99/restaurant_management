import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final CollectionReference eventsCollection =
    FirebaseFirestore.instance.collection('events');

class TableEdit extends StatelessWidget {
  final String reservationId;

  const TableEdit({required this.reservationId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: eventsCollection.doc(reservationId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        String date = data['Date'];

        return Scaffold(
          appBar: AppBar(
            title: Text(data['Name']),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(data['Time']),
              ],
            ),
          ),
        );
      },
    );
  }
}
