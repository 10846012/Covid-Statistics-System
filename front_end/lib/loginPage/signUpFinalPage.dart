import 'dart:io';

import 'package:flutter/material.dart';
import 'package:front_end/loginPage/loginPage.dart';
import 'package:front_end/loginPage/signUpPage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../get.dart';

class signUpFinalPage extends StatefulWidget {
  const signUpFinalPage({Key? key}) : super(key: key);

  @override
  State<signUpFinalPage> createState() => _signUpFinalPageState();
}

class _signUpFinalPageState extends State<signUpFinalPage> {
  getController getControllers = Get.put(getController());

  final verificationCode_Controller = TextEditingController();

  File? image;

  final ImagePicker _picker = ImagePicker();
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

  void dataEmptyCheck() {
    String verificationCode = verificationCode_Controller.text;

    if (verificationCode.isEmpty == true) {
      // Fluttertoast.showToast(
      //   msg: '請輸入驗證碼',
      //   gravity: ToastGravity.CENTER,
      //   toastLength: Toast.LENGTH_SHORT,
      //   timeInSecForIosWeb: 3,
      //   backgroundColor: Color.fromARGB(255, 65, 65, 66),
      // );
      print('請輸入驗證碼');
    } else {
      if (getControllers.signUpPageTempPhoto == null) {
        // Fluttertoast.showToast(
        //   msg: '未選取照片',
        //   gravity: ToastGravity.CENTER,
        //   toastLength: Toast.LENGTH_SHORT,
        //   timeInSecForIosWeb: 3,
        //   backgroundColor: Color.fromARGB(255, 65, 65, 66),
        // );
        print('未擷取照片');
      } else {
        print('註冊成功'); 
        
        getControllers.signUpPageTempPhoto == null;
        getControllers.signUpDataTest();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => loginPage()),
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
                               print('已重新傳送驗證碼至信箱');
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

                            // showDialog(
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
