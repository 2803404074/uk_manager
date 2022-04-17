

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uk_manager/page/curriculum/category/CategoryModel.dart';
import 'package:uk_manager/provider/base_model.dart';
import 'package:uk_manager/utils/dialog_util.dart';
import 'package:uk_manager/widget/u_image.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin{


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(create: (context)=>CategoryModel(context),
    child: Consumer<CategoryModel>(
      builder: (context,model,child){
        if(model.status == LoadStatus.loading){
          return Center(
            child: DialogUtil.getInstance().loadingView(),
          );
        }
        if(model.status == LoadStatus.err){
          return Center(
            child: InkWell(
              onTap: (){
                model.getData();
              },
              child: Text(model.errStr??''),
            ),
          );
        }

        return Column(
          children: [
            const SizedBox(height: 20,),
            Row(
              children: [
                InkWell(
                  onTap: (){
                    model.addImage();
                  },
                  child:
                  model.uploadedImage == null?
                  Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    child: const Icon(Icons.add),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200]
                    ),
                  ):Image.memory(model.uploadedImage,width: 100,fit: BoxFit.fitWidth,),
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: '分类名称'
                        ),
                      onChanged: (str){
                        model.requestDto['name'] = str;
                      },
                    ),),
                    SizedBox(height: 10,),
                    MaterialButton(onPressed: (){
                      model.addType();
                    },child: const Text('添加分类'),textColor: Colors.white,color: Colors.black,)
                  ],
                )
              ],
            ),

            Expanded(child: GridView.count(crossAxisCount: 5,
              childAspectRatio: 2/1.3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
              children: List.generate(model.list.length, (index){
                var vo = model.list[index];
                return InkWell(
                  onTap: (){
                    DialogUtil.getInstance().showMessageAlertDialog(context, '${vo.name}',[
                      ActionTextItem('取消'),
                      ActionTextItem('修改',clickCallBack: (){

                      }),
                      ActionTextItem('删除',clickCallBack: (){
                        DialogUtil.getInstance().showMessageAlertDialog(context, '即将删除该分类，是否继续？',[
                          ActionTextItem('取消'),
                          ActionTextItem('确定',clickCallBack: (){
                            model.deleteType(index);
                          }),
                        ],title: '操作');
                      }),
                    ],title: '操作');
                  },
                  child: Container(
                    alignment:Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[200]
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        UImage(vo.icon!,mWidth: 50,mHeight: 50,borderRadius: BorderRadius.circular(25),),
                        const SizedBox(width: 10,),
                        Text(vo.name!)
                      ],
                    ),
                  ),
                );
              }),
            ))
          ],
        );


      },
    ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
