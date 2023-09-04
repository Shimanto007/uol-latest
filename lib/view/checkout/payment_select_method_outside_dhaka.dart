import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uol_new/route/routes.dart';
import 'package:uol_new/view/checkout/payment_sslcommerz.dart';
import 'package:uol_new/view/checkout/place_order.dart';
import 'package:uol_new/view/order/orders_screen.dart';


class SelectPaymentMethodOutside extends StatefulWidget {
  @override
  _SelectPaymentMethodState createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethodOutside> {
  String _paymentMethod = '';

  @override
  Widget build(BuildContext context) {
    void _showErrorDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Succesfull',
            style: TextStyle(
              color: Color(0xFF0098B8),
            ),
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Okay'),
            )
          ],
        ),
      );
    }
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
          'Select Payment Method',
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a payment method',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            // ListTile(
            //   title: Text('Cash On Delivary'),
            //   leading: Radio(
            //     activeColor: Color(0xFF0098B8),
            //     value: 'cash on delivery',
            //     groupValue: _paymentMethod,
            //     onChanged: (value) {
            //       setState(() {
            //         _paymentMethod = value!;
            //       });
            //     },
            //   ),
            // ),
            Text(
              "For outside Dhaka Only SSL Commerz payment available"
            ),
            SizedBox(height: 16.0),
            ListTile(
              title: Text('SSL Commerz'),
              leading: Radio(
                activeColor: Color(0xFF0098B8),
                value: 'ssl',
                groupValue: _paymentMethod,
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = '${value!}';
                  });
                },
              ),
            ),


            SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF0098B8)),
                ),
                onPressed: () async {
                  if(_paymentMethod == 'ssl') {
                    ordereds(_paymentMethod, context);
                    PageRouting.goToNextPage(
                      context: context,
                      navigateTo: SSLpayment(),
                    );
                  } if(_paymentMethod == 'cash on delivery') {
                    ordereds(_paymentMethod, context);
                    final prefs = await SharedPreferences.getInstance();
                    final message =  prefs.getString('order_message');
                    _showErrorDialog('$message');
                    // PageRouting.goToNextPage(
                    //   context: context,
                    //   navigateTo: OrdersScreen(),
                    // );
                  }
                },
                child: Text('Proceed to Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
