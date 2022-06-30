import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_end/package/get.dart';
import 'package:front_end/mainPage/mainPage.dart';
import 'package:front_end/reportPage/verificationCode.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class reportPage extends StatefulWidget {
  const reportPage({Key? key}) : super(key: key);

  @override
  State<reportPage> createState() => _reportPageState();
}

class _reportPageState extends State<reportPage> {
  getController getControllers = Get.put(getController()); //get套件
  final ImagePicker _picker = ImagePicker(); //image picker套件

  final verificationCode_Controller =
      TextEditingController(); //輸入驗證碼的textfield的controller

  File? image; //存放拍完照後的照片

  //拍照功能
  Future pickImage(ImageSource source) async {
    try {
      final image = await _picker.pickImage(source: source);

      if (image == null) return;
      getController.rConfirmedPic = image!.path;
      final imageTemp = File(image.path);
      setState(() {
        getControllers.reportPageTempPhoto = imageTemp;
      });
    } catch (e) {
      print('上傳失敗');
    }
  }

  //驗證碼產生器
  void verificationCodeGenerator() {
    var rng = Random();
    String v = '';
    for (var i = 0; i < 4; i++) {
      v = v + rng.nextInt(9).toString();
    }
    print(v);
    getController.reportTempVerificationCode = v;
  }

  //輸入值偵測
  void dataEmptyCheck() {
    String verificationCode = verificationCode_Controller.text;
    //偵測是否為空值
    if (verificationCode.isEmpty == true ||
        getControllers.reportPageTempPhoto == null) {
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
      //偵測驗證碼
      if (getController.reportTempVerificationCode != verificationCode) {
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
        getControllers.reportDone();
        showCupertinoModalPopup<void>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text('回報完成'),
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
                  getController.reportTempVerificationCode = '';
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
  }

  @override
  void initState() {
    super.initState();
    getController.rConfirmedPic = '';
    getControllers.reportPageTempPhoto = null;
  }

  void dispose() {
    verificationCode_Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); //取消輸入
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => verification_Code()),
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
              //背景
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
                        //輸入驗證碼
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
                          //重送驗證碼
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
                                            .reportVerificationCodeGenerator();
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
                    //拍照
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

                            // showDialog( //利用alertdialog選擇相簿照片或選擇拍照
                            //     context: context,
                            //     builder: (context) => AlertDialog(
                            //           title: Text('選擇照片方式'),
                            //           actions: [
                            //             TextButton(
                            //                 onPressed: () {
                            //                   pickImage(ImageSource.camera);
                            //                   Navigator.pop(context);
                            //                 },
                            //                 child: Text('從相機拍攝')),
                            //             TextButton(
                            //                 onPressed: () {
                            //                   pickImage(ImageSource.gallery);
                            //                   Navigator.pop(context);
                            //                 },
                            //                 child: Text('從相簿選取'))
                            //           ],
                            //         ));
                          },
                          child: Text(
                            '上傳確診證明',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    //照片顯示
                    padding: const EdgeInsets.fromLTRB(35, 15, 35, 0),
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: getControllers.reportPageTempPhoto != null
                            ? Image.file(getControllers.reportPageTempPhoto,
                                fit: BoxFit.cover)
                            : Center(
                                child: Text('未選取照片'),
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    //完成
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
                            '完成回報',
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
