import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_end/loginPage/loginPage.dart';
import 'package:front_end/loginPage/signUpPage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../package/get.dart';

class signUpFinalPage extends StatefulWidget {
  const signUpFinalPage({Key? key}) : super(key: key);

  @override
  State<signUpFinalPage> createState() => _signUpFinalPageState();
}

class _signUpFinalPageState extends State<signUpFinalPage> {
  getController getControllers = Get.put(getController()); //get套件
  final ImagePicker _picker = ImagePicker(); //image picker套件

  final verificationCode_Controller =
      TextEditingController(); //驗證碼textfield Controller

  File? image; //image picker的暫存值

  //image picker拍照片
  Future pickImage(ImageSource source) async {
    try {
      final image = await _picker.pickImage(source: source);

      if (image == null) return;
      getController.sStudentCard = image!.path;
      final imageTemp = File(image.path);
      setState(() {
        getControllers.signUpPageTempPhoto = imageTemp;
      });
    } catch (e) {
      print('上傳失敗');
    }
  }

  //確認
  void dataEmptyCheck() {
    String verificationCode = verificationCode_Controller.text;

    if (verificationCode.isEmpty == true ||
        getControllers.signUpPageTempPhoto == null) {
      showCupertinoModalPopup<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text('驗證碼或照片不可為空'),
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
      if (getController.signUpTempVerificationCode != verificationCode) {
        print(verificationCode);
        showCupertinoModalPopup<void>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text('驗證碼錯誤'),
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
        getControllers.signUpDone();
        showCupertinoModalPopup<void>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text('創建成功'),
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
                  getController.signUpTempVerificationCode = '';
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

  @override
  void initState() {
    super.initState();
    getController.sStudentCard = '';
    getControllers.signUpPageTempPhoto = null;
  }

  void dispose() {
    verificationCode_Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  MaterialPageRoute(builder: (context) => signUpPage()),
                );
              },
            ),
            title: Text(
              '最後一步',
              style: TextStyle(fontSize: 20),
            ),
            centerTitle: true,
            backgroundColor: getController.themeColor,
          ),
          body: SingleChildScrollView(
            child: Container(
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
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 35, top: 50),
                        child: Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width * 0.50,
                          child: TextField(
                            decoration: InputDecoration(
                                labelText: '驗證碼', hintText: '請輸入信箱驗證碼'),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            controller: verificationCode_Controller,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(left: 35, right: 35, top: 50),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: Color.fromARGB(255, 54, 160, 247)),
                          child: TextButton(
                            onPressed: () {
                              showCupertinoModalPopup<void>(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) =>
                                    CupertinoAlertDialog(
                                  title: Text('已重新傳送驗證碼至您的信箱'),
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
                                            .signUpVerificationCodeGenerator();
                                        Navigator.pop(context);
                                      },
                                      child: const Text('確認'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Text(
                              '重送驗證碼',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 35, right: 35, top: 30),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Color.fromARGB(255, 54, 160, 247)),
                        child: TextButton(
                          onPressed: () {
                            pickImage(ImageSource.camera);
                          },
                          child: Text(
                            '上傳學生證正面照',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 15, 35, 0),
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: getControllers.signUpPageTempPhoto != null
                            ? Image.file(getControllers.signUpPageTempPhoto,
                                fit: BoxFit.cover)
                            : Center(
                                child: Text('未選取照片'),
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 36, left: 35, right: 35),
                    child: Center(
                      child: Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Color.fromARGB(255, 54, 160, 247)),
                        child: TextButton(
                          onPressed: () {
                            dataEmptyCheck();
                          },
                          child: Text(
                            '完成註冊',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
