import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mileage_tracker/DataTypes/trip.dart';
import 'package:mileage_tracker/DataTypes/trip_reasons.dart';
import 'package:mileage_tracker/Pages/trip_list_page.dart';
import 'package:mileage_tracker/Utils/location_manager.dart';

import '../styles.dart';

class EditTripPage extends StatefulWidget {
  final Trip? _trip;
  final UpdateTripFunction _updateTrip;
  const EditTripPage(
      {Key? key, Trip? trip, required UpdateTripFunction updateTrip})
      : _trip = trip,
        _updateTrip = updateTrip,
        super(key: key);

  @override
  State<EditTripPage> createState() => _EditTripPageState();
}

class _EditTripPageState extends State<EditTripPage> {
  Trip? _trip;
  final _formKey = GlobalKey<FormState>();
  final _startAddressController = TextEditingController();
  final _destinationAddressController = TextEditingController();
  final _dateController = TextEditingController();
  final _reasonController = TextEditingController();
  final _startOdometerController = TextEditingController();
  final _endOdometerController = TextEditingController();
  final _notesController = TextEditingController();
  bool _hasSaved = false;

  bool fetchingCurrentAddress = false;

  late DateTime _dateValue;

  final reasonOptions =
      TripReason.values.map((e) => reasonToText[e] ?? '').toList();

  @override
  void initState() {
    super.initState();
    setState(() {
      _trip = widget._trip;
    });
    if(_trip != null){
      _startAddressController.text = _trip!.startAddress;
      _destinationAddressController.text = _trip!.endAddress;
      _dateController.text = DateFormat.MMMEd().format(_trip!.date);
      _dateValue = _trip!.date;
      _reasonController.text = reasonToText[_trip!.reason] ?? '';
      _startOdometerController.text = _trip!.startKm.toString();
      _endOdometerController.text = _trip!.endKm.toString();
      _notesController.text = _trip!.notes;
    }
  }

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

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Unsaved Changes', style: Styles.boldStyle),
            content:
                const Text('Are you sure you want to discard your changes?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel', style: Styles.normalStyle),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Discard',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                    )),
              ),
            ],
          ),
        )) ??
        false;
  }

  void _saveTrip() {
    Trip newTrip = Trip(
      _dateValue, 
      int.parse(_startOdometerController.text),
      int.parse(_endOdometerController.text),
      _startAddressController.text,
      _destinationAddressController.text,
      textToReason[_reasonController.text]!,
      _notesController.text
    );
    widget._updateTrip(newTrip);
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add/Edit Trip'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _startAddressController,
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
                                        TextPosition(
                                            offset: currentAddress.length),
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
                          value: _reasonController.text,
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
                            contentPadding:
                                EdgeInsets.only(top: 10, bottom: 11),
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
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveTrip();
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 72),
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
      ),
    );
  }
}
