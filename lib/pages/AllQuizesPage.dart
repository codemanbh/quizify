import 'package:flutter/material.dart';
import '../components/CustomNavBar.dart';

class AllQuizesPage extends StatefulWidget {
  const AllQuizesPage({super.key});

  @override
  State<AllQuizesPage> createState() => _AllQuizesPageState();
}

class _AllQuizesPageState extends State<AllQuizesPage> {
  List allQuizesMetaData = [
    {"title": "quiz1", "description": "hello"}
  ];
  void _showConformationAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Alert'),
              content: Text('you are about to enter an exam'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      Navigator.of(context)
                          .pushNamed('/takeQuizPage', arguments: {'qid': '1'});
                    },
                    child: Text('Enter exam'))
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All quizes'),
      ),
      // bottomNavigationBar: ,
      bottomNavigationBar: CustomNavBar(page_url: '/allQuizQuestionsPage'),
      body: Container(
        margin: EdgeInsets.all(5),
        child: ListView.builder(
            itemCount: allQuizesMetaData.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  subtitle: Text(allQuizesMetaData[index]['description']),
                  title: Text(allQuizesMetaData[index]['title']),
                  trailing: SizedBox(
                    width: 90,
                    child: Row(
                      children: [
                        TextButton(
                            onPressed: () =>
                                _showConformationAlertDialog(context),
                            child: Text('Take Quiz'))
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
