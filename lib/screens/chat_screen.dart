import 'package:flutter/material.dart';
import 'package:frist/models/messages.dart';
import 'package:frist/screens/signupscreen.dart';
import 'package:frist/widgets/customchatbubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();
  GlobalKey<FormState> formkey = GlobalKey();
  bool isloading = true;

  @override
  Widget build(BuildContext context) {
    var currentUserEmail = FirebaseAuth.instance.currentUser?.email;

    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messageslist = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageslist.add(Message.fromjson(snapshot.data!.docs[i]));
            }

            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  elevation: 4,
                  automaticallyImplyLeading: false,
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(children: [
                          Text(
                            "PingIt",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(width: 10),
                          Image.asset(
                            'assets/images/splash.png',
                            width: 32,
                          ),
                        ])
                      ]),
                  centerTitle: true,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 142, 107, 149),
                          Color.fromARGB(255, 133, 91, 136),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  actions: [
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'logout') {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()),
                            (route) => false,
                          );
                        }
                      },
                      icon: Icon(
                        Icons.list,
                        color: Colors.white,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          value: 'logout',
                          child: Row(
                            children: [
                              Icon(Icons.logout, color: Color(0xFF6A0572)),
                              SizedBox(width: 10),
                              Text('Logout',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                body: Stack(
                  children: [
                    
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFF8E8F9),
                            Color(0xFFF3C4F3),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            reverse: true,
                            controller: _controller,
                            itemCount: messageslist.length,
                            itemBuilder: (context, index) {
                              return messageslist[index].id == currentUserEmail
                                  ? chatbubble(
                                      massege: messageslist[index],
                                    )
                                  : chatbubbleforfriend(
                                      massege: messageslist[index],
                                    );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                )
                              ],
                            ),
                            child: TextField(
                              controller: controller,
                              onSubmitted: (data) {
                                if (currentUserEmail != null) {
                                  messages.add({
                                    'message': data,
                                    'createdAt': DateTime.now(),
                                    'id': currentUserEmail
                                  });
                                  controller.clear();
                                  _controller.animateTo(
                                    0,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeOut,
                                  );
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Type a message...',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.send,
                                    color: Color(0xFF6A0572),
                                  ),
                                  onPressed: () {
                                    if (currentUserEmail != null) {
                                      messages.add({
                                        'message': controller.text,
                                        'createdAt': DateTime.now(),
                                        'id': currentUserEmail
                                      });
                                      controller.clear();
                                      _controller.animateTo(
                                        0,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeOut,
                                      );
                                    }
                                  },
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return ModalProgressHUD(
              inAsyncCall: isloading,
              child: Scaffold(
                appBar: AppBar(
                  title: Text("PingIt"),
                  centerTitle: true,
                  backgroundColor: Color(0xFF6A0572),
                ),
                body: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF6A0572),
                  ),
                ),
              ),
            );
          }
        });
  }
}
