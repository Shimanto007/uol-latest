import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uol_new/constant.dart';
import 'package:uol_new/controller/cart_controller.dart';
import 'package:uol_new/model/get_shipping_charges.dart';
import 'package:uol_new/route/routes.dart';
import 'package:uol_new/view/checkout/payment_method_select_inside_dhaka.dart';
import 'package:uol_new/view/checkout/payment_select_method_outside_dhaka.dart';


class ShippingDetailsScreen extends StatefulWidget {

  @override
  _ShippingDetailsScreenState createState() => _ShippingDetailsScreenState();
}

class _ShippingDetailsScreenState extends State<ShippingDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _customer_name;
  String? _customer_email;
  String? _customer_phone;
  String? _customer_address;
  String? _customer_city = 'Inside Dhaka';
  String? _customer_zip;
  String? _shipping_area = 'Adabor';
  int? customer_city;
  int _selectedShippingChargeId = 0;
  List<dynamic> _shippingCharges = [];

  int shippingCharge = 0;
  List<String> shipping_area = ["Shampur","Bagerhat","Bandarban","Barguna","Barisal","Bhairab","Bhola","Bogra","Brahmanbaria","Chandpur","Chapai Nawabganj","Chittagong"
    ,"Chuadanga","Comilla","Cox's Bazar","Dinajpur","Faridpur","Feni","Gaibandha","Gazipur","Gopalganj","Habiganj","Jamalpur","Jessore","Jhalokathi"
    ,"Jhenaidah","Joypurhat","keraniganj","Khagrachari","Khulna","Kishoreganj","Kurigram","Kushtia","Laksmipur","Lalmonirhat","Madaripur","Magura","Manikganj"
    ,"Meherpur","Moulvibazar","Munshiganj","Mymensingh","Naogaon","Narail","Narayanganj","Natore","Netrokona","Nilphamari","Noakhali","Norshingdi","Pabna"
    ,"Panchagarh","Patuakhali","Perojpur","Rajbari","Rajshahi","Rangamati","Rangpur","Satkhira","Shariatpur","Sherpur","Sirajganj","Sunamganj","Sylhet"
    ,"Tangail","Thakurgaon","Savar","Adabor","Aftabnagar","Agargaon","Ashkona","Azimpur","Badda","Bakshi Bazar","Balurghat","Banani","Banani DOHS","Banasree","Bangshal","Baridhara Diplomatic Zone","Baridhara DOSH"
    ,"Baridhara J Block","Bashabo","Basundhara","Beraid","Boro Moghbazar","Central Road","Chawkbazar","Dakshinkhan","Demra","Dhaka Cantonment","Dhanmondi","Dholpur","DIT Road"
    ,"Elephant Road","Eskaton Road","Faidabad","Faridabad","Gandaria","Gopibag","Goran","Green Road","Gulisthan","Gulshan 1","Gulshan 2","Hatirpool","Hazaribag"
    ,"Islampur","Jatrabari","Jigatola","Jurain","Kadamtoli","Kafrul","Kalabagan","Kallyanpur","Kamlapur","Kamranggirchar","Kathalbagan","Kawla","Kawranbazar"
    ,"Khilgaon","khilkhet","Kuril","Lakshimibazar","Lalbag","Malibag","Manda","Manikdi","Maniknogor","Matuail","Matuail","Mirpur","Mirpur DOHS","Mogbazar"
    ,"Mohakhali","Mohakhali DOHS","Mohammadpur","Monipur","Motijheel","Mugda","Nadda","Nakhalpara","Narinda","New Elephant Road","Newmarket","Niketan"
    ,"Nikunja 1","Nikunja 2","Nilkhet","Pallabi","Paltan","Panthapath","Pirerbag","Rampura","Rayerbag","Rupnagar","Sadarghat","Shabagh","Shahid nagar","Shahjadpur"
    ,"Shajahanpur","Shanir akhra","Shantinagar","Shegunbagicha","Shewrapara","Shiddeshwari","Shymoli","South Banasree","Sutrapur","Tejgaon","Turag","Uttarkhan"
    ,"Uttora","Wari"];
  List<String> outside_dhaka = ["Shampur","Bagerhat","Bandarban","Barguna","Barisal","Bhairab","Bhola","Bogra","Brahmanbaria","Chandpur","Chapai Nawabganj","Chittagong"
    ,"Chuadanga","Comilla","Cox's Bazar","Dinajpur","Faridpur","Feni","Gaibandha","Gazipur","Gopalganj","Habiganj","Jamalpur","Jessore","Jhalokathi"
    ,"Jhenaidah","Joypurhat","keraniganj","Khagrachari","Khulna","Kishoreganj","Kurigram","Kushtia","Laksmipur","Lalmonirhat","Madaripur","Magura","Manikganj"
    ,"Meherpur","Moulvibazar","Munshiganj","Mymensingh","Naogaon","Narail","Narayanganj","Natore","Netrokona","Nilphamari","Noakhali","Norshingdi","Pabna"
    ,"Panchagarh","Patuakhali","Perojpur","Rajbari","Rajshahi","Rangamati","Rangpur","Satkhira","Shariatpur","Sherpur","Sirajganj","Sunamganj","Sylhet"
    ,"Tangail","Thakurgaon","Savar"];
  List<String> inside_dhaka = ["Adabor","Aftabnagar","Agargaon","Ashkona","Azimpur","Badda","Bakshi Bazar","Balurghat","Banani","Banani DOHS","Banasree","Bangshal","Baridhara Diplomatic Zone","Baridhara DOSH"
    ,"Baridhara J Block","Bashabo","Basundhara","Beraid","Boro Moghbazar","Central Road","Chawkbazar","Dakshinkhan","Demra","Dhaka Cantonment","Dhanmondi","Dholpur","DIT Road"
    ,"Elephant Road","Eskaton Road","Faidabad","Faridabad","Gandaria","Gopibag","Goran","Green Road","Gulisthan","Gulshan 1","Gulshan 2","Hatirpool","Hazaribag"
    ,"Islampur","Jatrabari","Jigatola","Jurain","Kadamtoli","Kafrul","Kalabagan","Kallyanpur","Kamlapur","Kamranggirchar","Kathalbagan","Kawla","Kawranbazar"
    ,"Khilgaon","khilkhet","Kuril","Lakshimibazar","Lalbag","Malibag","Manda","Manikdi","Maniknogor","Matuail","Matuail","Mirpur","Mirpur DOHS","Mogbazar"
    ,"Mohakhali","Mohakhali DOHS","Mohammadpur","Monipur","Motijheel","Mugda","Nadda","Nakhalpara","Narinda","New Elephant Road","Newmarket","Niketan"
    ,"Nikunja 1","Nikunja 2","Nilkhet","Pallabi","Paltan","Panthapath","Pirerbag","Rampura","Rayerbag","Rupnagar","Sadarghat","Shabagh","Shahid nagar","Shahjadpur"
    ,"Shajahanpur","Shanir akhra","Shantinagar","Shegunbagicha","Shewrapara","Shiddeshwari","Shymoli","South Banasree","Sutrapur","Tejgaon","Turag","Uttarkhan"
    ,"Uttora","Wari"];

  @override
  void initState() {
    super.initState();
    GetShippingChargesApi();
  }

  Future<GetShippingCharges> GetShippingChargesApi() async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/get-shipping-charges'),
    );
    var data = jsonDecode(response.body);
    // print(data);
    if (response.statusCode == 200) {
      return GetShippingCharges.fromJson(data);
    } else {
      return GetShippingCharges.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    final final_amount = cartController.cartTotal + shippingCharge;
    // print(final_amount);
    final String doubleFinalAmount = final_amount.toStringAsFixed(2);
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
          'Shipping Details',
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
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFF0098B8),
                        ),
                        padding: EdgeInsets.all(10),

                        child: Text(
                          'Total Amount: ${doubleFinalAmount}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFF0098B8),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Shipping Charge: $shippingCharge',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _customer_name = value;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _customer_email = value;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Contact Number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Contact Number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _customer_phone = value;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _customer_address = value;
                  },
                ),
                SizedBox(height: 16),
                FutureBuilder<GetShippingCharges>(
                  future: GetShippingChargesApi(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final singularProduct = snapshot.data!;
                      return SizedBox(
                        width: double.infinity,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _customer_city,
                          icon: Icon(
                            Icons.arrow_downward,
                            color: Color(0xFF0098B8),
                          ),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Color(0xFF0098B8)),
                          underline: Container(
                            width: double.infinity,
                            height: 1,
                            color: Color(0xFF0098B8),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              _customer_city = newValue;
                              if(_customer_city == 'Inside Dhaka') {
                                setState(() {
                                  customer_city = 14;
                                  shipping_area = inside_dhaka;
                                  shippingCharge = singularProduct.shippingCharges[0].price;
                                });
                              } else {
                                setState(() {
                                  customer_city = 15;
                                  shipping_area = outside_dhaka;
                                  shippingCharge = singularProduct.shippingCharges[1].price;
                                });
                              }
                            });
                          },
                          items: <String>['Inside Dhaka', 'Outside Dhaka',]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          })
                              .toList(),
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Zip',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Zip code';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _customer_zip = value;
                  },
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _shipping_area,
                    icon: Icon(
                      Icons.arrow_downward,
                      color: Color(0xFF0098B8),
                    ),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Color(0xFF0098B8)),
                    underline: Container(
                      height: 1,
                      color: Color(0xFF0098B8),

                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _shipping_area = newValue;
                      });
                    },
                    items: shipping_area
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                        .toList(),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF0098B8)),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('customer_name', _customer_name!);
                        await prefs.setString('customer_email', _customer_email!);
                        await prefs.setString('customer_phone', _customer_phone!);
                        await prefs.setString('customer_address', _customer_address!);
                        await prefs.setString('customer_city', _customer_city!);
                        await prefs.setInt('customer_city_shipping', customer_city!);
                        await prefs.setString('customer_zip', _customer_zip!);
                        await prefs.setString('shipping_area', _shipping_area!);
                        await prefs.setString('shipping_cost', shippingCharge!.toString());
                        await prefs.setDouble('final_amount', final_amount);
                        final amountss = await prefs.getDouble('final_amount');
                        // print(amountss);
                        if (_customer_city == 'Inside Dhaka') {
                          PageRouting.goToNextPage(
                            context: context,
                            navigateTo: SelectPaymentMethod(),
                          );
                        }
                        if (_customer_city == 'Outside Dhaka') {
                          PageRouting.goToNextPage(
                            context: context,
                            navigateTo: SelectPaymentMethodOutside(),
                          );
                        }

                      }
                    },
                    child: Text('Proceed to payment'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
