// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../../utils/colors.dart';
// import 'logic.dart';
// import 'state.dart';

// class HelpPage extends StatefulWidget {
//   const HelpPage({Key? key}) : super(key: key);

//   @override
//   State<HelpPage> createState() => _HelpPageState();
// }

// class _HelpPageState extends State<HelpPage> {
//   final HelpLogic logic = Get.put(HelpLogic());

//   final HelpState state = Get.find<HelpLogic>().state;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         leading: InkWell(
//           onTap: () {
//             Get.back();
//           },
//           child: const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Icon(
//               Icons.arrow_back_ios,
//               color: Colors.black,
//               size: 15,
//             ),
//           ),
//         ),
//         centerTitle: true,
//         title: Text(
//           'Contact Us',
//           style: state.appBarTextStyle,
//         ),
//       ),
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: customThemeColor.withOpacity(0.19),
//                         blurRadius: 40,
//                         spreadRadius: 0,
//                         offset: const Offset(
//                             0, 22), // changes position of shadow
//                       ),
//                     ],
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.white),
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: InkWell(
//                     onTap: () {
//                       launch('mailto:hello@bookabite.app');
//                     },
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Feel free to get in touch with us '
//                           'anytime if you have any queries or questions regarding our '
//                           'services at',
//                           style: state.contentTextStyle,
//                         ),
//                         Text(
//                           'hello@bookabite.app',
//                           style: state.contentTextStyle!
//                               .copyWith(color: customThemeColor),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: customThemeColor.withOpacity(0.19),
//                         blurRadius: 40,
//                         spreadRadius: 0,
//                         offset: const Offset(
//                             0, 22), // changes position of shadow
//                       ),
//                     ],
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.white),
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: InkWell(
//                     onTap: () {
//                       launch('mailto:feedback@bookabite.app');
//                     },
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'If you want us to share your valuable feedback to '
//                           'improve our services, write to us at',
//                           style: state.contentTextStyle,
//                         ),
//                         Text(
//                           'feedback@bookabite.app',
//                           style: state.contentTextStyle!
//                               .copyWith(color: customThemeColor),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: customThemeColor.withOpacity(0.19),
//                         blurRadius: 40,
//                         spreadRadius: 0,
//                         offset: const Offset(
//                             0, 22), // changes position of shadow
//                       ),
//                     ],
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.white),
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: InkWell(
//                     onTap: () {
//                       launch('http://www.facebook.com/bookabite_app');
//                     },
//                     child: Row(
//                       children: [
//                         Image.asset(
//                             'assets/FacebookOctDenoiserBeauty_001 copy.png'),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Book-a-Bite Facebook',
//                                 style: state.contentTextStyle,
//                               ),
//                               Text(
//                                 '@bookabite_app',
//                                 style: state.contentTextStyle,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: customThemeColor.withOpacity(0.19),
//                         blurRadius: 40,
//                         spreadRadius: 0,
//                         offset: const Offset(
//                             0, 22), // changes position of shadow
//                       ),
//                     ],
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.white),
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: InkWell(
//                     onTap: () {
//                       launch('http://www.instagram.com/bookabite_app');
//                     },
//                     child: Row(
//                       children: [
//                         Image.asset(
//                             'assets/InstagramOctDenoiserBeauty_001 copy.png'),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Book-a-Bite Instagram',
//                                 style: state.contentTextStyle,
//                               ),
//                               Text(
//                                 '@bookabite_app',
//                                 style: state.contentTextStyle,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: customThemeColor.withOpacity(0.19),
//                         blurRadius: 40,
//                         spreadRadius: 0,
//                         offset: const Offset(
//                             0, 22), // changes position of shadow
//                       ),
//                     ],
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.white),
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: InkWell(
//                     onTap: () {
//                       launch('http://www.twitter.com/bookabite_app');
//                     },
//                     child: Row(
//                       children: [
//                         Image.asset(
//                             'assets/TwitterOctDenoiserBeauty_001 copy.png'),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Book-a-Bite Twitter',
//                                 style: state.contentTextStyle,
//                               ),
//                               Text(
//                                 '@bookabite_app',
//                                 style: state.contentTextStyle,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: customThemeColor.withOpacity(0.19),
//                         blurRadius: 40,
//                         spreadRadius: 0,
//                         offset: const Offset(
//                             0, 22), // changes position of shadow
//                       ),
//                     ],
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.white),
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: InkWell(
//                     onTap: () {
//                       launch('http://www.bookabite.app/blog');
//                     },
//                     child: Row(
//                       children: [
//                         Image.asset('assets/Health.png'),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Book-a-Bite Blogs ',
//                                 style: state.contentTextStyle,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
