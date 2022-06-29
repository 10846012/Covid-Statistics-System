import 'package:flutter/material.dart';
import 'package:front_end/loginPage/forgotPwPage.dart';
import 'package:front_end/loginPage/signUpFinalPage.dart';
import 'package:front_end/mainPage.dart';
import 'package:front_end/loginPage/signUpPage.dart';
import 'package:get/get.dart';

import '../get.dart';

class loginPage extends StatelessWidget {
  loginPage({Key? key}) : super(key: key);

  getController getControllers = Get.put(getController());

  final studentID_Controller = TextEditingController();
  final password_Controller = TextEditingController();
  final studentID_Focus = FocusNode();
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

      if (studentID.isEmpty == true) {
        // Fluttertoast.showToast(
        //   msg: '請輸入驗證碼',
        //   gravity: ToastGravity.CENTER,
        //   toastLength: Toast.LENGTH_SHORT,
        //   timeInSecForIosWeb: 3,
        //   backgroundColor: Color.fromARGB(255, 65, 65, 66),
        // );
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('請輸入完整資料'),
                  content: Icon(Icons.warning_amber_rounded, color: Colors.yellow,size: 100,),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('確認')),
                  ],
                ));
      } else {
        if (password.isEmpty == true) {
          // Fluttertoast.showToast(
          //   msg: '未選取照片',
          //   gravity: ToastGravity.CENTER,
          //   toastLength: Toast.LENGTH_SHORT,
          //   timeInSecForIosWeb: 3,
          //   backgroundColor: Color.fromARGB(255, 65, 65, 66),
          // );
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('請輸入完整資料'),
                  content: Icon(Icons.warning_amber_rounded, color: Colors.yellow,size: 100,),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('確認')),
                  ],
                ));
        } else {
          print('登入成功');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => mainPage()),
          );
        }
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
                  padding: EdgeInsets.only(top: 120),
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset('assets/images/LOGO.png'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        '登入',
                        style: TextStyle(fontSize: 30),
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
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.all(Radius.circular(12)),
                      //     ),
                      child: TextField(
                        decoration:
                            InputDecoration(labelText: '學號', hintText: '請輸入學號'),
                        keyboardType: TextInputType.number,
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

                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.all(Radius.circular(12)),
                      //     ),
                      child: TextField(
                        decoration:
                            InputDecoration(labelText: '密碼', hintText: '請輸入密碼'),
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
