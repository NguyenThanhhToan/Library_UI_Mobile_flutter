import 'package:flutter/material.dart';
import '/layouts/custom_header.dart';
import '/layouts/custom_footer.dart';
import '/widgets/colors.dart';
import '/models/card_library_model.dart';
import '/services/api_service.dart';
import '/widgets/card_library_item.dart';

class CardLibraryPage extends StatefulWidget {
  final int currentIndex;

  const CardLibraryPage({Key? key, this.currentIndex = 5}) : super(key: key);

  @override
  _CardLibraryPageState createState() => _CardLibraryPageState();
}

class _CardLibraryPageState extends State<CardLibraryPage> {
  late Future<CardLibrary> _cardLibrary;

  @override
  void initState() {
    super.initState();
    _cardLibrary = ApiService().fetchCardLibrary();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.homeBackground,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomHeader(title: "Card Library"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: FutureBuilder<CardLibrary>(
            future: _cardLibrary,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text(
                    'No card available',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                );
              } else {
                final cardLibrary = snapshot.data!;
                return CardLibraryItem(
                  cardNumber: cardLibrary.cardNumber,
                  userName: cardLibrary.userName,
                  issuedDate: cardLibrary.issued,
                  expiredDate: cardLibrary.expired,
                );
              }
            },
          ),
        ),
        bottomNavigationBar: CustomFooter(currentIndex: widget.currentIndex),
      ),
    );
  }
}
