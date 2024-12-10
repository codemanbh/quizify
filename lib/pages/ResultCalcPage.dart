// import 'package:flutter/material.dart';

// class ResultCalcPage extends StatelessWidget {
//   final int score; // Score obtained by the user
//   final int totalQuestions; // Total number of questions

//   const ResultCalcPage({
//     Key? key,
//     required this.score,
//     required this.totalQuestions,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Calculate the percentage score
//     double percentage = (score / totalQuestions) * 100;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quiz Results'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Your Score: $score/$totalQuestions',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Percentage: ${percentage.toStringAsFixed(1)}%',
//                 style: TextStyle(fontSize: 20),
//               ),
//               SizedBox(height: 40),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Go back to the quiz page
//                 },
//                 child: Text('Retake Quiz'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }