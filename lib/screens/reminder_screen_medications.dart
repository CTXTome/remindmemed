import 'package:flutter/material.dart';
//import 'package:flutter_application_1/blocs/medication/reminder_event.dart';



class MyMedicationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.of(context).pushNamed('/main');  
                  },
                  ),
                  ],
                  title: Text('My Medication'),
                  ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Card(
              child: ListTile(
                title: Text("Next Med: Xarelto"),
                subtitle: Text("@ 10:30 AM"),
              ),
            ),
             SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/add');
              },
              child: Text('Add Medication'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: null, 
              child: Text('Edit Medication'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: null, // 
              child: Text('Delete Medication'),
            ),
          ]
        ),)
    );
  }
}
