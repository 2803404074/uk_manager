
import 'package:flutter/material.dart';

class ActionTextItem {
  Widget? icon;
  String title;
  Function? clickCallBack;

  ActionTextItem(this.title, {this.clickCallBack,this.icon});
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
      {String? titles}) {
    final controller = TextEditingController();
    controller.text = defaultText;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(titles ?? '编辑'),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            content: TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: const TextStyle(fontSize: 15),
                  hintText: '${defaultText ?? '请输入'}',
                  contentPadding: const EdgeInsets.all(0)),
            ),
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
                    if (controller.text != defaultText) {
                      callBack.call(controller.text);
                    }
                  }),
            ],
          );
        });
  }

  void showMessageAlertDialog(BuildContext context, String content,
      {String? title, Function? callBack}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title ?? '提示'),
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    '取消',
                    style: TextStyle(color: Colors.grey[400]),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    callBack?.call();
                  },
                  child: Text(
                    '确定',
                    style: TextStyle(color: Colors.grey[600]),
                  ))
            ],
          );
        });
  }

  void showLoadDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return UnconstrainedBox(
            child: SizedBox(
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
            ),
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

}


