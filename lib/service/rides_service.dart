import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';

import '../dummy_data/dummy_data.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {

  static List<Ride> availableRides = fakeRides;   // TODO for now fake data


  ///
  ///  Return the relevant rides, given the passenger preferences
  ///
  static List<Ride> getRidesFor(RidePref preferences) {
    //  print(availableRides);
    
    // For now, just a test
    return availableRides.where( (ride) => ride.departureLocation == preferences.departure && ride.arrivalLocation == preferences.arrival).toList();
  }
 
}

void main(){
  DateTime now = DateTime.now(); 
  DateTime today=DateTime(now.year, now.month, now.day);    
  
  List<Ride> todayRides=RidesService.availableRides.where((ride){
    DateTime rideDate=DateTime(ride.departureDate.year, ride.departureDate.month, ride.departureDate.day);
    return rideDate==today;
  }).toList();

  print("Available rides today: ${todayRides.length}");
  for(var ride in todayRides){
    print(ride.toString2());
  }
}

