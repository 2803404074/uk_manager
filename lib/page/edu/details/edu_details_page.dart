import 'package:comment/const/api.dart';
import 'package:flutter/material.dart';
import 'package:httplib/io/http_proxy.dart';
import 'package:provider/provider.dart';
import 'package:uk_manager/page/edu/bean/applicant_vo.dart';
import 'package:uk_manager/page/edu/model/edu_model.dart';
import 'package:uk_manager/utils/dialog_util.dart';
import 'package:uk_manager/widget/u_image.dart';

class EduDetailsPage extends StatefulWidget {
  final int eId;
  final int index;
  final EduModel model;
  const EduDetailsPage({Key? key, required this.eId,required this.index,required this.model}) : super(key: key);

  @override
  _EduDetailsPageState createState() => _EduDetailsPageState();
}

class _EduDetailsPageState extends State<EduDetailsPage> {
  ApplicantVo? applicantVo;

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    HttpProxy.httpProxy.get(Api.applicantDetails,
        parameters: {'id': widget.eId}).then((value) {
      if (value.code == 200) {
        setState(() {
          applicantVo = ApplicantVo.fromJson(value.data);
        });
        print('长度:${applicantVo?.identityUrl?.length}');
      } else {
        DialogUtil.getInstance().showErrDialog(context, errTips: value.message);
      }
    }).onError((error, stackTrace) {
      DialogUtil.getInstance()
          .showErrDialog(context, errTips: error?.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: applicantVo == null
          ? const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (applicantVo?.qualificationsUrl != null)
                          _buildTitle('私教资质'),
                        if (applicantVo?.qualificationsUrl != null)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                  applicantVo?.qualificationsUrl?.length ?? 0,
                                      (index) {
                                    return Image.network(
                                      '${applicantVo?.qualificationsUrl![index]}',
                                      width: 200,
                                      fit: BoxFit.fitWidth,
                                    );
                                  }),
                            ),
                          ),

                        const SizedBox(height: 10,),
                        _buildTitle('身份证照片'),
                        if (applicantVo?.identityUrl != null)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                applicantVo?.identityUrl?.length ?? 0,
                                    (index) => Image.network(
                                  '${applicantVo?.identityUrl![index]}',
                                  width: 300,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),

                        const SizedBox(height: 10,),
                        if (applicantVo?.organizationUrl != null)
                          _buildTitle('机构证明照'),
                        if (applicantVo?.organizationUrl != null)
                          Image.network(
                            '${applicantVo?.organizationUrl}',
                            width: 300,
                            fit: BoxFit.fitWidth,
                          ),
                        Divider(
                          height: 50,
                          thickness: 5,
                          color: Colors.grey[200],
                        ),


                        Row(
                          children: [
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildRowTitle('入驻类型',
                                    applicantVo?.applicationType == 0 ? '个人' : '机构'),
                                _buildRowTitle('经验', applicantVo?.goodAt),
                                _buildRowTitle('所在地', applicantVo?.location),
                              ],
                            )),
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildRowTitle('真实姓名', applicantVo?.realName),
                                _buildRowTitle('手机号', applicantVo?.phoneNum),
                                _buildRowTitle('身份证号', applicantVo?.identityNumber),
                              ],
                            )),
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildRowTitle('机构名称', applicantVo?.organizationName),
                                _buildRowTitle('行业类型', applicantVo?.tradeType),
                                _buildRowTitle('社会信用代码', applicantVo?.creditCode),
                              ],
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),),
                  const SizedBox(height: 15,),
                  Row(
                    children: [
                      if(applicantVo?.status == 0 ||applicantVo?.status == 2 )
                        Expanded(
                            child: InkWell(
                              onTap: (){
                                DialogUtil.getInstance().showLoadDialog(context);
                                widget.model.pass(widget.index, 1).then((value){
                                  if(value){
                                    Navigator.pop(context);
                                    DialogUtil.getInstance().showMessageAlertDialog(context, '操作成功');
                                    setState(() {
                                      applicantVo?.status = 1;
                                    });
                                  }else{
                                    Navigator.pop(context);
                                    DialogUtil.getInstance().showErrDialog(context, errTips: '操作失败');
                                  }
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.green),
                                child: const Text('通过',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              ),
                            )),
                      if(applicantVo?.status == 0 ||applicantVo?.status == 2 )
                        const SizedBox(
                          width: 20,
                        ),

                      if(applicantVo?.status == 0 ||applicantVo?.status == 1 )
                        Expanded(
                            child: InkWell(
                              onTap: (){
                                DialogUtil.getInstance().showLoadDialog(context);
                                widget.model.pass(widget.index, 2).then((value){
                                  if(value){
                                    Navigator.pop(context);
                                    DialogUtil.getInstance().showMessageAlertDialog(context, '操作成功');
                                    setState(() {
                                      applicantVo?.status = 1;
                                    });
                                  }else{
                                    Navigator.pop(context);
                                    DialogUtil.getInstance().showErrDialog(context, errTips: '操作失败');
                                  }
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.red),
                                child: const Text('不通过',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              ),
                            )),
                    ],
                  ),
                  const SizedBox(height: 15,),
                ],
              )


            ),
    );
  }

  _buildRowTitle(String title, String? subtitle) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.grey[200]),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$title : ',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            subtitle ?? '',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  _buildTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
