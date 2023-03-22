import 'package:flutter/material.dart';
import 'package:bmi_calculator/models/result.dart';
import 'package:bmi_calculator/data/database_helper.dart';

class ResultsScreen extends StatefulWidget {
  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  // define a ValueNotifier to hold the list of results
  ValueNotifier<List<Result>> _results = ValueNotifier([]);

  // load the results from the database when the widget is initialized
  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  // function to load results from the database asynchronously
  Future<void> _loadResults() async {
    List<Result> loadedResults = await DatabaseHelper.instance.getResults();
    // update the ValueNotifier with the loaded results
    _results.value = loadedResults;
  }

  //results screen widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      // use AnimatedBuilder to rebuild the ListView when the ValueNotifier changes
      body: AnimatedBuilder(
        animation: _results,
        builder: (context, child) {
          return ListView.builder(
            itemCount: _results.value.length,
            itemBuilder: (BuildContext context, int index) {
              Result result = _results.value[index];
              return ListTile(
                //leading: Text(result.id.toString()), // display the result id
                title: Text('BMI: ${result.bmi.toStringAsFixed(2)} (${result.status})'), //display bmi value of result
                subtitle: Text('Weight: ${result.weight} | Height: ${result.height}'), // display the status of the result
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  // delete the result when the button is pressed
                  onPressed: () async {
                    int deletedRows =
                    await DatabaseHelper.instance.deleteResult(result.id!);
                    if (deletedRows > 0) {
                      // refresh the results list
                      _results.value = _results.value..removeAt(index);
                      // Show a snackbar to indicate success
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Result ${result.id} deleted!')),
                      );
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}



