import 'package:chat_app_abdo2/model/classes/message_model.dart';
import 'package:chat_app_abdo2/model/cubit/auth/login_cubit/login_cubit.dart';
import 'package:chat_app_abdo2/model/cubit/auth/login_cubit/login_state.dart';
import 'package:chat_app_abdo2/widget/chat_bubble_from_friend.dart';
import 'package:chat_app_abdo2/widget/my_chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../consts.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  TextEditingController messageController = TextEditingController();
  final scrollController = ScrollController();
  static String id = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    var loginCubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LogOutState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return StreamBuilder<QuerySnapshot>(
          stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<MessageModel> messageList = [];
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                messageList.add(
                  MessageModel.fromJson(
                    snapshot.data!.docs[i],
                  ),
                );
              }
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: kPrimaryColor,
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        kLogoPhoto,
                        height: 50.h,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        'Chat',
                        style: TextStyle(fontSize: 22.sp, color: Colors.white),
                      )
                    ],
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        loginCubit.logOut();
                      },
                      icon: const Icon(
                        Icons.logout_outlined,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          reverse: true,
                          controller: scrollController,
                          itemCount: messageList.length,
                          itemBuilder: (context, index) {
                            return messageList[index].id == email
                                ? MyChatBubble(
                                    messageModel: messageList[index])
                                : ChatBubbleFromFriend(
                                    messageModel: messageList[index]);
                          }),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
                      child: TextFormField(
                        controller: messageController,
                        onFieldSubmitted: (data) {
                          messages.add(
                            {
                              kMessage: data,
                              kCreatedAt: DateTime.now(),
                              'id': email
                            },
                          );
                          messageController.clear();
                          scrollController.animateTo(
                            scrollController.position.minScrollExtent,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn,
                          );
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.send,
                              color: kPrimaryColor,
                            ),
                          ),
                          hintText: 'Send message',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const Text('Loading.....');
            }
          },
        );
      },
    );
  }
}
