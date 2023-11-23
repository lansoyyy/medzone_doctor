import 'package:flutter/material.dart';

import 'package:medzone/widgets/text_widget.dart';

class MessagesTab extends StatefulWidget {
  const MessagesTab({super.key});

  @override
  State<MessagesTab> createState() => _MessagesTabState();
}

class _MessagesTabState extends State<MessagesTab> {
  final messageController = TextEditingController();

  String filter = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'Message',
                    fontSize: 24,
                    fontFamily: 'Bold',
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SizedBox(
                  child: ListView.builder(
                      itemCount: 50,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: ListTile(
                            onTap: () async {
                              // await FirebaseFirestore.instance
                              //     .collection('Messages')
                              //     .doc(data.docs[index].id)
                              //     .update({'seen': true});
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => ChatPage(
                              //           userId: data.docs[index]['userId'],
                              //           userName: data.docs[index]
                              //                   ['userName'] ??
                              //               'User name',
                              //         )));
                            },
                            leading: const CircleAvatar(
                              maxRadius: 25,
                              minRadius: 25,
                              backgroundImage: NetworkImage(''),
                              child: Icon(
                                Icons.person,
                                color: Colors.black,
                                size: 35,
                              ),
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                    text: 'John Doe',
                                    fontSize: 15,
                                    fontFamily: 'Bold',
                                    color: Colors.black),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Message here',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontFamily: 'QBold'),
                                    ),
                                    TextWidget(
                                        text: '11/23/2023',
                                        fontSize: 12,
                                        color: Colors.black),
                                  ],
                                ),
                              ],
                            ),
                            trailing: const Icon(
                              Icons.arrow_right,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      })),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
