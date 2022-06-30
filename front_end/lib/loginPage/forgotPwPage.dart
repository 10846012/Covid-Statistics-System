import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_end/package/get.dart';
import 'package:front_end/loginPage/loginPage.dart';

class forgotPwPage extends StatelessWidget {
  forgotPwPage({Key? key}) : super(key: key);

  //textfield controller and dispose
  final studentID_Controller = TextEditingController();
  final emailAddress_Controller = TextEditingController();
  final studentID_Focus = FocusNode();
  @override
  void dispose() {
    studentID_Controller.dispose();
    emailAddress_Controller.dispose();
    studentID_Focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // forgot password data check
    void forgotPwDataCheck() {
      String studentID, emailAddress;

      studentID = studentID_Controller.text;
      emailAddress = emailAddress_Controller.text;

      if (studentID.isEmpty == true || emailAddress.isEmpty == true) {
        showCupertinoModalPopup<void>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text('學號或信箱不可為空'),
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
          showCupertinoModalPopup<void>(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text('已寄出重置密碼信件至您的信箱'),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => loginPage()),
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
              '忘記密碼',
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
                    padding: EdgeInsets.only(left: 35, right: 35, top: 292),
                    child: Center(
                      child: Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Color.fromARGB(255, 54, 160, 247)),
                        child: TextButton(
                          onPressed: () {
                            forgotPwDataCheck();
                          },
                          child: Text(
                            '找回密碼',
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
