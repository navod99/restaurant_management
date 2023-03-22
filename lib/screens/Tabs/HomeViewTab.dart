// ignore: file_names
import 'package:flutter/material.dart';
import 'package:restaurant_management/screens/FeedbackForm.dart';

class HomeViewTab extends StatelessWidget {
  const HomeViewTab({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              cardView('Our Menu', 'assets/images/chef.png', size, context),
              cardView('Place Order', 'assets/images/order.png', size, context),
            ],
          ),
          const SizedBox(height: 48.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cardView('Table Reservation', 'assets/images/table.png', size,
                  context),
              cardView('Feedback', 'assets/images/feedback.png', size, context),
            ],
          ),
        ],
      ),
    );
  }

  Widget cardView(
      String title, String imagePath, Size size, BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (title) {
          case 'Our Menu':
            {}
            break;
          case 'Place Order':
            {
              // print("object");
              // final navigator = Navigator.of(context);
              // navigator.push(
              //   MaterialPageRoute(builder: (context) => const OrderScreen()),
              // );
              // const OrderScreen();
            }
            break;
          case 'Table Reservation':
            {}
            break;
          case 'Feedback':
            {
              print("object");
              final navigator = Navigator.of(context as BuildContext);
              navigator.push(
                MaterialPageRoute(builder: (context) => const FeedbackForm()),
              );
              const FeedbackForm();
            }
            break;
          default:
            {}
            break;
        }
      },
      child: Container(
        color: Colors.black,
        child: SizedBox(
          width: size.width * 0.4,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  imagePath,
                  height: size.height * 0.2,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
   
   
   
   
   
   
    // return Container(
    //   color: Colors.black,
    //   child: SizedBox(
    //     width: size.width * 0.4,
    //     child: Card(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Image.asset(
    //             imagePath,
    //              height: size.height * 0.2,
    //           ),
    //           Center(
    //             child: Padding(
    //               padding: const EdgeInsets.all(12.0),
    //               child: Text(title,
    //                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  
