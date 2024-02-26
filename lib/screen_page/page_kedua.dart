import 'package:flutter/material.dart';

class PageKedua extends StatelessWidget {
  const PageKedua({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Page Kedua',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),

      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.person, size: 45,color: Colors.purple,),
            Icon(Icons.account_balance_outlined, size: 45,color: Colors.purple,),
            Icon(Icons.add_business_sharp, size: 45,color: Colors.purple,),
          ],
        ),
      ),
    );
  }
}
