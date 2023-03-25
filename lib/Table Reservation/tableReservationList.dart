import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_management/Table%20Reservation/ResiveTable.dart';
import 'package:restaurant_management/screens/Common/BottomNavigatiobBar.dart';

final CollectionReference tableReservationCollection =
    FirebaseFirestore.instance.collection('TableReservation');

class TableReservationList extends StatelessWidget {
    int _tabIndex = 0;
  int itemCount = 0;
    void _onTapped(int index) {
    // setState(() {
    //   _tabIndex = index;
    // });
  }
  TableReservationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Table Reservation List'),
      ),
      body:Center(
      child: StreamBuilder<QuerySnapshot>(
        stream: tableReservationCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
    
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
    
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                  ),
                  child: ListTile(
                    title: Text(
                      data['Date'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    subtitle: Text(
                      data['Time'],
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                    ),
                    leading: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      (ResiveTable(id: data['id'].toString(),))));
                        },
                        child: Icon(Icons.edit),
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirm Deletion'),
                                content: Text(
                                    'Are you sure you want to delete this event?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('CANCEL'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      document.reference.delete();
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: const Text(
                                          "Sucessfully Deleted",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        duration: const Duration(seconds: 3),
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                      ));
                                    },
                                    child: Text('DELETE'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Icon(Icons.delete),
                      ),
                    ]),
                  ));
            }).toList(),
          );
        },
      ),
      ),
       bottomNavigationBar: BottomNavigation(
            tabIndex: 0, onTabTapped: _onTapped, itemCount: itemCount)
    );
  }
}
