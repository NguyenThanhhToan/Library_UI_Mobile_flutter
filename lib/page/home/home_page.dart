import 'package:flutter/material.dart';
import 'dart:async'; // Add library to use Timer
import 'orders_page.dart';
import '/layouts/custom_header.dart';
import '/layouts/custom_footer.dart';
import '/widgets/colors.dart';
import '/widgets/home_card.dart'; // Make sure CustomCard is imported here
import 'intro_page.dart';
import 'reservation_page.dart';
import 'request_renewal_page.dart';
import 'notification_page.dart';
import 'package:google_fonts/google_fonts.dart'; // Add Google Fonts package

class HomePage extends StatefulWidget {
  final String token;
  final int currentIndex;

  HomePage({required this.token, this.currentIndex = 2});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // Automatically switch pages every 3 seconds
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.homeBackground, // Use gradient from colors.dart
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomHeader(title: "Library App"), // Title kept with default font
        body: Padding(
          padding: EdgeInsets.zero, // Remove space between header and banner
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 70.0), // Space between top and text
                child: Center(
                  child: Text(
                    'Welcome!!!', // Content text in English
                    style: GoogleFonts.roboto(
                      fontSize: 43, // Text size
                      fontWeight: FontWeight.bold, // Bold text
                      color: Colors.black, // Text color
                    ),
                    textAlign: TextAlign.center, // Center text
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              // Advertisement Banner - PageView
              SizedBox(
                height: 200.0, // Height of the banner
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 3, // Number of banners
                  onPageChanged: (int index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: Alignment.center, // Center the banner
                      child: Container(
                        width: 300.0, // Width of the banner smaller than the screen width
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage('assets/images/banner${index + 1}.jpg'),
                            fit: BoxFit.cover, // Ensure the image covers the entire container
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 27.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 9.0,
                      mainAxisSpacing: 15.0,
                      childAspectRatio: 1,
                    ),
                    itemCount: 5, // Total number of items (each CustomCard is an item)
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return CustomCard(
                            imagePath: 'assets/images/booklending.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrdersPage(),
                                ),
                              );
                            },
                          );

                        case 1:
                          return CustomCard(
                            imagePath: 'assets/images/reservation.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ReservationPage(token: widget.token),
                                ),
                              );
                            },
                          );
                        case 2:
                          return CustomCard(
                            imagePath: 'assets/images/renewal.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RequestRenewalPage(token: widget.token),
                                ),
                              );
                            },
                          );
                        case 3:
                          return CustomCard(
                            imagePath: 'assets/images/notification.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotificationPage(),
                                ),
                              );
                            },
                          );
                        case 4:
                          return CustomCard(
                            imagePath: 'assets/images/introduction.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      IntroPage(token: widget.token),
                                ),
                              );
                            },
                          );
                        default:
                          return SizedBox.shrink(); // If no matching case
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: CustomFooter(currentIndex: widget.currentIndex),
      ),
    );
  }
}
