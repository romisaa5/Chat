import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frist/models/messages.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  List<Message> messagelist = [];
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  void sendMassege({required String messege, required String email}) {
    if (email != null) {
      messages
          .add({'message': messege, 'createdAt': DateTime.now(), 'id': email});
      controller.clear();
      _controller.animateTo(
        0,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  void getmeesages() {
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      messagelist.clear();
      for (var doc in event.docs) {
        messagelist.add(Message.fromjson(doc));
      }
      emit(ChatSuccess(messages: messagelist));
    });
  }
}
