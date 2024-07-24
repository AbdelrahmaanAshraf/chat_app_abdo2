import 'package:chat_app_abdo2/consts.dart';
import 'package:chat_app_abdo2/model/classes/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubbleFromFriend extends StatelessWidget {
  const ChatBubbleFromFriend({super.key,required this.messageModel});
final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(8.sp),
        padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 16.w),
        //alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: kFriendColorChat,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r)
          )
        ),
        child: Text(messageModel.message,style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp
        ),),
      ),
    );
  }
}
