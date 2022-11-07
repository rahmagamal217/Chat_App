import 'package:chat_app/Models/message.dart';
import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Widgets/chat_buble.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);
  static String id = 'chatPage';
  final _controller = ScrollController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kmessagescollection);
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kcreatesAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageslist = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageslist.add(Message.fromjason(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    klogo,
                    height: 50,
                  ),
                  const Text('Scholar Chat'),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messageslist.length,
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      return messageslist[index].id == email
                          ? ChatBuble(
                              message: messageslist[index],
                            )
                          : ChatBubleRecieved(message: messageslist[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: ((data) {
                      messages.add(
                        {
                          kmessage: data,
                          kcreatesAt: DateTime.now(),
                          'id': email
                        },
                      );
                      controller.clear();
                      _controller.animateTo(
                        0,
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                      );
                    }),
                    decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffixIcon: const Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: kPrimaryColor,
                            ))),
                  ),
                )
              ],
            ),
          );
        } else {
          return const Text('Loading....');
        }
      },
    );
  }
}
