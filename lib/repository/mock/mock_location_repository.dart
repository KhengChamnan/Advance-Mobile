import 'package:week_3_blabla_project/dummy_data/dummy_data.dart';
import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/repository/location_repository.dart';

class MockLocationRepository  extends LocationRepository{
  final List<Location> _locations =fakeLocations;
    @override
    List<Location> getLocations() {
      print("MockLocationRepository: Returning ${_locations.length} locations"); // ✅ Print to check
    return _locations;
       
    }
}