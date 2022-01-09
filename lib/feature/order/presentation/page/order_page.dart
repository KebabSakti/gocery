import 'package:flutter/material.dart';
import 'package:gocery/feature/app/presentation/widget/app_bottom_navigation_bar.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Order'),
      ),
      bottomNavigationBar: AppBottomNavigationBar(active: 1),
    );
  }
}
