import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_end/loginPage/forgotPwPage.dart';
import 'package:front_end/loginPage/loginPage.dart';
import 'package:front_end/reportPage/reportPage.dart';
import 'package:front_end/reportPage/verificationCode.dart';
import 'package:get/get.dart';
import '../package/get.dart';

class mainPage extends StatelessWidget {
  mainPage({Key? key}) : super(key: key);

  getController getControllers = Get.put(getController()); //get套件

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                showCupertinoModalPopup<void>(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: Text('確定要登出嗎？'),
                    content: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.question_mark_sharp,
                        color: Colors.grey,
                        size: 80,
                      ),
                    ),
                    actions: <CupertinoDialogAction>[
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => loginPage()),
                          );
                        },
                        child: const Text('確認'),
                      ),
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        onPressed: () {
                          Navigator.pop(
                            context,
                          );
                        },
                        child: const Text('取消'),
                      ),
                    ],
                  ),
                );
              },
            ),
            title: Text(
              '首頁',
              style: TextStyle(fontSize: 20),
            ),
            centerTitle: true,
            backgroundColor: getController.themeColor),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/campus.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.dstATop),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/images/LOGO.png'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      '目前校內通報人數',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50, bottom: 92),
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      getControllers.confirmed_cases.toString(),
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ),
              getController.rSubmitted != true
                  ? Padding(
                      padding: EdgeInsets.only(left: 35, right: 35),
                      child: Center(
                        child: Container(
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                color: Color.fromARGB(255, 54, 160, 247)),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          verification_Code()),
                                );
                              },
                              child: Text(
                                '我要通報',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            )),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(left: 35, right: 35),
                      child: Center(
                        child: Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: Color.fromARGB(255, 129, 141, 151)),
                          child: Center(
                            child: Text(
                              '已完成通報',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ));
  }
}
