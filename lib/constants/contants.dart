

import 'package:flutter/material.dart';

 const ktextStyleBold = TextStyle(
  fontSize: 20,
  color: Colors.black,
  fontWeight: FontWeight.bold
 );



const  itemmmm =  [
 BottomNavigationBarItem(
  icon: Icon(Icons.photo_album_outlined),
  label: 'Album',
 ),
 BottomNavigationBarItem(
  icon: Icon(
   Icons.contacts,
  ),
  label: 'Contacts',
 ),
 BottomNavigationBarItem(
  icon: Icon(Icons.lock),
  label: 'Passwords',
 ),
 BottomNavigationBarItem(
  icon: Icon(Icons.screen_search_desktop),
  label: 'Browser',
 ),
 BottomNavigationBarItem(
  icon: Icon(Icons.settings),
  label: 'Settings',
 ),
];

 
 const ktextStyleSmall=TextStyle(
  fontSize: 15,
  color: Colors.black,
  fontWeight: FontWeight.bold
 );
   AlertDialog alertDio=AlertDialog(
   shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
   ),
   contentPadding: EdgeInsets.all(16.0),
   content: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
     Text(
      'Choose an option:',
      style: TextStyle(
       fontWeight: FontWeight.bold,
       fontSize: 18.0,
      ),
     ),
     SizedBox(height: 16.0),
     ListTile(
      leading: Icon(Icons.photo_library),
      title: Text('Import image from gallery'),
      onTap: () {
       // Handle action for importing image from gallery
      // Navigator.pop(context); // Close the dialog
      },
     ),
     Divider(), // Divider between the first and second items
     ListTile(
      leading: Icon(Icons.camera_alt),
      title: Text('Camera'),
      onTap: () {
       // Handle action for using the camera
       //Navigator.pop(context); // Close the dialog
      },
     ),
     Divider(), // Divider between the second and third items
     ListTile(
      leading: Icon(Icons.album),
      title: Text('Album'),
      onTap: () {
       // Handle action for accessing the album
      // Navigator.pop(context); // Close the dialog
      },
     ),
    ],
   ),
  );

