import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';
import 'package:week_3_blabla_project/widgets/actions/bla_button.dart';
import 'package:week_3_blabla_project/widgets/display/bla_divider.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;
  bool isFormValid = false;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------
  @override
  void initState() {
    super.initState();
    departure = widget.initRidePref?.departure;
    arrival = widget.initRidePref?.arrival;
    departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
    requestedSeats = widget.initRidePref?.requestedSeats ?? 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void validateForm() {
    setState(() {
      isFormValid = departure != null && arrival != null;
    });
  }

  void _switchLocations() {
    setState(() {
      final tempLocation = departure;
      departure = arrival;
      arrival = tempLocation;
      validateForm(); // Call this after swapping to update form validity
    });
    print("Switching locations");
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
                  onTap: () {
                    // Implement your location selection logic here
                    print('Leaving From');
                  },
                ),
                const BlaDivider(),
                _buildLocationRow(
                    label: arrival?.name ?? 'Going to',
                    icon: Icons.radio_button_unchecked,
                    endIcon: Icons.swap_vert,
                    onTap: () {
                      // Implement your location selection logic here
                      print('Going to');
                    },
                    onEndIconTap: _switchLocations),
                const BlaDivider(),
                _buildDateRow(
                    date: departureDate,
                    onTap: () async {
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
                    }),
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
              onPress: () {
                // Implement your search logic here
              },
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

                fontWeight: FontWeight.bold, // <-- make it bold
              ),
            ),
            const Spacer(),
            if (endIcon != null)
              InkWell(
                onTap: onEndIconTap,
                child: Icon(endIcon, color: BlaColors.iconNormal),
              ),
          ],
        ),
      ),
    );
  }

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
                fontWeight: FontWeight.bold, // <-- make it bold
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeatsRow({required int seats, void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(Icons.person_outline, color: BlaColors.iconLight),
            const SizedBox(width: 16),
            Text(
              '$seats',
              style: BlaTextStyles.label.copyWith(
                color: BlaColors.textNormal,
                fontWeight: FontWeight.bold, // <-- make it bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}
