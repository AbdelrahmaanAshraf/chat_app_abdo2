import '../../consts.dart';

class MessageModel {
  final String message;
  final String id;
  MessageModel(this.message, this.id);

  factory MessageModel.fromJson(jason) {
    return MessageModel(jason[kMessage],jason['id']);
  }
}
