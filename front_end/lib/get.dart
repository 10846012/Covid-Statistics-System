import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class getController extends GetxController {
  var reportPageTempPhoto = null; //回報畫面確診證明照片暫存
  var signUpPageTempPhoto = null; //註冊畫面學生證照片暫存
  var confirmed_cases = 0;  //確診人數

  static Color themeColor = Color.fromARGB(255, 165, 1, 129); //theme color

  //傳回後端資料
  
    //註冊
    static String sStudentID = '';
    static String sPassword = '';
    static String sEmailAdress = '';
    static String sStudentCard = '';


    //回報
    static String rConfirmedPic = '';




//回報完增加確診人數
void caseAdd(){
  confirmed_cases++;
}


//test
void signUpDataTest(){
  print(sStudentID);
  print(sPassword);
  print(sEmailAdress);
  print(sStudentCard);
}

void reportDataTest(){
  print(rConfirmedPic);
}




}