import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _startAddressController = TextEditingController();
  final _destinationAddressController = TextEditingController();
  final _dateController = TextEditingController();
  final _reasonController = TextEditingController();
  final _startOdometerController = TextEditingController();
  final _endOdometerController = TextEditingController();
  final _notesController = TextEditingController();

  bool fetchingCurrentAddress = false;

  late DateTime _dateValue;

  final reasonOptions =
      TripReason.values.map((e) => reasonText[e] ?? '').toList();

  @override
  void dispose() {
    _startAddressController.dispose();
    _destinationAddressController.dispose();
    _dateController.dispose();
    _reasonController.dispose();
    _startOdometerController.dispose();
    _endOdometerController.dispose();
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
                controller: _destinationAddressController,
                decoration: InputDecoration(
                  labelText: 'Destination Address',
                  labelStyle: Styles.boldStyle,
                  suffixIcon: fetchingCurrentAddress == true
                      ? Transform.scale(
                          scale: 0.5,
                          child: const CircularProgressIndicator(),
                        )
                      : IconButton(
                          icon: const Icon(Icons.location_on),
                          onPressed: () {
                            setState(
                              () {
                                fetchingCurrentAddress = true;
                              },
                            );
                            LocationManager.getCurrentAddress().then(
                              (currentAddress) {
                                _destinationAddressController.value =
                                    TextEditingValue(
                                  text: currentAddress,
                                  selection: TextSelection.fromPosition(
                                    TextPosition(offset: currentAddress.length),
                                  ),
                                );
                              },
                            ).whenComplete(
                              () {
                                setState(
                                  () {
                                    fetchingCurrentAddress = false;
                                  },
                                );
                              },
                            );
                          },
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.disabled,
                      readOnly: true,
                      controller: _dateController,
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
                                _dateController.text = date;
                                _dateValue = selectedDate;
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
                      validator: (value) {
                        if ((value as String?) == null) {
                          return 'Please enter trip reason';
                        }
                        return null;
                      },
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
                        _reasonController.text = newValue as String;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Reason',
                        labelStyle: Styles.boldStyle,
                        contentPadding: EdgeInsets.only(top: 10, bottom: 11),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.disabled,
                      controller: _startOdometerController,
                      style: Styles.normalStyle,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        labelStyle: Styles.boldStyle,
                        labelText: 'Start Km',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter start km';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.disabled,
                      controller: _endOdometerController,
                      style: Styles.normalStyle,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        labelStyle: Styles.boldStyle,
                        labelText: 'End Km',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter end km';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _notesController,
                autovalidateMode: AutovalidateMode.disabled,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  labelStyle: Styles.boldStyle,
                ),
                style: Styles.normalStyle,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: Styles.normalStyle,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
