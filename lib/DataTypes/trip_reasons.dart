enum TripReason {
  toFromWork,
  personal,
  buisness,
}

const Map<TripReason, String> reasonToText = {
  TripReason.toFromWork: 'To/From Work',
  TripReason.buisness: 'Buisness',
  TripReason.personal: 'Personal',
};

const Map<String, TripReason> textToReason = {
  'To/From Work' : TripReason.toFromWork,
  'Buisness' : TripReason.buisness,
  'Personal' : TripReason.personal,
};