//import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:time_range/time_range.dart';

class ResiveTable extends StatefulWidget {
  const ResiveTable({super.key});

  @override
  State<ResiveTable> createState() => _ResiveTableState();
}

class _ResiveTableState extends State<ResiveTable> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Table Booking'),
        ),
        body: Column(
          children: [
            SizedBox(
                width: 300,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter Your Name'),
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
                      String formattedDate = pickedDate.toString();
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
                height: 200,
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
                        // print(pickedTime.format(context));   //output 10:51 PM
                        // DateTime parsedTime =pickedTime.toString();
                        // //converting to DateTime so that we can further format on different pattern.
                        // print(parsedTime); //output 1970-01-01 22:53:00.000
                        // String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                        // print(formattedTime); //output 14:59:00
                        // //DateFormat() is from intl package, you can format the time on any pattern you need.

                        setState(() {
                          timeinput.text = pickedTime
                              .toString(); //set the value of text field.
                        });
                      } else {
                        print("Time is not selected");
                      }
                    })),
                    SizedBox(
                width: 300,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter Your Name'),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                )),
          ],
        ));
  }
}
