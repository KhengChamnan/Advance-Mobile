import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/dummy_data/dummy_data.dart';
import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/widgets/display/bla_divider.dart';

class LocationSearchScreen extends StatefulWidget {
  final String title;
  final Function(Location) onLocationSelected;

  const LocationSearchScreen({
    Key? key,
    required this.title,
    required this.onLocationSelected,
  }) : super(key: key);

  @override
  _LocationSearchScreenState createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Location> _filteredLocations = [];

  @override
  void initState() {
    super.initState();
    _filteredLocations = List.from(fakeLocations);
  }

  void _filterLocations(String query) {
    setState(() {
      if (query.isEmpty || query.length < 2) {
        _filteredLocations = List.from(fakeLocations);
      } else {
        final queryLower = query.toLowerCase();
        _filteredLocations = fakeLocations
            .where((loc) =>
                loc.name.toLowerCase().contains(queryLower) ||
                loc.country.toString().toLowerCase().contains(queryLower))
            .toList();
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,

      insetPadding: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(BlaSpacings.m),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
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
                      _filterLocations('');
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
                onChanged: _filterLocations,
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m),
                itemCount: _filteredLocations.length,
                separatorBuilder: (context, index) => const BlaDivider(),
                itemBuilder: (context, index) {
                  final location = _filteredLocations[index];
                  return _buildLocationListTile(location);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Listile for location
  Widget _buildLocationListTile(Location location) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: BlaSpacings.s,
        horizontal: BlaSpacings.s,
      ),
      leading: Icon(
        Icons.location_on_outlined,
        color: BlaColors.iconLight,
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: BlaColors.iconLight,
      ),
      title: Text(
        location.name,
        style: BlaTextStyles.body.copyWith(
          fontWeight: FontWeight.bold,
          color: BlaColors.textNormal,
        ),
      ),
      subtitle: Text(
        location.country.toString().split('.').last,
        style: BlaTextStyles.label.copyWith(
          color: BlaColors.textLight,
        ),
      ),
      onTap: () {
        widget.onLocationSelected(location);
        Navigator.of(context).pop();
      },
    );
  }
}

  