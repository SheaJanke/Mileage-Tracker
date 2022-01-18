enum TripReason {
  toFromWork,
  personal,
  buisness,
}

const Map<TripReason, String> reasonText = {
  TripReason.toFromWork: 'To/From Work',
  TripReason.buisness: 'Buisness',
  TripReason.personal: 'Personal',
};