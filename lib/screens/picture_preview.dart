import 'dart:io';

import 'package:flutter/material.dart';

class PreviewP extends StatefulWidget {
  String imgList='';
   PreviewP({Key? key, required this.imgList}) : super(key: key);

  @override
  State<PreviewP> createState() => _PreviewPState(imgList);
}

class _PreviewPState extends State<PreviewP> {
  _PreviewPState(this.imgList);
  String imgList;




  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.cyan,
        child:imgList != ""?Image.file(
          File(imgList,
          ),
          fit: BoxFit.fill,
        ):
            Text('No image  selected'),
    );
  }
}
