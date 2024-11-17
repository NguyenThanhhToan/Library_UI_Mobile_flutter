import 'package:flutter/material.dart';
import '/layouts/custom_header.dart';
import '/layouts/custom_footer.dart';
import '/widgets/book_reservation_item.dart';
import '/models/reservation_model.dart';
import '/widgets/colors.dart';
import '/services/api_service.dart';

class ReservationPage extends StatefulWidget {
  final String token;
  final int currentIndex;

  ReservationPage({required this.token, this.currentIndex = 1});

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  late Future<List<Reservation>> _reservations;

  @override
  void initState() {
    super.initState();
    // Call API to fetch the reservation list
    _reservations = ApiService().fetchGetReservation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.homeBackground, // Use gradient from colors.dart
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Set Scaffold background to transparent
        appBar: CustomHeader(title: "Reservation Requests"), // Change title to "Reservation Requests"
        body: FutureBuilder<List<Reservation>>(
          future: _reservations,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('An error occurred: ${snapshot.error}')); // Change error message
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No reservation data found.')); // Change message
            } else {
              final reservations = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListView.builder(
                  itemCount: reservations.length,
                  itemBuilder: (context, index) {
                    return ReservationItem(reservation: reservations[index]);
                  },
                ),
              );
            }
          },
        ),
        bottomNavigationBar: CustomFooter(currentIndex: 1),
      ),
    );
  }
}
