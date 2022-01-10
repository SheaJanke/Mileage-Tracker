import 'package:flutter/material.dart';
import 'package:mileage_tracker/DataTypes/trip.dart';

import '../styles.dart';

class EditTripPage extends StatefulWidget {
  final Trip? _trip;
  const EditTripPage({Key? key, Trip? trip})
      : _trip = trip,
        super(key: key);

  @override
  State<EditTripPage> createState() => _EditTripPageState();
}

class _EditTripPageState extends State<EditTripPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add/Edit Trip'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.play_arrow_rounded),
                  labelText: 'Start Address',
                ),
                style: Styles.normalStyle,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.stop_rounded),
                  labelText: 'Destination Address',
                ),
                style: Styles.normalStyle,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.calendar_today),
                  hintText: 'Enter your date of birth',
                  labelText: 'Date',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid date';
                  }
                  return null;
                },
              ),
              Container(
                  padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                  child: RaisedButton(
                    child: const Text('Submit'),
                    onPressed: () {
                      showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2015, 8),
                          lastDate: DateTime(2101));
                      // It returns true if the form is valid, otherwise returns false
                      if (_formKey.currentState!.validate()) {}
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
