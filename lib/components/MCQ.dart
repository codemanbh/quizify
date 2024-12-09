import 'package:flutter/material.dart';

class MCQ extends StatefulWidget {
  final ValueNotifier<List<String>> possibleMcqAnswers;
  final ValueNotifier<String> teacherCorrectAnswerController;
  final Function(List<String>, String)
      onChange; // Notify with updated answers and the correct answer.

  const MCQ({
    super.key,
    required this.possibleMcqAnswers,
    required this.teacherCorrectAnswerController,
    required this.onChange,
  });

  @override
  State<MCQ> createState() => _MCQState();
}

class _MCQState extends State<MCQ> {
  GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    controllers = widget.possibleMcqAnswers.value
        .map((answer) => TextEditingController(text: answer))
        .toList();

    // Listen for changes to the answers and update controllers accordingly
    widget.possibleMcqAnswers.addListener(_updateControllers);
  }

  @override
  void dispose() {
    // Dispose all controllers when the widget is removed
    for (var controller in controllers) {
      controller.dispose();
    }
    widget.possibleMcqAnswers
        .removeListener(_updateControllers); // Remove listener
    super.dispose();
  }

  void _updateControllers() {
    final newAnswers = widget.possibleMcqAnswers.value;
    if (newAnswers.length != controllers.length) {
      // If the number of answers has changed, rebuild the controllers
      setState(() {
        // Ensure controllers list matches the length of possibleMcqAnswers list
        controllers = List.generate(
          newAnswers.length,
          (index) => TextEditingController(text: newAnswers[index]),
        );
      });
    } else {
      // Only update the text in controllers if the answers list size hasn't changed
      for (int i = 0; i < newAnswers.length; i++) {
        if (controllers[i].text != newAnswers[i]) {
          controllers[i].text = newAnswers[i];
        }
      }
    }
  }

  void _setCorrectAnswer(String answer) {
    widget.teacherCorrectAnswerController.value = answer;
    widget.onChange(widget.possibleMcqAnswers.value,
        answer); // Notify parent with both updated answers and the correct answer
  }

  void _notifyChange() {
    widget.onChange(
        widget.possibleMcqAnswers.value,
        widget.teacherCorrectAnswerController
            .value); // Pass answers and correct answer to parent
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: ValueListenableBuilder<List<String>>(
            valueListenable: widget.possibleMcqAnswers,
            builder: (context, answers, _) {
              return AnimatedList(
                key: animatedListKey,
                initialItemCount: answers.length,
                itemBuilder: (context, index, animation) => ScaleTransition(
                  scale: animation,
                  child: Card(
                    child: ListTile(
                      title: TextField(
                        decoration:
                            InputDecoration(labelText: 'Answer ${index + 1}'),
                        controller: controllers[index],
                        textDirection: TextDirection.ltr,
                        onChanged: (newValue) {
                          answers[index] = newValue;
                          widget.possibleMcqAnswers.value = List.from(answers);
                          _notifyChange(); // Notify parent about the changes in answers
                        },
                      ),
                      leading: Radio<String>(
                        value: answers[index],
                        groupValue: widget.teacherCorrectAnswerController.value,
                        onChanged: (newVal) {
                          if (newVal != null) {
                            _setCorrectAnswer(
                                newVal); // Set correct answer and notify parent
                          }
                        },
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          String removedItem = answers[index];
                          answers.removeAt(index);
                          widget.possibleMcqAnswers.value = List.from(
                              answers); // Update list with the new items

                          if (widget.teacherCorrectAnswerController.value ==
                              removedItem) {
                            widget.teacherCorrectAnswerController.value = '';
                          }

                          _notifyChange(); // Notify parent after removal
                          animatedListKey.currentState!.removeItem(
                            index,
                            (context, animation) => ScaleTransition(
                              scale: animation,
                              child: Card(
                                child: ListTile(
                                  title: Text(removedItem),
                                ),
                              ),
                            ),
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        IconButton.filled(
          iconSize: 40,
          onPressed: () {
            widget.possibleMcqAnswers.value.add('');
            controllers.add(TextEditingController(
                text: '')); // Add new controller for the new answer
            _notifyChange(); // Notify parent after adding a new answer
            animatedListKey.currentState!
                .insertItem(widget.possibleMcqAnswers.value.length - 1);
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
