import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShippingDelivery extends StatelessWidget {
  const ShippingDelivery({Key? key}) : super(key: key);

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
          'Shipping & Delivery',
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
                  'ক্যাশ অন ডেলিভারি ঢাকা এর বাইরে দেয়া হয় ?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0098B8),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'জি না , দুঃখিত এই মুহূর্তে আমরা শুধুমাত্র ঢাকা মেট্রোপলিটন এর ভিতর ক্যাশ অন ডেলিভারি করে থাকি।',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'কয়দিনের মধ্যে পণ্য হাতে পাবো?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0098B8),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'ঢাকার ভিতরে ২ -৩ কর্মদিবসের মধ্যে প্রোডাক্ট ডেলিভারি করা হয়।'
                      'ঢাকার বাহিরে ৪ - ৫ কর্মদিবসের মধ্যে প্রোডাক্ট ডেলিভারি করা হয়।'
                      'যেহেতু আমাদের নিজেদের কোন ডেলিভারি করার ব্যবস্থা নেই এবং আমরা ই-কুরিয়ার এর মাধ্যমে ডেলিভারি করিয়ে থাকি সে ক্ষেত্রে দূরত্ব এর উপর কিছু সময় বেশি লাগতে পারে । আসা করি বিষয়টি ক্ষমা সুন্ধর দৃষ্টিতে দেখবেন ।',
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
