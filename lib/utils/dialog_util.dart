
import 'package:flutter/material.dart';

import '../widget/u_image.dart';

class ActionTextItem {
  Widget? icon;
  String title;
  Color? buttonColor;
  Color? buttonTxtColor;
  Function? clickCallBack;

  ActionTextItem(this.title, {this.clickCallBack,this.icon,this.buttonColor,this.buttonTxtColor});
}

class DialogUtil {
  static DialogUtil? _dialog;

  static DialogUtil getInstance() {
    _dialog ??= DialogUtil();
    return _dialog!;
  }

  void showActionBottomSheet(BuildContext context, List<ActionTextItem> item) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          item.length,
          (index) => InkWell(
            onTap: () async {
              Navigator.pop(context);
              item[index].clickCallBack?.call();
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(width: 0.2, color: Color(0xFF9E9E9E)))),
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(item[index].icon!=null)
                    item[index].icon!,
                  Text(
                    item[index].title,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showInputAlertDialog(BuildContext context, dynamic defaultText,
      Function(String inputText) callBack,

      {String? titles,Function(String inputText,String value2)? callBack2}) {
    final controller = TextEditingController();
    TextEditingController? controller2;
    if(callBack2!=null){
      controller2 = TextEditingController();
    }
    controller.text = defaultText;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(titles ?? '编辑'),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            content:
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: const TextStyle(fontSize: 15),
                      hintText: '${defaultText ?? '请输入'}',
                      contentPadding: const EdgeInsets.all(0)),
                ),
                if(callBack2!=null)
                  TextField(
                    controller: controller2,
                    autofocus: true,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintStyle:  TextStyle(fontSize: 15),
                        hintText: 'app展示位置:0、1、2、3.....数字最小为最上面',
                        contentPadding: EdgeInsets.all(0)),
                  ),
              ],
            )
            ,
            actions: [
              MaterialButton(
                  color: Colors.grey[200],
                  child: const Text('取消'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              MaterialButton(
                  child: const Text(
                    '确定',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.orange,
                  onPressed: () {
                    Navigator.pop(context);
                    if(callBack2!=null){
                      callBack2.call(controller.text,controller2?.text??'');
                    }else{
                      callBack.call(controller.text);
                    }
                  }),
            ],
          );
        });
  }

  void showMessageAlertDialog(BuildContext context, String content,List<ActionTextItem> item,
      {String? title}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title ?? '提示'),
            content: Text(content),
            actions: List.generate(item.length, (index){
              var vo = item[index];
              return MaterialButton(
                onPressed: (){
                  Navigator.pop(context);
                  vo.clickCallBack?.call();
                },
                child: Text(
                  vo.title,
                ),
                color: vo.buttonColor??Colors.black,
                textColor: vo.buttonTxtColor??Colors.white,
              );
            })
          );
        });
  }

  void showLoadDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return UnconstrainedBox(
            child: loadingView(),
          );
        });
  }

  void showErrDialog(BuildContext context,{String? errTips}){
    showDialog(context: context,
        barrierDismissible: false,
        builder: (context){
      return UnconstrainedBox(
        child: SizedBox(
          width: 200,
          height: 190,
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,

            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  const Icon(Icons.error_outline,color: Colors.red,size: 60,),
                  const SizedBox(height: 10,),
                  Text(errTips??'未知错误',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black54,fontSize: 16,),),
                  const Expanded(child: SizedBox()),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.orange
                      ),
                      child: const Text('确定',style:  TextStyle(color: Colors.white,fontSize: 14,),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  ///如果是自己的相册,可以删除
  ///
  void showImageListDialog(BuildContext context, List<String> urls,int index,{bool? album,Function(int index)? deleteCallBack}) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return ImageDialogPage(urls: urls,index: index,album: album??false,deleteCallBack: deleteCallBack,);
    }));
  }



  Widget loadingView(){
    return SizedBox(
      width: 100,
      height: 100,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black45),
          alignment: Alignment.center,
          child: const SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.orange),
            ),
          ),
        ),
      ),
    );
  }
}


class ImageDialogPage extends StatefulWidget {
  final List<String> urls;
  final int index;
  final bool album;
  final Function(int index)? deleteCallBack;
  const ImageDialogPage({Key? key,required this.urls,required this.index,required this.album,this.deleteCallBack}) : super(key: key);

  @override
  _ImageDialogPageState createState() => _ImageDialogPageState();
}

class _ImageDialogPageState extends State<ImageDialogPage> {

  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.index;
    print('tag=${widget.urls[index].toString()}');
    print('album=${widget.album}');
    print('2222---${widget.urls[index][0]}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black,
            child: PageView(
              controller: PageController(initialPage: index),
              physics: const BouncingScrollPhysics(),
              onPageChanged: (index){
                setState(() {
                  this.index = index+1;
                });
              },
              children: List.generate(
                  widget.urls.length,
                      (index) => InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Hero(
                      tag: widget.urls[index],
                      child: UImage(
                        widget.urls[index],
                        mWidth: double.infinity,
                        mHeight: double.infinity,
                        mFit: BoxFit.fitWidth,
                      ),
                    ),
                  )),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              decoration: const BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)),
              ),
              child: Text('${index+1}/${widget.urls.length}',style: const TextStyle(color: Colors.white,fontSize: 18),),
            ),
          ),

          if(widget.album)
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: (){
                  widget.deleteCallBack?.call(index);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 30,right: 15),
                  child: const Icon(Icons.delete_outline,color: Colors.white,),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black54
                  ),
                ),
              ),
            )

        ],
      ),
    );
  }
}


