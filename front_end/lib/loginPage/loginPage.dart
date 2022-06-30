import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_end/loginPage/forgotPwPage.dart';
import 'package:front_end/loginPage/signUpFinalPage.dart';
import 'package:front_end/mainPage/mainPage.dart';
import 'package:front_end/loginPage/signUpPage.dart';
import 'package:get/get.dart';

import '../package/get.dart';

class loginPage extends StatelessWidget {
  loginPage({Key? key}) : super(key: key);

  getController getControllers = Get.put(getController()); //get套件

  //會用到的textfield的Controller跟Focus
  final studentID_Controller = TextEditingController();   
  final password_Controller = TextEditingController();
  final studentID_Focus = FocusNode();

  //textfield dispose
  @override
  void dispose() {
    studentID_Controller.dispose();
    password_Controller.dispose();
    studentID_Focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void loginCheck() {
      String studentID, password;

      studentID = studentID_Controller.text;
      password = password_Controller.text;

      if (studentID.isEmpty == true || password.isEmpty == true) {
        showCupertinoModalPopup<void>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text('學號或密碼不可為空'),
            content: Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(
                Icons.do_not_disturb_alt_outlined,
                color: Colors.red,
                size: 80,
              ),
            ),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('確認'),
              ),
            ],
          ),
        );
      } else {
        showCupertinoModalPopup<void>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text('登入成功'),
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
                  getController.rSubmitted = false;
                  getController.sStudentID = studentID_Controller.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => mainPage()),
                  );
                },
                child: const Text('確認'),
              ),
            ],
          ),
        );
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 70),
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset('assets/images/LOGO.png'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 20),
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        '校內確診通報系統',
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35, right: 35, bottom: 20),
                  child: Center(
                    child: Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        decoration:
                            InputDecoration(labelText: '學號', hintText: '請輸入學號(8碼)'),
                        keyboardType: TextInputType.number,
                       inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(8),
                          ],
                        controller: studentID_Controller,
                        focusNode: studentID_Focus,
                        // onSubmitted: (_) =>
                        //     FocusScope.of(context).requestFocus(passwordFocus),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35, right: 35, bottom: 12),
                  child: Center(
                    child: Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        decoration:
                            InputDecoration(labelText: '密碼', hintText: '請輸入密碼(最多為12碼)'),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(12),
                          FilteringTextInputFormatter.allow(RegExp('[a-z A-Z 0-9]'))
                        ],
                        obscureText: true,
                        controller: password_Controller,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, bottom: 40),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => forgotPwPage()),
                        );
                      },
                      child: Text(
                        '忘記密碼？',
                        style: TextStyle(fontSize: 17),
                      ),
                    )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35, right: 35, bottom: 75),
                  child: Center(
                    child: Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: Color.fromARGB(255, 54, 160, 247)),
                      child: TextButton(
                        onPressed: () {
                          loginCheck();
                        },
                        child: Text(
                          '登入',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('初次使用？'),
                      ),
                    ),
                    Container(
                      height: 50,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => signUpPage()),
                            );
                          },
                          child: Text('建立帳號')),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
