import 'package:filesaver/constants/contants.dart';
import 'package:flutter/material.dart';

class AppCustomizationPage extends StatefulWidget {
  @override
  _AppCustomizationPageState createState() => _AppCustomizationPageState();
}

class _AppCustomizationPageState extends State<AppCustomizationPage> {
  final List<ColorModel> colors = [
    ColorModel(Colors.orange, 'Orange'),
    ColorModel(Colors.red, 'Red'),
    ColorModel(Colors.purple, 'Purple'),
    ColorModel(Colors.blue, 'Blue'),
    ColorModel(Colors.green, 'Green'),
    ColorModel(Colors.yellow, 'Yellow'),
  ];

  int selectedColorIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.grey.shade200,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('App Customization', style: ktextStyleBold,),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Custom Pin Screen',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Image.asset(
                  'assets/images/cown.jpg', // Replace with your image path
                  width: 100,
                  height: 100,
                ),
                SizedBox(width: 10),
                Image.asset(
                  'assets/images/cown.jpg', // Replace with your image path
                  width: 100,
                  height: 100,
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Theme Colors',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: colors.length,
              itemBuilder: (context, index) {
                final color = colors[index];
                final isSelected = index == selectedColorIndex;
                final colorIndicatorSize = 24.0;
                final colorIndicatorRadius = colorIndicatorSize / 2;
                final colorIndicatorMargin = EdgeInsets.only(right: 10.0);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColorIndex = index;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        Container(
                          width: colorIndicatorSize,
                          height: colorIndicatorSize,
                          decoration: BoxDecoration(
                            color: color.color,
                            shape: BoxShape.circle,
                          ),
                          margin: colorIndicatorMargin,
                          child: isSelected
                              ? Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                              : null,
                        ),
                        Text(color.name),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ColorModel {
  final Color color;
  final String name;

  ColorModel(this.color, this.name);
}
