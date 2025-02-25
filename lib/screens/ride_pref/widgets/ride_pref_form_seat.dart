import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/widgets/actions/bla_button.dart' show BlaButton, ButtonType;

class SeatBookingScreen extends StatefulWidget {
  final int initialSeats;

  const SeatBookingScreen({Key? key, required this.initialSeats})
      : super(key: key);

  @override
  _SeatBookingScreenState createState() => _SeatBookingScreenState();
}

class _SeatBookingScreenState extends State<SeatBookingScreen> {
  late int _numberOfSeats;
  static const int _minSeats = 1;
  static const int _maxSeats = 8;

  @override
  void initState() {
    super.initState();
    _numberOfSeats = widget.initialSeats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlaColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Close button (top left)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.close, color: BlaColors.primary),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Number of seats to book",
                style: BlaTextStyles.heading.copyWith(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                  color: BlaColors.iconNormal,
                ),
              ),
            ),
            const SizedBox(height: 200),
            // Seat selection row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Minus button (disabled when _numberOfSeats == _minSeats)
                  Container(
                    decoration: ShapeDecoration(
                      shape: CircleBorder(
                        side: BorderSide(
                          color: _numberOfSeats > _minSeats ? BlaColors.primary : BlaColors.disabled,
                        ),
                      ),
                      color: Colors.transparent,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: _numberOfSeats > _minSeats
                          ? () {
                              setState(() {
                                _numberOfSeats--;
                              });
                            }
                          : null,
                      color: BlaColors.primary,
                      disabledColor: BlaColors.disabled,
                    ),
                  ),
                  // Display selected seat count
                  Text(
                    '$_numberOfSeats',
                    style: BlaTextStyles.heading.copyWith(
                      fontSize: 48.0,
                      fontWeight: FontWeight.w400,
                      color: BlaColors.neutralDark,
                    ),
                  ),
                  // Plus button (disabled when _numberOfSeats == _maxSeats)
                  Container(
                    decoration: ShapeDecoration(
                      shape: CircleBorder(
                        side: BorderSide(
                          color: _numberOfSeats < _maxSeats ? BlaColors.primary : BlaColors.disabled,
                        ),
                      ),
                      color: Colors.transparent,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: _numberOfSeats < _maxSeats
                          ? () {
                              setState(() {
                                _numberOfSeats++;
                              });
                            }
                          : null,
                      color: BlaColors.primary,
                      disabledColor: BlaColors.disabled,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Confirm button: returns the new seat number using BlaButton
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SizedBox(
                  child: BlaButton(
                    text: "Confirm",
                    onPress: () {
                      Navigator.pop(context, _numberOfSeats);
                    },
                    buttonType: ButtonType.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}