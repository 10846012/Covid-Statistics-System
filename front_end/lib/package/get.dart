import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class getController extends GetxController {
  var reportPageTempPhoto = null; //回報畫面確診證明照片暫存
  var signUpPageTempPhoto = null; //註冊畫面學生證照片暫存
  var confirmed_cases = 0; //確診人數
  static String signUpTempVerificationCode = ''; //創建帳號驗證碼暫存
  static String reportTempVerificationCode = ''; //創建帳號驗證碼暫存

  static Color themeColor = Color.fromARGB(255, 165, 1, 129); //theme color

  

  //傳回後端資料
  //------
  //註冊
  static String sStudentID = ''; //學號
  static String sPassword = ''; //密碼
  static String sEmailAdress = ''; //信箱
  static String sStudentCard = ''; //照片路徑

  //將資料轉成json檔
  void signDataToJson() {
    var dataToJson = {
      "sStudentID": sStudentID,
      "sPassword": sPassword,
      "sEmailAdress": sEmailAdress,
      "sStudentCard": sStudentCard,
    };
    var signDataToJson = jsonEncode(dataToJson);
    print(signDataToJson);
  }

  //回報
  static String rConfirmedPic = ''; //照片路徑
  static bool rSubmitted = false; //偵測是否回報過

  //將資料轉成json檔
  void reportDataToJson() {
    var dataToJson = {
      "sStudentID": sStudentID,
      "rConfirmedPic": rConfirmedPic,
      "rSubmitted": rSubmitted
    };
    var reportDataToJson = jsonEncode(dataToJson);
    print(reportDataToJson);
  }

  //-------

//回報完增加確診人數
  void caseAdd() {
    confirmed_cases++;
  }

  //註冊驗證碼產生器
  void signUpVerificationCodeGenerator() {
    print(signUpTempVerificationCode);
    var rng = Random();
    String v = '';
    for (var i = 0; i < 4; i++) {
      v = v + rng.nextInt(9).toString();
    }
    print(v);
    getController.signUpTempVerificationCode = v;
  }

//回報驗證碼產生器
  void reportVerificationCodeGenerator() {
    print(reportTempVerificationCode);
    var rng = Random();
    String v = '';
    for (var i = 0; i < 4; i++) {
      v = v + rng.nextInt(9).toString();
    }
    print(v);
    getController.reportTempVerificationCode = v;
  }

  //Sign Up完成回傳值與呼叫
  void signUpDone() {
    signUpPageTempPhoto == null; //將暫存照片刪除
    signDataToJson();
  }

  //report完成回傳值與呼叫
  void reportDone() {
    caseAdd(); //增加案例數值
    rSubmitted = true; //只能回報一次限制
    reportPageTempPhoto = null; //將暫存照片刪除
    reportDataToJson();
  }
}
