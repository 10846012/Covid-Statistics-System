import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class getController extends GetxController {
  var reportPageTempPhoto = null; //回報畫面確診證明照片暫存
  var signUpPageTempPhoto = null; //註冊畫面學生證照片暫存
  var confirmed_cases = 0; //確診人數

  static Color themeColor = Color.fromARGB(255, 165, 1, 129); //theme color

  //傳回後端資料

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

  //將資料轉成json檔
  void reportDataToJson() {
    var dataToJson = {
      "sStudentID": sStudentID,
      "sEmailAdress": sEmailAdress,
      "sStudentCard": sStudentCard,
      "rConfirmedPic":"rConfirmedPic"
    };
    var reportDataToJson = jsonEncode(dataToJson);
    print(reportDataToJson);
  }

//回報完增加確診人數
  void caseAdd() {
    confirmed_cases++;
  }


}
