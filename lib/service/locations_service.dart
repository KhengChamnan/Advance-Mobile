import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/repository/location_repository.dart';


////
///   This service handles:
///   - The list of available rides
///
class LocationsService {
  //private instance
  static LocationsService? _instance;
  final LocationRepository repository;

  //private constructor
  LocationsService._internal(this.repository);

  //initialize the service
  static void initialize(LocationRepository repository) {
    if (_instance == null) {
      _instance = LocationsService._internal(repository);
    } else {
      throw Exception("LocationsService is already initialized.");
    }
  }

  //singleton accessor
  static LocationsService get instance {
    if (_instance == null) {
      throw Exception("LocationsService is not initialized. Call initialize() first.");
    }
    return _instance!;
  }

  List<Location> getLocations() {
    return repository.getLocations();
  }

}