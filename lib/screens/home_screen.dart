import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:filesaver/screens/AddPicturesToAlbum.dart';
import 'package:filesaver/screens/picture_preview.dart';
import 'package:flutter/material.dart';
import 'package:filesaver/constants/contants.dart';
import 'package:image_picker/image_picker.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int listLength=0;
  int firstIndex=0;
  List<String> listAlbumName=[];
  List<XFile> firstSelectedImage= [];
  List<XFile> listOfAlbumPictures= [];
  int _selectedIndex = 0;
  final  imgpicker = ImagePicker();
  final TextEditingController albumNameController = TextEditingController();

  String imagepath = "";
  List<String> imageData=[];
  String? strSendImage;
  List<XFile>? imageFileList = [];






  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      'Albums',
                      style: ktextStyleBold
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Edit',
                          style: ktextStyleSmall
                        ))
                  ],
                ),
              ],
            ),
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

        body: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
          child: GridView.builder(
            shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),

              itemCount: firstSelectedImage.length,
              itemBuilder: (BuildContext context, int index) {
                return  GridTile(
                  child: InkWell(
                    onTap: (){
                      strSendImage=convertXFileToString(imageFileList![index]);
                      Navigator.push(context, MaterialPageRoute(builder: (ctx){
                        return AddPicturesToAlbum(strAlbumNam: listAlbumName[index], listOfAlbumPictures: listOfAlbumPictures,);
                      }));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15),
                        ),
                        border: Border.all(
                          color: Colors.black
                        )
                      ),
                      child:Column(
                        children: [
                          Text(
                           // 'new album'
                             listAlbumName[index]!=null ? listAlbumName[index]
                             :
                             'My Album: ${index+1}', style: ktextStyleSmall,
                          ),
                          Container(
                            height: 120,
                            width: 120,
                            color: Colors.cyan,
                            child: firstSelectedImage != ""?Image.file(
                              File(firstSelectedImage![index].path),
                              fit: BoxFit.cover,
                            ):
                            Text('no image  selected'),

                          ),
                        ],
                      ),

                    ),
                  ),
                );
              }
          ),
        ),
      ),
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
                  leading: Icon(Icons.photo_library),
                  title: Text('Import image from gallery'),
                  onTap: () {
                    selectImages();
                   // openImageFromGallery();
                    Navigator.pop(context);
                  },
                ),
                Divider(), // Divider between the first and second items
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Camera'),
                  onTap: () {
                    //selectImages();
                    openImageFromCamera();
                    Navigator.pop(context); // Close the dialog
                  },
                ),
                Divider(), // Divider between the second and third items
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                    showMyAlbumDialog();
                    // Handle action for accessing the album

                  },
                  child: ListTile(
                    leading: Icon(Icons.album),
                    title: Text('Album'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showMyAlbumDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(

          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          title: Text('Create new Album'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(
                thickness: 1,
                color: Colors.black,
              ),
              Text(
                'Enter a Name for your album',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: albumNameController,
                  decoration: InputDecoration(
                    hintText: 'Enter name',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // Cancel button logic here
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // OK button logic here
                      String albumName = albumNameController.text;
                      // Perform desired actions with the entered album name
                      listAlbumName.add(albumNameController.text);
                      Navigator.of(context).pop();
                      selectImages();
                      albumNameController.clear();


                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'OK',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  imageToStringConvert() async {

        File imagefile = File(imageFileList.toString()); //convert Path to File
        Uint8List imagebytes = await imagefile.readAsBytesSync(); //convert to bytes
        String base64string = base64.encode(imagebytes); //convert bytes to base64 string
        print(base64string);

        Uint8List decodedbytes = base64.decode(base64string);

        setState(() {

        });
  }
  openImageFromCamera() async {
    try {
      var pickedFile = await imgpicker.pickImage(source: ImageSource.camera);
      if(pickedFile != null){
        imagepath = pickedFile.path;
        XFile? xfile = convertStringToXFile(imagepath);
        if(xfile!=null) {
          imageFileList?.add(xfile);
        }
        //imageData.add(imagepath);
        print('This is image path: $imagepath');

        setState(() {

        });
      }else{
        print("No image is selected.");
      }
    }catch (e) {
      print("error while picking file.");
    }
  }

  void selectImages() async {

    listOfAlbumPictures.clear();

    final List<XFile> selectedImages = await
    imgpicker.pickMultiImage();

    if (selectedImages.isNotEmpty) {
      firstIndex=firstIndex! + 1;
      imageFileList!.addAll(selectedImages);


    }



    if(firstIndex<=1){
      firstSelectedImage.add(imageFileList![0]);
      listLength=imageFileList!.length;
      print('List Length $listLength');
      listOfAlbumPictures.addAll(imageFileList!);

    }
    else{
      firstSelectedImage.add(imageFileList![listLength]);

      for(int i=listLength;i<imageFileList!.length;i++){
        listOfAlbumPictures.add(imageFileList![i]);
      }
      listLength=imageFileList!.length;
    }

    print("Image List Length:" + imageFileList!.length.toString());
    print('First index $firstIndex');
    print('FirstSelectedImageLength ${firstSelectedImage.length}');
    print('Next Class list length ${listOfAlbumPictures.length}');
    setState((){});
  }
  XFile? convertStringToXFile(String path) {
    return XFile(path);
  }
  String convertXFileToString(XFile xfile) {
    return xfile.path;
  }


}


