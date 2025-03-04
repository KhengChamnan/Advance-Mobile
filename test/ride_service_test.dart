import 'package:week_3_blabla_project/dummy_data/dummy_data.dart' as DummyData;
import 'package:flutter_test/flutter_test.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/mock/mock_rides_repository.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';

void main() {
  RidesService.initialize(MockRidesRepository());

  RidePreference pref = RidePreference(
    departure: DummyData.fakeLocations[2],
    arrival: DummyData.fakeLocations[1],
    departureDate: DateTime.now(),
    requestedSeats: 1,
  );

  RideFilter filtter = RideFilter(acceptPets: true);

  test('Battambang to Siem Reap, today, 1 passenger', () {
    var results = RidesService.instance.getRides(pref, null);
    if (results.length== 4) {
      print("Ride:${results.length} found");
    }
    expect(results.length, 4);
  });

  test('Battambang to Siem Reap, today, 1 passenger, accept pets', () {
    var results = RidesService.instance.getRides(pref, filtter);

    expect(results.length, 1);
    expect(results[0].driver.firstName, 'Limhao');
    if (results.length == 1) {
      print("1 result display:(${results[0].driver.firstName})");
    }
  });
}
