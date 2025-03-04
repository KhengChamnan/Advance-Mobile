import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/rides_repository.dart';

import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {

  //private instance
  static RidesService? _instance;
  final RidesRepository repository;

  //private constructor
  RidesService._internal(this.repository);

  //initialize the service
  static void initialize(RidesRepository repository) {
    if (_instance == null) {
      _instance = RidesService._internal(repository);
    } else {
      throw Exception("RidesService is already initialized.");
    }
  }

  //singleton accessor
  static RidesService get instance {
    if (_instance == null) {
      throw Exception("RidesService is not initialized. Call initialize() first.");
    }
    return _instance!;
  }

  List<Ride> getRides(RidePreference preference, RideFilter? filter) {
    return repository.getRides(preference, filter);
  }
 
}

class RideFilter {
  final bool acceptPets;

  RideFilter({required this.acceptPets});
}