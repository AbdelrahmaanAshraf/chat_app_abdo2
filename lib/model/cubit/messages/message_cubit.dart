import 'package:chat_app_abdo2/model/cubit/messages/message_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../consts.dart';
import '../../classes/message_model.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super (InitMessageState());

  static MessageCubit get(context) {
    return BlocProvider.of<MessageCubit>(context);
  }

  CollectionReference messages =
  FirebaseFirestore.instance.collection(kMessagesCollection);
  TextEditingController messageController = TextEditingController();
  final scrollController = ScrollController();
  List<MessageModel> messageList = [];

  void getMessage(snapshot){
  }
void sendMessage(data){
  messages.add(
    {
      kMessage: data,
      kCreatedAt: DateTime.now(),
    },
  );
  emit(SuccessSentMessageState());
}
void scrollDown(){
  messageController.clear();
  scrollController.animateTo(
    scrollController.position.maxScrollExtent,
    duration: const Duration(seconds: 2),
    curve: Curves.fastOutSlowIn,
  );
  emit(ScrollToEndMessageState());
}
}