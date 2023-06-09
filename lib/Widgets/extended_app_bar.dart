import 'package:flutter/material.dart';


class ExtendedAppBarEx extends StatefulWidget {
  const ExtendedAppBarEx({Key? key}) : super(key: key);

  @override
  State<ExtendedAppBarEx> createState() => _ExtendedAppBarExState();
}

class _ExtendedAppBarExState extends State<ExtendedAppBarEx> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.grey.shade200,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 2),
          child: Column(
            children: [
              // Padding(padding: EdgeInsets.all(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      'assets/images/cown.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Icon(
                    Icons.add,
                    size: 40,
                    color: Colors.yellow,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Albums',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Edit',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ))
                ],
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
