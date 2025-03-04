import 'package:week_3_blabla_project/dummy_data/dummy_data.dart' as DummyData;
import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/rides_repository.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';

class MockRidesRepository extends RidesRepository {
  final List<Ride> _rides = [
    Ride(
      departureLocation: const Location(name: "Battambang", country: Country.cambodia),
      arrivalLocation: const Location(name: "SiemReap", country: Country.cambodia),
      departureDate: DateTime.now().copyWith(hour: 5, minute: 30), // Today at 5:30 AM
      arrivalDateTime: DateTime.now().copyWith(hour: 7, minute: 30), // 2 hours later
      driver: DummyData.fakeUsers[0], // Kannika
      availableSeats: 2,
      pricePerSeat: 15.0,
      acceptPets: false
    ),
    Ride(
      departureLocation: const Location(name: "Battambang", country: Country.cambodia),
      arrivalLocation: const Location(name: "SiemReap", country: Country.cambodia),
      departureDate: DateTime.now().copyWith(hour: 20, minute: 0), // Today at 8 PM
      arrivalDateTime: DateTime.now().copyWith(hour: 22, minute: 0), // 2 hours later
      driver: DummyData.fakeUsers[1], // Chaylim
      availableSeats: 0,
      pricePerSeat: 12.0,
      acceptPets: false
    ),
    Ride(
      departureLocation: const Location(name: "Battambang", country: Country.cambodia),
      arrivalLocation: const Location(name: "SiemReap", country: Country.cambodia),
      departureDate: DateTime.now().copyWith(hour: 5, minute: 0), // Today at 5 AM
      arrivalDateTime: DateTime.now().copyWith(hour: 8, minute: 0), // 3 hours later
      driver: DummyData.fakeUsers[2], // Mengtech
      availableSeats: 1,
      pricePerSeat: 10.0,
      acceptPets: false
    ),
    Ride(
      departureLocation: const Location(name: "Battambang", country: Country.cambodia),
      arrivalLocation: const Location(name: "SiemReap", country: Country.cambodia),
      departureDate: DateTime.now().copyWith(hour: 20, minute: 0), // Today at 8 PM
      arrivalDateTime: DateTime.now().copyWith(hour: 22, minute: 0), // 2 hours later
      driver: DummyData.fakeUsers[3], // Limhao
      availableSeats: 2,
      pricePerSeat: 14.0,
      acceptPets: true
    ),
    Ride(
      departureLocation: const Location(name: "Battambang", country: Country.cambodia),
      arrivalLocation: const Location(name: "SiemReap", country: Country.cambodia),
      departureDate: DateTime.now().copyWith(hour: 5, minute: 0), // Today at 5 AM
      arrivalDateTime: DateTime.now().copyWith(hour: 8, minute: 0), // 3 hours later
      driver: DummyData.fakeUsers[4], // Sovanda
      availableSeats: 1,
      pricePerSeat: 13.5,
      acceptPets: false
    ),
  ];

  @override
  List<Ride> getRides(RidePreference preference, RideFilter? filter) {
    return _rides;
  }
}