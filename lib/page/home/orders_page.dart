import 'package:flutter/material.dart';
import '/layouts/custom_header.dart';
import '/layouts/custom_footer.dart';
import '/widgets/colors.dart';
import '/widgets/book_lending_item.dart';
import '/models/book_lending_model.dart';
import '/services/api_service.dart';

class OrdersPage extends StatefulWidget {
  final int currentIndex;
  OrdersPage({this.currentIndex = 0});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late Future<List<BookLending>> _bookLendings;

  @override
  void initState() {
    super.initState();
    // Gọi API để lấy danh sách sách đang mượn mà không cần truyền token từ widget
    _bookLendings = ApiService().fetchBookLendings();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.homeBackground,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomHeader(title: 'Borrowing Books'),
        body: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: FutureBuilder<List<BookLending>>(
            future: _bookLendings,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Failed to load orders'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No orders found'));
              } else {
                final bookLendings = snapshot.data!;
                return ListView.builder(
                  itemCount: bookLendings.length,
                  itemBuilder: (context, index) {
                    final lending = bookLendings[index];
                    return BookLendingItem(lending: lending); // Hiển thị item BookLending
                  },
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
