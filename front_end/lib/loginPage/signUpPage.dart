import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_end/package/get.dart';
import 'package:front_end/loginPage/loginPage.dart';
import 'package:front_end/loginPage/signUpFinalPage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';

class signUpPage extends StatefulWidget {
  const signUpPage({Key? key}) : super(key: key);

  @override
  State<signUpPage> createState() => _signUpPageState();
}

getController getControllers = Get.put(getController()); //get套件

class _signUpPageState extends State<signUpPage> {
  void initState() {
    super.initState();
    getController.sStudentID = '';
    getController.sPassword = '';
    getController.sEmailAdress = '';
  }

  //會用到的textfield的Controller跟Focus
  final studentID_Controller = TextEditingController();
  final emailAddress_Controller = TextEditingController();
  final password_Controller = TextEditingController();
  final studentID_Focus = FocusNode();
  //textfield dispose
  @override
  void dispose() {
    studentID_Controller.dispose();
    password_Controller.dispose();
    emailAddress_Controller.dispose();
    studentID_Focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void signUpDataCheck() {
      String studentID, password, emailAddress; //創建判斷字串

      //將使用者輸入存入判斷字串
      studentID = studentID_Controller.text;
      password = password_Controller.text;
      emailAddress = emailAddress_Controller.text;

      if (studentID.isEmpty == true ||
          password.isEmpty == true ||
          emailAddress_Controller.text.isEmpty == true) {
        showCupertinoModalPopup<void>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text('學號、密碼或信箱不可為空'),
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
        if (EmailValidator.validate(emailAddress_Controller.text) != true) {
          showCupertinoModalPopup<void>(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text('請輸入正確的信箱格式'),
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
          getController.sStudentID = studentID;
          getController.sPassword = password;
          getController.sEmailAdress = emailAddress;
          showCupertinoModalPopup<void>(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
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
                    getControllers.signUpVerificationCodeGenerator();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => signUpFinalPage()),
                    );
                  },
                  child: const Text('確認'),
                ),
              ],
            ),
          );
        }
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => loginPage()),
                );
              },
            ),
            title: Text(
              '創建帳號',
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 35, right: 35, top: 50),
                    child: Center(
                      child: Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,

                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.all(Radius.circular(12)),
                        //     ),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: '學號', hintText: '請輸入學號(8碼)'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(8),
                          ],
                          focusNode: studentID_Focus,
                          controller: studentID_Controller,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 35, right: 35, top: 20),
                    child: Center(
                      child: Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,

                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.all(Radius.circular(12)),
                        //     ),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: '密碼', hintText: '請輸入密碼(最多為12碼)'),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(12),
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-z A-Z 0-9]'))
                          ],
                          obscureText: true,
                          controller: password_Controller,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 35, right: 35, top: 20),
                    child: Center(
                      child: Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: '信箱', hintText: '請輸入註冊信箱(格式需正確)'),
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-z A-Z 0-9 @ .]'))
                          ],
                          controller: emailAddress_Controller,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 35, right: 35, top: 202),
                    child: Center(
                      child: Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Color.fromARGB(255, 54, 160, 247)),
                        child: TextButton(
                          onPressed: () {
                            signUpDataCheck();
                          },
                          child: Text(
                            '下一步',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
