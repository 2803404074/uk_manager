
import 'dart:ui';

import 'package:flutter/material.dart';

import 'index_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  bool codeLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/welcome_bg.png',
          width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter:ImageFilter.blur(sigmaX:3, sigmaY:3),//可以看源码
              child:Container(
                decoration:BoxDecoration(
                  color:(const Color.fromRGBO(225, 225,225, 1)).withOpacity(0.06),
                  borderRadius: BorderRadius.circular(20),
                ),

              ),
            ),
          ),
          Container(
            color: Colors.black54,
            width: double.infinity,
            height: double.infinity,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white70
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('欢迎来到Together管理系统',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green),),

                  codeLogin? Column(
                    children: [


                      TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: '请输入手机号',

                        ),
                      ),
                      Row(
                        children: [
                          const Expanded(child: TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: '请输入验证码'
                            ),
                          ),),
                          TextButton(onPressed: (){

                          }, child: const Text('获取验证码',))
                        ],
                      ),
                    ],
                  ):
                  Container(
                    width: 150,
                    height: 150,
                    color: Colors.red,
                    margin: EdgeInsets.only(top: 15),
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(onPressed: (){
                      setState(() {
                        codeLogin = !codeLogin;
                      });
                    },child: Text(codeLogin?'扫码登录':'验证码登录',style: TextStyle(color: Colors.grey),),),
                  ),

                  if(codeLogin)
                    InkWell(
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const IndexPage()));

                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300]
                        ),
                        child: const Text('登录',style: TextStyle(color: Colors.orange),),
                      ),
                    )


                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
