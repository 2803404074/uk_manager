

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

        return GridView.count(crossAxisCount: 5,
        childAspectRatio: 2/1.3,
          children: List.generate(model.list.length, (index){
            var vo = model.list[index];
            return InkWell(
              child: Container(
                alignment:Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200]
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UImage(vo.icon,mWidth: 50,mHeight: 50,borderRadius: BorderRadius.circular(25),),
                    const SizedBox(width: 10,),
                    Text(vo.name)

                  ],
                ),
              ),
            );
          }),
        );


      },
    ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
