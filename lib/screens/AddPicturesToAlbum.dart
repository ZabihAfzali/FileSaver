import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:filesaver/screens/picture_preview.dart';
import 'package:flutter/material.dart';
import 'package:filesaver/constants/contants.dart';
import 'package:image_picker/image_picker.dart';

class AddPicturesToAlbum extends StatefulWidget {
  String strAlbumNam='';
  List<XFile> listOfAlbumPictures= [];
   AddPicturesToAlbum({Key? key, required this.strAlbumNam,required this.listOfAlbumPictures}) : super(key: key);

  @override
  State<AddPicturesToAlbum> createState() => _AddPicturesToAlbumState(strAlbumNam,listOfAlbumPictures);
}

class _AddPicturesToAlbumState extends State<AddPicturesToAlbum> {
  _AddPicturesToAlbumState(this.strAlbumNam, this.listOfAlbumPictures);

  String strAlbumNam;
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
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          backgroundColor: Colors.grey.shade200,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 2),
            child: Column(
              children: [
                SizedBox(height: 55,),
                // Padding(padding: EdgeInsets.all(10)),
                Text('$strAlbumNam',style: ktextStyleBold,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    TextButton(
                      onPressed: (){
                        _showMyDialog();
                      },
                      child: Text('Add Pictures',style: ktextStyleSmall,),

                    ),


                      TextButton(
                        onPressed: (){

                        },
                        child: Text('Delete Pictures',style: ktextStyleSmall,),

                      ),
                  ],
                ),
              ],
            ),
          ),

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

              itemCount: listOfAlbumPictures.length,
              itemBuilder: (BuildContext context, int index) {
                return  GridTile(
                  child: InkWell(
                    onTap: (){
                      strSendImage=convertXFileToString(listOfAlbumPictures![index]);
                      Navigator.push(context, MaterialPageRoute(builder: (ctx){
                        return PreviewP(imgList: strSendImage!);
                      }));
                      print('ab dekho result: $strSendImage');
                    },
                    child: Container(
                      child:Center(
                        child: Container(
                          height: 120,
                          width: 120,
                          color: Colors.cyan,
                          child: listOfAlbumPictures[index] != ""?Image.file(
                            File(listOfAlbumPictures![index].path),
                            fit: BoxFit.cover,
                          ):
                          Text('no image  selected'),

                        ),
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
              ],
            ),
          ),
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

    final List<XFile> selectedImages = await
    imgpicker.pickMultiImage();

    if (selectedImages.isNotEmpty) {
      firstIndex=firstIndex! + 1;
      listOfAlbumPictures!.addAll(selectedImages);

    }


    print("Image List Length:" + listOfAlbumPictures!.length.toString());
    print('First index $firstIndex');
    print('FirstSelectedImageLength ${firstSelectedImage.length}');
    setState((){});
  }
  XFile? convertStringToXFile(String path) {
    return XFile(path);
  }
  String convertXFileToString(XFile xfile) {
    return xfile.path;
  }

}
