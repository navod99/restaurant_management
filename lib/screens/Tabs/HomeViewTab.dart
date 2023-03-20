import 'package:flutter/material.dart';

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
              cardView('Our Menu', 'assets/images/chef.png', size),
              cardView('Place Order', 'assets/images/order.png', size),
            ],
          ),
          const SizedBox(height: 48.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cardView('Table Reservation', 'assets/images/table.png', size),
              cardView('Feedback', 'assets/images/feedback.png', size),
            ],
          ),
        ],
      ),
    );
  }

  Widget cardView(String title, String imagePath, Size size) {
    return Container(
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
                  child: Text(title,
                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
