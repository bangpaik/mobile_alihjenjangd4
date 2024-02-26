import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageKetiga extends StatelessWidget {
  const PageKetiga({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Page ketiga',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 45,
                    color: Colors.purple,
                  ),
                  Text('Profile')
                ]),

            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_balance_outlined,
                    size: 45,
                    color: Colors.purple,
                  ),
                  Text('Balance')
                ]),

            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_business_sharp,
                    size: 45,
                    color: Colors.purple,
                  ),
                  Text('Business')
                ]),

          ],
        ),
      ),
    );
  }
}

class PageListView extends StatelessWidget {
  const PageListView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Page List View'),
      ),

      body: SizedBox(
        height: 200,
        child: ListView(
          scrollDirection: Axis.horizontal,//untuk scroll ke samping
          children: List.generate(150, (index) {
            return Card(
              child: Center(
                child: Text('Ini list ke $index'),
              ),
            );
          }),
        ),
      ),
    );
  }
}

