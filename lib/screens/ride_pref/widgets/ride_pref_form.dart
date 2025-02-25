import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/screens/ride_pref/widgets/ride_pref_form_search.dart';
import 'package:week_3_blabla_project/screens/ride_pref/widgets/ride_pref_form_seat.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/animations_util.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';
import 'package:week_3_blabla_project/widgets/actions/bla_button.dart';
import 'package:week_3_blabla_project/widgets/display/bla_divider.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

/// A Ride Preference Form allows selecting:
///   - A departure location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// An optional existing RidePref can be provided for editing.
class RidePrefForm extends StatefulWidget {
  final RidePref? initRidePref;
  final ValueChanged<RidePref> onDone;
  const RidePrefForm({super.key, this.initRidePref, required this.onDone});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;
  bool isFormValid = false;

  //initialize the state
  @override
  void initState() {
    super.initState();
    // Initialize from existing RidePref if provided
    departure = widget.initRidePref?.departure;
    arrival = widget.initRidePref?.arrival;
    departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
    requestedSeats = widget.initRidePref?.requestedSeats ?? 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  //handle valid suubmit search button
  void validateForm() {
    setState(() {
      isFormValid = departure != null && arrival != null;
    });
  }

  //handle swap locations with icons
  void _switchLocations() {
    if (departure != null && arrival != null) {
      setState(() {
        final tempLocation = departure;
        departure = arrival;
        arrival = tempLocation;
        validateForm();
      });
      print("Switching locations");
    }
  }


  //pickingdate for choose date field
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != departureDate) {
      setState(() {
        departureDate = pickedDate;
      });
    }
  }

  void _handleSubmitForm() {
    if (isFormValid) {
      final ridePref = RidePref(
        departure: departure!,
        arrival: arrival!,
        departureDate: departureDate,
        requestedSeats: requestedSeats.toInt(),
      );
      widget.onDone(ridePref);
    }
  }

  /// Opens the LocationSearchScreen with a bottom-to-top slide animation.
  /// Once a location is picked, the provided callback (onLocationSelected) is invoked.
  void _openLocationPickerDialog(
    BuildContext context, {
    required Function(Location) onLocationSelected,
  }) {
    Navigator.of(context).push(
      AnimationUtils.createBottomToTopRoute(
        LocationSearchScreen(
          title: "Select Location",
          onLocationSelected: (location) {
            onLocationSelected(location);
          },
        ),
      ),
    );
  }
  
  //handle seat change
  void _handleSeatsChanged(int newSeats) {
    setState(() {
      requestedSeats = newSeats;
    });
  }
// ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            // Reduce bottom padding to bring the BlaButton closer
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildLocationRow(
                  label: departure?.name ?? 'Leaving From',
                  icon: Icons.radio_button_unchecked,
                  endIcon: Icons.swap_vert,
                  onTap: () {
                    _openLocationPickerDialog(
                      context,
                      onLocationSelected: (location) {
                        setState(() {
                          departure = location;
                          validateForm();
                        });
                      },
                    );
                  },
                  onEndIconTap: _switchLocations,
                ),
                const BlaDivider(),
                _buildLocationRow(
                  label: arrival?.name ?? 'Going to',
                  icon: Icons.radio_button_unchecked,
                  onTap: () {
                    _openLocationPickerDialog(
                      context,
                      onLocationSelected: (location) {
                        setState(() {
                          arrival = location;
                          validateForm();
                        });
                      },
                    );
                  },
                ),
                const BlaDivider(),
                _buildDateRow(
                  date: departureDate,
                  onTap: () => _pickDate(context),
                ),
                const BlaDivider(),
                _buildSeatsRow(
                  seats: requestedSeats,
                  onTap: () {
                    // Implement your seat selection logic here
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: BlaButton(
              text: 'Search',
              onPress: _handleSubmitForm,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(BlaSpacings.radius),
                  bottomRight: Radius.circular(BlaSpacings.radius),
                ),
              ),
              buttonType: ButtonType.primary,
            ),
          )
        ],
      ),
    );
  }

  /// Builds a row showing location information or a placeholder label.
  /// Tapping the row triggers onTap, while tapping the optional endIcon triggers onEndIconTap.
  Widget _buildLocationRow({
    required String label,
    required IconData icon,
    IconData? endIcon,
    void Function()? onTap,
    void Function()? onEndIconTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, color: BlaColors.iconNormal),
            const SizedBox(width: 16),
            Text(
              label,
              style: BlaTextStyles.label.copyWith(
                color: BlaColors.textNormal,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            if (endIcon != null)
              InkWell(
                onTap: onEndIconTap,
                child: Icon(endIcon, color: BlaColors.primary),
              ),
          ],
        ),
      ),
    );
  }

  /// Builds a row for selecting a date.
  Widget _buildDateRow({required DateTime date, void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(Icons.calendar_month_rounded, color: BlaColors.iconLight),
            const SizedBox(width: 16),
            Text(
              DateTimeUtils.formatDateTime(date),
              style: BlaTextStyles.label.copyWith(
                color: BlaColors.textNormal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a row for selecting the number of seats.
  Widget _buildSeatsRow({required int seats, void Function()? onTap}) {
    return InkWell(
      onTap: () async {
        final result = await Navigator.of(context).push<int>(
          AnimationUtils.createBottomToTopRoute(
            SeatBookingScreen(initialSeats: requestedSeats),
          ),
        );
        if (result != null) {
          _handleSeatsChanged(result);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(Icons.person_outline, color: BlaColors.iconLight),
            const SizedBox(width: 16),
            Text(
              '$requestedSeats',
              style: BlaTextStyles.label.copyWith(
                color: BlaColors.textNormal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  
}
