import 'package:flutter/material.dart';
import '/layouts/custom_header.dart';
import '/layouts/custom_footer.dart';
import '/widgets/colors.dart';
import '/models/request_renewal_model.dart';
import '/widgets/request_renewal_item.dart';
import '/services/api_service.dart';

class RequestRenewalPage extends StatefulWidget {
  final String token;
  final int currentIndex;

  RequestRenewalPage({required this.token, this.currentIndex = 3});

  @override
  _RequestRenewalPageState createState() => _RequestRenewalPageState();
}

class _RequestRenewalPageState extends State<RequestRenewalPage> {
  late Future<List<RequestRenewal>> _requestRenewals;

  @override
  void initState() {
    super.initState();
    // Call API to fetch the list of renewal requests
    _requestRenewals = ApiService().fetchGetRequestRenewal();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.homeBackground, // Use gradient from colors.dart
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Set Scaffold background to transparent
        appBar: CustomHeader(title: "Renewal Requests"), // Change to "Renewal Requests"
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: FutureBuilder<List<RequestRenewal>>(
            future: _requestRenewals, // Use _requestRenewals from initState
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}')); // Update error message
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No renewal requests')); // Update message
              } else {
                final renewals = snapshot.data!;
                return ListView.builder(
                  itemCount: renewals.length,
                  itemBuilder: (context, index) {
                    return RequestRenewalItem(renewalRequest: renewals[index]);
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
