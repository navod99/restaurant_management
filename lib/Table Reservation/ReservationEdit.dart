import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final CollectionReference eventsCollection =
    FirebaseFirestore.instance.collection('events');

class TableEdit extends StatefulWidget {
  final String id;
  final String date;
  final String time;
  final String count;
  final String name;
  const TableEdit({
    required this.id,
    required this.date,
    required this.time,
    required this.count,
    required this.name,
  });

  @override
  State<TableEdit> createState() => _TableEditState();
}

class _TableEditState extends State<TableEdit> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController name = TextEditingController();
  var people = 1;

  @override
  void initState() {
    super.initState();
    print(' ${widget.id} ${widget.name} ${widget.date} ${widget.time}');
    dateinput.text = widget.date;
    timeinput.text = widget.time;
    name.text = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit table"),
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
                  controller: timeinput, //editing controller of this TextField
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
                  icon: const Icon(Icons.do_disturb_on_outlined),
                  label: const Text('')),
              Text(people.toString()),
              OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      people++;
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('')),
            ],
          ),
          SizedBox(
              width: 300,
              child: TextFormField(
                scrollPadding: const EdgeInsets.only(bottom: 40),
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
              onPressed: () async {
                print(" $dateinput $name");
                await FirebaseFirestore.instance
                    .collection('TableReservation')
                    .doc(widget.id)
                    .update({
                  'Name': name.text,
                  'Date': dateinput.text,
                  'Time': timeinput.text,
                  'Count': people
                });
                if (mounted) {
                  setState(() {
                    name.text = '';
                    dateinput.text = '';
                    timeinput.text = '';
                    people = 1;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Row(children: const[
                      Icon(Icons.check),
                       Text(
                        "Updated Successfully",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ]),
                    duration: const Duration(seconds: 3),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Row(children: const [
                       Icon(Icons.warning_rounded),
                       Text(
                        "somthing went wrong!",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                    duration: const Duration(seconds: 3),
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ));
                }
              },
              child: const Text('Edit'))
        ],
      )),
    );
  }
}
