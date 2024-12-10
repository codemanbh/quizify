import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizify/models/Quiz.dart';
import 'package:quizify/pages/StudentResults.dart';

class StudentAttemptsSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Placeholder();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print(query);
    List<Quiz> attempts = [];
    List<Quiz> attemptsFiltered = [];

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('attempts').snapshots(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong!'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data?.docs ?? [];

        // Parse data
        if (docs.isEmpty) {
          return Center(child: Text('No items found.'));
        }
        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (BuildContext context, int index) {
            // Check connection state
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return Center(child: CircularProgressIndicator());
            // }

            // Check for errors

            Quiz q = Quiz.quizFromMap(docs[index].data());
            if (q.title.contains(query)) {
              return ListTile(
                title: Text(q.title),
                trailing: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  StudentResults(attemptID: q.attemptID)));
                    },
                    icon: Icon(Icons.arrow_circle_right)),
              );
            } else {
              return SizedBox();
            }
          },
        );
      },
    );
  }
}
