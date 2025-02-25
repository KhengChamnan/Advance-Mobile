import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:week_3_blabla_project/dummy_data/dummy_data.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';

class RidesScreen extends StatefulWidget {
  final RidePref ridePref;

  const RidesScreen({Key? key, required this.ridePref}) : super(key: key);

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Optionally, remove the AppBar if you only need the search UI
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            // Search TextField
            Padding(
              padding: const EdgeInsets.all(BlaSpacings.m),
              child: SearchBar(searchController: _searchController),
            ),
            // Test Card takes full width inside the provided horizontal padding
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m),
              child: testCard(ridePref: widget.ridePref),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search rides...',
        hintStyle: BlaTextStyles.body.copyWith(
          color: BlaColors.iconLight,
        ),
        prefixIcon: IconButton(
          icon: Icon(Icons.arrow_back, color: BlaColors.iconLight),
          onPressed: () => Navigator.of(context).pop(),
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.close, color: BlaColors.iconLight),
          onPressed: () {
            _searchController.clear();
            // Optionally, add code here to reset filtered results
          },
        ),
        filled: true,
        fillColor: BlaColors.backgroundAccent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(BlaSpacings.radius),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: BlaSpacings.s,
        ),
      ),
      onChanged: (query) {
        // Add search filtering logic if needed.
      },
    );
  }
}

class testCard extends StatelessWidget {
  const testCard({
    super.key,
    required this.ridePref,
  });

  final RidePref ridePref;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Make container take full width
      decoration: BoxDecoration(
        color: Colors.purple.shade50, // Light purple background
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Center contents horizontally
        children: [
          Text(
            "Departure: ${ridePref.departure?.name ?? 'Nice'}",
            
            textAlign: TextAlign.center,
          ),
          Text(
            "Arrival: ${ridePref.arrival?.name ?? 'Cambridge'}",
            
            textAlign: TextAlign.center,
          ),
          Text(
            "Date: ${DateTimeUtils.formatDateTime(ridePref.departureDate)}",
           
            textAlign: TextAlign.center,
          ),
          Text(
            "Requested Seats: ${ridePref.requestedSeats.toString()}",
          ),
        ],
      ),
    );
  }
}