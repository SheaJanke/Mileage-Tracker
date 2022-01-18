import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mileage_tracker/DataTypes/trip.dart';
import 'package:mileage_tracker/DataTypes/trip_reasons.dart';
import 'package:mileage_tracker/Utils/location_manager.dart';

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
  final dateController = TextEditingController();

  final reasonOptions = TripReason.values.map((e) => reasonText[e] ?? '').toList();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add/Edit Trip'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                autovalidateMode: AutovalidateMode.disabled,
                decoration: const InputDecoration(
                  labelText: 'Start Address',
                  labelStyle: Styles.boldStyle,
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
                autovalidateMode: AutovalidateMode.disabled,
                decoration: InputDecoration(
                  labelText: 'Destination Address',
                  labelStyle: Styles.boldStyle,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.location_on),
                    onPressed: () => LocationManager.getCurrentAddress(),
                  ),
                ),
                style: Styles.normalStyle,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.disabled,
                      readOnly: true,
                      controller: dateController,
                      style: Styles.normalStyle,
                      decoration: InputDecoration(
                        labelStyle: Styles.boldStyle,
                        suffixIcon: IconButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2030),
                            ).then((selectedDate) {
                              if (selectedDate != null) {
                                String date =
                                    DateFormat.MMMEd().format(selectedDate);
                                dateController.text = date;
                              }
                            });
                          },
                          icon: const Icon(Icons.calendar_today),
                        ),
                        labelText: 'Date',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter valid date';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      items: reasonOptions.map((String category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Row(
                            children: <Widget>[
                              Text(
                                category,
                                style: Styles.normalStyle,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with _category
                        setState(() => {});
                      },
                      decoration: const InputDecoration(
                        labelText: 'Reason',
                        labelStyle: Styles.boldStyle,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                  child: RaisedButton(
                    child: const Text('Submit'),
                    onPressed: () {
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
