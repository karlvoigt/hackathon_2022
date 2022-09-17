import 'package:flutter/material.dart';
class syncData{
  String userIdSend = '';
  String userIdReceive = '';
  String userNameReceive = '';
  int BalanceSender = 0;
  int BalanceReceiver = 0;
  int updateAmount = 0;



  void getBalance(){
    //will be replaced by the database call

    /*
    BalanceSender will get balance from userIdSend
    BalanceReceiver will get balance from userIdReceive
    */


    BalanceSender = 500;
    BalanceReceiver = 0;
  }

  void updateBalance(String userId, int amount){

  }

  void setUserSend(String userSendId){
    //will be used with database call
    /*
    userIdSend will receive from the main
     */
    userIdSend = userSendId;

  }

  void setUserReceive(userReceiveId){
    //will be used with the database call

    /*
      userReceiveId will be received from the QR scan
     */

    userIdSend = userReceiveId;
    userNameReceive = "namefromdb"; //will get from the database
  }

  void loadMoney(){

  }


}