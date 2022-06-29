import 'package:flutter/material.dart';
import 'package:front_end/get.dart';
import 'package:front_end/loginPage/loginPage.dart';

class forgotPwPage extends StatelessWidget {
  forgotPwPage({Key? key}) : super(key: key);

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
    void forgotPwDataCheck() {
      String studentID, emailAddress;

      studentID = studentID_Controller.text;
      emailAddress = emailAddress_Controller.text;

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
        if (emailAddress.isEmpty == true) {
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
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('已寄出重置密碼信件至您的信箱'),
                  content: Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 100,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => loginPage()),
                          );
                        },
                        child: Text('確認')),
                  ],
                ));
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

                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.all(Radius.circular(12)),
                        //     ),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: '學號', hintText: '請輸入學號'),
                          keyboardType: TextInputType.number,
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
                              labelText: '信箱', hintText: '請輸入註冊信箱'),
                          keyboardType: TextInputType.emailAddress,
                          controller: emailAddress_Controller,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                padding: EdgeInsets.only(left: 35, right: 35,top: 292),
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
