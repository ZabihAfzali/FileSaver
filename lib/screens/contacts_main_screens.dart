import 'package:flutter/material.dart';

import '../constants/contants.dart';


class ContactsMainScreen extends StatefulWidget {
  const ContactsMainScreen({Key? key}) : super(key: key);

  @override
  State<ContactsMainScreen> createState() => _ContactsMainScreenState();
}

class _ContactsMainScreenState extends State<ContactsMainScreen> {

  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
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
                  SizedBox(width: 180,),
                  InkWell(
                    onTap: () {

                    },
                    child: Icon(
                      Icons.search,
                      size: 40,
                      color: Colors.yellow,
                    ),
                  ),
            InkWell(
              onTap: () {
                _showMyDialog();
              },
              child: Icon(
                Icons.add,
                size: 40,
                color: Colors.yellow,
              ),
            ),
            ],
          ),

              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Contacts',
                      style: ktextStyleBold,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                          'Select',
                          style: ktextStyleSmall
                      ))
                ],
              ),
  ]
        )
        ),
    ),
      bottomNavigationBar: BottomNavigationBar(

        items: itemmmm,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.yellow,
        onTap: _onItemTapped,
        backgroundColor: Colors.grey.shade200,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),

      )
    );
  }

  void bottomNavigatorItems(){
    _selectedIndex = 0;
    const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    const List<Widget> _widgetOptions = <Widget>[
      Text(
        'Index 0: Albums',
        style: optionStyle,
      ),
      Text(
        'Index 1: Contacts',
        style: optionStyle,
      ),
      Text(
        'Index 2: Passwords',
        style: optionStyle,
      ),
      Text(
        'Index 3: Browser',
        style: optionStyle,
      ),
      Text(
        'Index 4: Settings',
        style: optionStyle,
      ),

    ];

  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.topRight,
          shadowColor: Colors.transparent,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: 150,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.import_contacts),
                  title: Text('Import from Contacts'),
                  onTap: () {
                                       // openImageFromGallery();
                    Navigator.pop(context);
                  },
                ),
                Divider(), // Divider between the first and second items
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Create New Contacts'),
                  onTap: () {
                    //selectImages();

                    Navigator.pop(context); // Close the dialog
                  },
                ),
                Divider(), // Divider between the second and third items
              ],
            ),
          ),
        );
      },
    );
  }
}
