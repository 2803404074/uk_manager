
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uk_manager/page/adv/model/adv_model.dart';

class AdvAddEditPage extends StatefulWidget {

  final AdvModel model;
  const AdvAddEditPage({Key? key,required this.model}) : super(key: key);

  @override
  _AdvAddEditPageState createState() => _AdvAddEditPageState();
}

class _AdvAddEditPageState extends State<AdvAddEditPage> {

  final titleStyle = const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black);

  dynamic uploadedImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestDto['advTypeId'] = widget.model.tId;

  }
  var requestDto = {
    'advTypeId':'',
    'cover':'',
    'title':'',
    'linkUrl':'',
    'local':0,
  };



  int localType = 0;
  void addImage()async{
    FileUploadInputElement? uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if(files == null)return;
      if (files.length == 1) {
        final file = files[0];
        FileReader reader =  FileReader();

        reader.onLoadEnd.listen((e) {
          setState(() {
            uploadedImage = reader.result;
          });
        });

        reader.onError.listen((fileEvent) {
          setState(() {
           // option1Text = "Some Error occured while reading the file";
          });
        });

        reader.readAsArrayBuffer(file);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value: widget.model,child: Consumer<AdvModel>(builder: (context,model,child){
      return Scaffold(
        appBar: AppBar(
          title: const Text('添加广告'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('广告封面',style: titleStyle,),
            InkWell(
              onTap: (){
                addImage();
              },
              child:
              uploadedImage==null?Container(  alignment: Alignment.center, width: 200,
                height: 200,child: Icon(Icons.add),):
              SizedBox(
                width: 200,
                height: 200,
                child: Image.memory(uploadedImage,fit: BoxFit.cover,width: 200,),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Text('广告类型:',style: titleStyle,),
                SizedBox(width: 10,),
                InkWell(
                  onTap: (){
                    setState(() {
                      localType = 0;
                    });
                    requestDto['local'] = 0;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                    child: Text('本地'),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:  localType==0?Colors.orange:Colors.grey[200]
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                InkWell(
                  onTap: (){
                    setState(() {
                      localType = 1;
                    });
                    requestDto['local'] = 1;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                    child: Text('第三方'),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: localType==1?Colors.orange:Colors.grey[200]
                    ),
                  ),
                ),
              ],
            ),


            SizedBox(height: 20,),
            Text('标题',style: titleStyle,),
            TextField(
              onChanged: (value){
                requestDto['title'] = value;
              },
            ),

            SizedBox(height: 20,),
            Text('广告链接',style: titleStyle,),
            TextField(
              onChanged: (value){
                requestDto['linkUrl'] = value;
              },
            ),

            MaterialButton(
              onPressed: (){
                print('提交内容:$requestDto');
              },
              child: Text('提交'),
            )

          ],
        ),
      );
    }),);
  }

}
