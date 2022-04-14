
import 'package:comment/bean/res/curriculum_vo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widget/u_image.dart';
import 'curriculum_model.dart';

class CurriculumPage extends StatefulWidget {
  const CurriculumPage({Key? key}) : super(key: key);

  @override
  State<CurriculumPage> createState() => _CurriculumPageState();
}

class _CurriculumPageState extends State<CurriculumPage>
    with AutomaticKeepAliveClientMixin {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => CurriculumModel(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('课程审核'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            Selector<CurriculumModel,int>(builder: (context,value,child){
              var model = context.read<CurriculumModel>();
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      model.oneList.length,
                          (index) => InkWell(
                        onTap: (){
                          model.changeIndex(0, index);
                        },
                        child: Container(
                          child: Text(model.oneList[index]),
                          margin: const EdgeInsets.only(left: 10),
                          padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: value == index?Colors.orange:Colors.grey),
                        ),
                      )),
                ),
              );
            }, selector: (context,model)=>model.oneCurrentIndex),
            const SizedBox(
              height: 10,
            ),
            Selector<CurriculumModel,int>(builder: (context,value,child){
              var model = context.read<CurriculumModel>();
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      model.towList.length,
                          (index) => InkWell(
                        onTap: (){
                          model.changeIndex(1, index);
                        },
                        child: Container(
                          child: Text(model.towList[index]),
                          margin: const EdgeInsets.only(left: 10),
                          padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: value == index?Colors.orange:Colors.grey),
                        ),
                      )),
                ),
              );
            }, selector: (context,model)=>model.towCurrentIndex),
            const SizedBox(
              height: 10,
            ),

            Selector<CurriculumModel,int>(builder: (context,value,child){
              var model = context.read<CurriculumModel>();
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      model.threeList.length,
                          (index) => InkWell(
                        onTap: (){
                          model.changeIndex(2, index);
                        },
                        child: Container(
                          child: Text(model.threeList[index]),
                          margin: const EdgeInsets.only(left: 10),
                          padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: value == index?Colors.orange:Colors.grey),
                        ),
                      )),
                ),
              );
            }, selector: (context,model)=>model.threeCurrentIndex),
            const SizedBox(
              height: 10,
            ),
            Expanded(child:  Consumer<CurriculumModel>(builder: (context,model,child){
              return SingleChildScrollView(
                child: PaginatedDataTable(
                  columns: const [
                    DataColumn(label: SizedBox(
                      width: 50,
                      child: Center(child: Text('封面'),),)),
                    DataColumn(label: Text('标题')),
                    DataColumn(label: Text('作者'),),
                    DataColumn(label: Text('发布时间')),
                    DataColumn(label: Text('状态'),),
                    DataColumn(label: SizedBox(
                      width: 300,
                      child: Center(
                        child: Text('操作'),
                      ),
                    ),numeric: true),
                  ],
                  source: MyDataTableSource(model.curriculumList),
                ),
              );
            },))
          ],
        ),
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}


class MyDataTableSource extends DataTableSource {
  MyDataTableSource(this.data);

  final List<CurriculumVo> data;

  @override
  DataRow getRow(int index) {

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          UImage('${data[index].cover}',mWidth: 50,mHeight: 50,margin: const EdgeInsets.symmetric(vertical: 5),),
        ),
        DataCell(Text('${data[index].title}')),
        DataCell(Text('${data[index].nickName}')),
        DataCell(Text('${data[index].postTime}')),
        DataCell(Text('${data[index].status}')),

        DataCell(SizedBox(
          width: 300,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MaterialButton(
                  child: const Text('通过'),
                  onPressed: (){
                  },
                ),
                MaterialButton(
                  child: const Text('不通过'),
                  onPressed: (){
                  },
                ),
                MaterialButton(
                  child: const Text('详情'),
                  onPressed: (){
                  },
                ),
              ],
            ),
          ),
        ),),
      ],
    );
  }

  @override
  int get selectedRowCount {
    return 0;
  }

  @override
  bool get isRowCountApproximate {
    return false;
  }

  @override
  int get rowCount {
    return data.length;
  }

}