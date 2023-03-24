//import 'dart:html';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:time_range/time_range.dart';
import 'package:intl/date_symbol_data_local.dart';

class ResiveTable extends StatefulWidget {
  const ResiveTable({super.key});

  @override
  State<ResiveTable> createState() => _ResiveTableState();
}

class _ResiveTableState extends State<ResiveTable> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController remarks = TextEditingController();
  var people = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Table Booking'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Image.asset(
              "assets/images/TableR.jpg",
              height: size.height * 0.5,
            ),
            SizedBox(
                width: 300,
                height: 80,
                child: TextFormField(
                  decoration: const InputDecoration(
                      icon: Icon(Icons.account_circle),
                      border: UnderlineInputBorder(),
                      labelText: 'Enter Your Name'),

                  controller: name,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                )),
            SizedBox(
                width: 300,
                height: 80,
                child: TextField(
                  controller: dateinput, //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Enter Date" //label text of field
                      ),
                  // The validator receives the text that the user has entered.
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime
                            .now(), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));
                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        dateinput.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                )),
            SizedBox(
                width: 300,
                height: 80,
                child: TextField(
                    controller:
                        timeinput, //editing controller of this TextField
                    decoration: const InputDecoration(
                        icon: Icon(Icons.timer), //icon of text field
                        labelText: "Enter Time" //label text of field
                        ),
                    readOnly:
                        true, //set it true, so that user will not able to edit text
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if (pickedTime != null) {
                        print(pickedTime.format(context)); //output 10:51 PM
                        // DateTime parsedTime =
                        //     DateFormat.jm().parse(pickedTime.format(context));
                        //converting to DateTime so that we can further format on different pattern.
                        // print(parsedTime); //output 1970-01-01 22:53:00.000
                        // String formattedTime =
                        //     DateFormat('HH:mm:ss').format(parsedTime);
                       // print(formattedTime); //output 14:59:00
                        //DateFormat() is from intl package, you can format the time on any pattern you need.

                        setState(() {
                          timeinput.text = pickedTime
                              .format(context)
                              .toString(); //set the value of text field.
                        });
                      } else {
                        print("Time is not selected");
                      }
                    })),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Gusts',
                  style: TextStyle(fontSize: 18),
                ),
                OutlinedButton.icon(
                    onPressed: () {
                      if (people > 1) {
                        setState(() {
                          people--;
                        });
                      }
                    },
                    icon: Icon(Icons.do_disturb_on_outlined),
                    label: Text('')),
                Text(people.toString()),
                OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        people++;
                      });
                    },
                    icon: Icon(Icons.add),
                    label: Text('')),
              ],
            ),
            SizedBox(
                width: 300,
                child: TextFormField(
                  scrollPadding: EdgeInsets.only(bottom: 40),
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(), labelText: 'Remarks'),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                )),
            ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('TableReservation')
                      .add(<String, dynamic>{
                    'Name': name.text,
                    'Date': dateinput.text,
                    'Time': timeinput.text,
                    'Count': people
                  });
                },
                child: Text('Book Table'))
          ],
        )));
  }
}
