import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Faq extends StatelessWidget {
  Faq({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant FAQs'),
      ),
      body: Container(
        child: Column(
          children: const <Widget>[
            GFAccordion(
              title: "What Sort Of Restaurant Are You?",
              content:
                  "We aim to provide a thoroughly professional blend of skilled service and modern British cooking in a stylish and comfortable interior with emphasis on simple but fantastic, fresh ingredients.",
            ),
            GFAccordion(
              title: "What Is The Dress Code?",
              content:
                  "Our dress code is smart-casual. Vests and flip-flops are regarded as inappropriate attire.",
            ),
            GFAccordion(
              title: "How Do I Reserve A Table?",
              content:
                  "Table reservations can be made online HERE. Alternatively, please call us on 0115 123 4567 or email admin@gmail.com ",
            ),
            GFAccordion(
              title: "Do You Offer Set Menus?",
              content: "We do offer set menus, these can vary by season.",
            ),
            GFAccordion(
              title: "Do You Accept Credit Cards?",
              content:
                  "We accept all major credit cards, including debit cards with Visa or Mastercard logos.",
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:getwidget/components/accordion/gf_accordion.dart';

// class Faq extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("GFG Slider"),
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             ListView(
//               children: [
//                 CarouselSlider(
//                   items: [
//                     //1st Image of Slider
//                     Container(
//                       margin: EdgeInsets.all(6.0),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8.0),
//                         image: DecorationImage(
//                           image: NetworkImage(
//                             "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
//                           ),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),

//                     //2nd Image of Slider
//                     Container(
//                       margin: EdgeInsets.all(6.0),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8.0),
//                         image: DecorationImage(
//                           image: NetworkImage(
//                             "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
//                           ),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),

//                     //3rd Image of Slider
//                     Container(
//                       margin: EdgeInsets.all(6.0),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8.0),
//                         image: DecorationImage(
//                           image: NetworkImage("ADD IMAGE URL HERE"),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),

//                     //4th Image of Slider
//                     Container(
//                       margin: EdgeInsets.all(6.0),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8.0),
//                         image: DecorationImage(
//                           image: NetworkImage("ADD IMAGE URL HERE"),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),

//                     //5th Image of Slider
//                     Container(
//                       margin: EdgeInsets.all(6.0),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8.0),
//                         image: DecorationImage(
//                           image: NetworkImage("ADD IMAGE URL HERE"),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 50,
//                     ),
//                   ],

//                   //Slider Container properties
//                   options: CarouselOptions(
//                     height: 180.0,
//                     enlargeCenterPage: true,
//                     autoPlay: true,
//                     aspectRatio: 16 / 9,
//                     autoPlayCurve: Curves.fastOutSlowIn,
//                     enableInfiniteScroll: true,
//                     autoPlayAnimationDuration: Duration(milliseconds: 800),
//                     viewportFraction: 0.8,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Column(
//               children: const <Widget>[
//                 GFAccordion(
//                   title: "What Sort Of Restaurant Are You?",
//                   content:
//                       "We aim to provide a thoroughly professional blend of skilled service and modern British cooking in a stylish and comfortable interior with emphasis on simple but fantastic, fresh ingredients.",
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
