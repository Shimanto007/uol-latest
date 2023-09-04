import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RefundReturn extends StatelessWidget {
  const RefundReturn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xFF0098B8),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.transparent,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark,
          // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        title: Text(
          'Return & Refund Policy',
          style: TextStyle(
            fontFamily: 'Lato',
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color(0xFF0098B8),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Return Policy',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0098B8),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'We will gladly accept the return of products that are defective due to defects in manufacturing and/or workmanship. Fulfilment mistakes that may be made which result in the shipment of incorrect products to you will also be accepted for return.'
                      'Before you take the delivery, make sure you have done the following check-in presence of the delivery personnel:'
                      'Match your ordered items with the Invoice'
                      'A quick review of the quality of the products (like expiry, usage direction, etc)'
                      'Physical damage.'
                      'In case of any of the above, immediately contact our Helpline number for a return/replacement.'
                      'An order cannot be canceled due to a change of mind. Products ordered are non-refundable.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
