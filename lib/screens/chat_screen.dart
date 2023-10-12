import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:takly/models/message_model.dart';

import '../widgets/message_bubble.dart';
import '../widgets/send_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static const routeName = 'chatscreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  CollectionReference message =
      FirebaseFirestore.instance.collection('messages');

  // late final scroll = ScrollController();

  @override
  // void initState() {
  //   scroll.animateTo(scroll.position.maxScrollExtent,
  //       duration: Duration(seconds: 1), curve: Curves.bounceIn);
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   scroll.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: message.orderBy('createdAt').snapshots(),
        builder: (context, snapshot) {
          List<Message> messageList = [];
          if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(
                Message.fromjson(
                  snapshot.data!.docs[i],
                ),
              );
            }
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                          Text(
                            'Annette Black',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/images/Main_Image/User_Active.png',
                                  ),
                                ),
                              ),
                              child: null),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return MessageBubble(
                              message: messageList[index],
                            );
                          },
                          itemCount: messageList.length,
                        ),
                      ),
                      Card(
                        elevation: 15,
                        child: SendMessage(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
