
import 'dart:html';
import 'package:comment/const/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:httplib/io/http_proxy.dart';
import 'package:provider/provider.dart';
import 'package:uk_manager/page/adv/model/adv_model.dart';

import '../bean/adv_vo.dart';
class AdvAddEditPage extends StatefulWidget {

  final AdvModel model;
  final Adv_vo? vo;
  const AdvAddEditPage({Key? key,required this.model,this.vo}) : super(key: key);

  @override
  _AdvAddEditPageState createState() => _AdvAddEditPageState();
}

class _AdvAddEditPageState extends State<AdvAddEditPage> {

  final titleStyle = const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black);

  dynamic uploadedImage;

  int localType = 0;

  var requestDto = <String,dynamic>{
    'advTypeId':'',
    'cover':null,
    'title':'',
    'linkUrl':'',
    'local':0,
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestDto['advTypeId'] = widget.model.tId;

    localType = widget.vo?.local??0;
    requestDto['local'] = localType;

    requestDto['title'] = widget.vo?.title;
    requestDto['linkUrl'] = widget.vo?.linkUrl;
  }




  void addImage()async{
    FileUploadInputElement? uploadInput = FileUploadInputElement();
    uploadInput.click();
    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if(files == null)return;
      if (files.length == 1) {
        final file = files[0];
        FileReader reader =  FileReader();

        reader.onLoadEnd.listen((e) {
          setState(() {
            uploadedImage = reader.result;
          });
          requestDto['file'] =  MultipartFile.fromBytes(uploadedImage,filename: 'test.jpg');

        });

        reader.onError.listen((fileEvent) {
          requestDto['file']=null;
          setState(() {
           // option1Text = "Some Error occured while reading the file";
          });
        });

        reader.readAsArrayBuffer(file);
      }
    });
  }


  void commit()async{
    requestDto.forEach((key, value) {
      if(value == null || value == ''){
        return;
      }
    });
    print('请求参数:$requestDto');
    if(requestDto['file'] == null){
      if(widget.vo?.cover == null){
        return;
      }else{
        requestDto['cover'] = widget.vo?.cover;
        requestDto['advId'] = widget.vo?.id;
      }
    }



    HttpProxy.httpProxy.post(widget.vo==null?Api.addAdv:Api.updateAdv, parameters: requestDto).then((value){
      if(value.code == 200){
        print('${value.code}-------${value.data}');
        widget.model.getAdvList();
        Navigator.pop(context);
      }

    }).onError((error, stackTrace){
      print('失败:${error.toString()}');
    });
  }

  Widget imageView(){
    if(uploadedImage!=null){
      return Image.memory(uploadedImage,fit: BoxFit.fitWidth,width: 200,);
    }
    if(widget.vo?.cover!=null){
      return Image.network(widget.vo!.cover!,width: 200,fit: BoxFit.fitWidth,);
    }
    return const SizedBox(width: 200,height: 200,child: Center(
      child: Icon(Icons.add),
    ),);
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value: widget.model,child: Consumer<AdvModel>(builder: (context,model,child){
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('广告封面',style: titleStyle,),


              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: (){
                        addImage();
                      },
                      child: imageView()
                  ),
                  const SizedBox(width: 10,),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                      TextField(
                        controller: TextEditingController(text: requestDto['title']),
                        onChanged: (value){
                          requestDto['title'] = value;
                        },
                        decoration: InputDecoration(
                            hintText: '广告标题',
                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextField(
                        controller: TextEditingController(text: requestDto['linkUrl']),
                        onChanged: (value){
                          requestDto['linkUrl'] = value;
                        },
                        decoration: InputDecoration(
                            hintText: '广告链接'
                        ),
                      ),

                      const SizedBox(height: 50,),
                      MaterialButton(
                        onPressed: (){
                          commit();
                          //print('提交内容:$requestDto');
                        },
                        color: Colors.green,
                        child: const Text('提交'),
                      )
                    ],
                  ),)
                ],
              ),
            ],
          ),
        ),
      );
    }),);
  }

}
