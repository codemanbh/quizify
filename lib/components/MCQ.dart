import 'package:flutter/material.dart';

class MCQ extends StatefulWidget {
  const MCQ({super.key});

  @override
  State<MCQ> createState() => _MCQState();
}

class _MCQState extends State<MCQ> {
  List<String> answers = ['', ''];
  List<bool> correctAnswers = [false, false];

  GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();

  // Widget MyCard( BuildContext context, Animation animation, int index){
  //   return Card(
  //                   child: ListTile(
  //                     title: TextField(
  //                       decoration:
  //                           InputDecoration(labelText: 'answer ${index + 1}'),
  //                     ),
  //                     trailing: IconButton(
  //                         onPressed: () {
  //                           String removedItem = answers[index];
  //                           answers.removeAt(index);
  //                           animatedListKey.currentState!.removeItem(
  //                               index,
  //                               (context, animation) => ScaleTransition(
  //                                     scale: animation,
  //                                     child: Card(
  //                                       child: ListTile(
  //                                         title: Text(
  //                                             removedItem), // Display the removed item
  //                                       ),
  //                                     ),
  //                                   ),
  //                               duration: Duration(milliseconds: 300));
  //                         },
  //                         icon: Icon(Icons.delete)),
  //                   ),
  //                 )
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: AnimatedList(
              key: animatedListKey,
              initialItemCount: answers.length,
              itemBuilder: (context, index, animation) => ScaleTransition(
                  scale: animation,
                  child: Card(
                    child: ListTile(
                      title: TextField(
                        decoration:
                            InputDecoration(labelText: 'answer ${index + 1}'),
                      ),
                      leading: Checkbox(
                          value: correctAnswers[index],
                          onChanged: (newVal) {
                            if (newVal != null) {
                              correctAnswers[index] = newVal;
                              setState(() {});
                            }
                          }),
                      trailing: IconButton(
                          onPressed: () {
                            String removedItem = answers[index];
                            answers.removeAt(index);
                            correctAnswers.removeAt(index);
                            animatedListKey.currentState!.removeItem(
                                index,
                                (context, animation) => ScaleTransition(
                                      scale: animation,
                                      child: Card(
                                        child: ListTile(
                                          title: Text(
                                              removedItem), // Display the removed item
                                        ),
                                      ),
                                    ),
                                duration: Duration(milliseconds: 300));
                          },
                          icon: Icon(Icons.delete)),
                    ),
                  ))),
        ),
        IconButton.filled(
            iconSize: 40,
            onPressed: () {
              answers.add('a');
              correctAnswers.add(false);
              animatedListKey.currentState!.insertItem(answers.length - 1);
            },
            icon: Icon(Icons.add))
      ],
    );
  }
}
