import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_end/package/get.dart';
import 'package:front_end/mainPage/mainPage.dart';
import 'package:front_end/reportPage/reportPage.dart';
import 'package:get/get.dart';

class verification_Code extends StatelessWidget {
  verification_Code({Key? key}) : super(key: key);

  getController getControllers = Get.put(getController()); //get套件

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => mainPage()),
              );
            },
          ),
          title: Text(
            '回報頁面',
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: getController.themeColor,
        ),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 35, right: 35, bottom: 120),
                child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: Color.fromARGB(255, 54, 160, 247)),
                    child: TextButton(
                        onPressed: () {
                          showCupertinoModalPopup<void>(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              title: Text('驗證碼已傳送至信箱'),
                              content: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.green,
                                  size: 80,
                                ),
                              ),
                              actions: <CupertinoDialogAction>[
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  onPressed: () {
                                    getControllers
                                        .reportVerificationCodeGenerator();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => reportPage()),
                                    );
                                  },
                                  child: const Text('確認'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text(
                          '傳送驗證碼至信箱',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ))),
              )
            ],
          ),
        ));
  }
}
