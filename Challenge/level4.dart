class Distance {
  final double _meters;

  // Private constructor
  const Distance._(this._meters);

  // name constructors
  //use when input in different unit (cms, meters, kms) but finally return in meters

  Distance.fromCms(double cms) : _meters = cms / 100;

  Distance.fromMeters(double meters) : _meters = meters;

  Distance.fromKms(double kms) : _meters = kms * 1000 ;

  // Getter methods
  double get inCms => _meters * 100;
  double get inMeters => _meters;
  double get inKms => _meters / 1000;

  // Method to add two distances, returning a new Distance instance
  Distance add(Distance other) {
    return Distance._(_meters + other._meters);
  }

  @override
  String toString() {
    return 'Distance{_meters: $_meters}';
  }
}

void main() {

  //user input in different unit but its convert to meters

  var distance1 = Distance.fromCms(150); // 1.5 meters
  var distance2 = Distance.fromMeters(2); // 2 meters
  var distance3 = Distance.fromKms(0.005); // 5 meters
  var totalDistance = distance1.add(distance2).add(distance3);

  //convert back the totalDistance in meters to (cms, kms, meters)
  print('Total Distance: $totalDistance');
  print('In cms: ${totalDistance.inCms}');
  print('In meters: ${totalDistance.inMeters}');
  print('In kms: ${totalDistance.inKms}');
}
