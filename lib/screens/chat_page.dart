import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/colors.dart';
import '../../widgets/text_widget.dart';
import 'messages_tab.dart';

class ChatPage extends StatefulWidget {
  final String userId;
  final String userName;

  const ChatPage({
    super.key,
    required this.userId,
    required this.userName,
  });
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
    getDriverData();
    getMyData();
  }

  final messageController = TextEditingController();

  String message = '';

  final ScrollController _scrollController = ScrollController();

  bool executed = true;

  bool hasLoaded = false;

  String userProfile = '';

  getDriverData() {
    FirebaseFirestore.instance
        .collection('Users')
        .where('userId', isEqualTo: widget.userId)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        setState(() {
          userProfile = doc['profilePicture'];
        });
      }
    });
  }

  String myProfile = '';

  getMyData() {
    FirebaseFirestore.instance
        .collection('Doctors')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        setState(() {
          myProfile = doc['profilePicture'];
          hasLoaded = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> chatData = FirebaseFirestore.instance
        .collection('Messages')
        .doc(widget.userId + FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          centerTitle: true,
          foregroundColor: grey,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                minRadius: 22,
                maxRadius: 22,
                backgroundImage: NetworkImage(userProfile),
              ),
              const SizedBox(
                width: 10,
              ),
              TextWidget(text: widget.userName, fontSize: 18, color: grey),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: hasLoaded
            ? SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<DocumentSnapshot>(
                        stream: chatData,
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(child: Text('Loading'));
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Text('Something went wrong'));
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          try {
                            dynamic data = snapshot.data;
                            List messages = data['messages'] ?? [];
                            return Expanded(
                              child: SizedBox(
                                child: ListView.builder(
                                    itemCount: messages.isNotEmpty
                                        ? messages.length
                                        : 0,
                                    controller: _scrollController,
                                    itemBuilder: ((context, index) {
                                      if (executed) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((timeStamp) {
                                          _scrollController.animateTo(
                                              _scrollController
                                                  .position.maxScrollExtent,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.easeOut);

                                          setState(() {
                                            executed = false;
                                          });
                                        });
                                      }
                                      return Row(
                                        mainAxisAlignment: messages[index]
                                                    ['sender'] ==
                                                FirebaseAuth
                                                    .instance.currentUser!.uid
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.start,
                                        children: [
                                          messages[index]['sender'] !=
                                                  FirebaseAuth
                                                      .instance.currentUser!.uid
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: CircleAvatar(
                                                    minRadius: 15,
                                                    maxRadius: 15,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            userProfile),
                                                  ))
                                              : const SizedBox(),
                                          Column(
                                            crossAxisAlignment: messages[index]
                                                        ['sender'] ==
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid
                                                ? CrossAxisAlignment.end
                                                : CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 10.0),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 15.0),
                                                decoration: BoxDecoration(
                                                  color: black,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        const Radius.circular(
                                                            20.0),
                                                    topRight:
                                                        const Radius.circular(
                                                            20.0),
                                                    bottomLeft: messages[index]
                                                                ['sender'] ==
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid
                                                        ? const Radius.circular(
                                                            20.0)
                                                        : const Radius.circular(
                                                            0.0),
                                                    bottomRight: messages[index]
                                                                ['sender'] ==
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid
                                                        ? const Radius.circular(
                                                            0.0)
                                                        : const Radius.circular(
                                                            20.0),
                                                  ),
                                                ),
                                                child: Text(
                                                  messages[index]['message'],
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                      fontFamily: 'QRegular'),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Text(
                                                  DateFormat.jm().format(
                                                      messages[index]
                                                              ['dateTime']
                                                          .toDate()),
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 11.0,
                                                      fontFamily: 'QRegular'),
                                                ),
                                              ),
                                            ],
                                          ),
                                          messages[index]['sender'] ==
                                                  FirebaseAuth
                                                      .instance.currentUser!.uid
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5),
                                                  child: CircleAvatar(
                                                    minRadius: 15,
                                                    maxRadius: 15,
                                                    backgroundImage:
                                                        NetworkImage(myProfile),
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      );
                                    })),
                              ),
                            );
                          } catch (e) {
                            return const Expanded(child: SizedBox());
                          }
                        }),
                    const Divider(
                      color: grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 45,
                              width: 240,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100)),
                              child: TextFormField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                controller: messageController,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(width: 1, color: grey),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  hintText: 'Type a message',
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  message = value;
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            MaterialButton(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              minWidth: 75,
                              height: 45,
                              color: Colors.green,
                              onPressed: (() async {
                                if (message != '') {
                                  try {
                                    await FirebaseFirestore.instance
                                        .collection('Messages')
                                        .doc(widget.userId +
                                            FirebaseAuth
                                                .instance.currentUser!.uid)
                                        .update({
                                      'lastMessage': messageController.text,
                                      'dateTime': DateTime.now(),
                                      'seen': false,
                                      'messages': FieldValue.arrayUnion([
                                        {
                                          'message': messageController.text,
                                          'dateTime': DateTime.now(),
                                          'sender': FirebaseAuth
                                              .instance.currentUser!.uid
                                        },
                                      ]),
                                    });
                                  } catch (e) {
                                    // addMessage(
                                    //     widget.userId,
                                    //     messageController.text,
                                    //     widget.userName);
                                  }
                                  _scrollController.animateTo(
                                      _scrollController
                                          .position.maxScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeOut);
                                  messageController.clear();
                                  message = '';
                                }
                              }),
                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    final shouldPop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit this conversation?'),
        actions: <Widget>[
          MaterialButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: TextWidget(text: 'No', fontSize: 12, color: grey),
          ),
          MaterialButton(
            onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MessagesTab())),
            child: TextWidget(text: 'Yes', fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );

    return shouldPop ?? false;
  }
}
