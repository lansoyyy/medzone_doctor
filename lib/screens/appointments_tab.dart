import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medzone/widgets/button_widget.dart';
import 'package:medzone/widgets/text_widget.dart';

import 'chat_page.dart';

class AppointmentsTab extends StatelessWidget {
  const AppointmentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Appointments',
                      fontSize: 24,
                      fontFamily: 'Bold',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const TabBar(
                  tabs: [
                    Tab(
                      text: 'Upcoming',
                    ),
                    Tab(
                      text: 'Completed',
                    ),
                    Tab(
                      text: 'Cancelled',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 500,
                  child: TabBarView(
                    children: [
                      for (int i = 0; i < 3; i++)
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Bookings')
                                .where('doctorid',
                                    isEqualTo:
                                        FirebaseAuth.instance.currentUser!.uid)
                                .where('status',
                                    isEqualTo: i == 0
                                        ? 'Pending'
                                        : i == 1
                                            ? 'Completed'
                                            : 'Cancelled')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                print(snapshot.error);
                                return const Center(child: Text('Error'));
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Padding(
                                  padding: EdgeInsets.only(top: 50),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.black,
                                  )),
                                );
                              }

                              final data = snapshot.requireData;
                              return ListView.builder(
                                itemCount: data.docs.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: SizedBox(
                                      height: 150,
                                      width: 400,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/profile.png',
                                            height: 100,
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextWidget(
                                                text: data.docs[index]
                                                    ['myname'],
                                                fontSize: 14,
                                                fontFamily: 'Bold',
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              TextWidget(
                                                text:
                                                    '"${data.docs[index]['problem']}"',
                                                fontSize: 12,
                                                fontFamily: 'Regular',
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              TextWidget(
                                                text:
                                                    '${data.docs[index]['date']} at ${data.docs[index]['time']}',
                                                fontSize: 12,
                                                fontFamily: 'Medium',
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              i == 0
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        ButtonWidget(
                                                          radius: 100,
                                                          width: 75,
                                                          height: 30,
                                                          fontSize: 12,
                                                          label: 'Accept',
                                                          onPressed: () async {
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Bookings')
                                                                .doc(data
                                                                    .docs[index]
                                                                    .id)
                                                                .update({
                                                              'status':
                                                                  'Completed'
                                                            });
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ChatPage(
                                                                              userId: data.docs[index]['userId'],
                                                                              userName: data.docs[index]['myname'] ?? 'User name',
                                                                            )));
                                                          },
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        ButtonWidget(
                                                          color: Colors.red,
                                                          radius: 100,
                                                          width: 75,
                                                          height: 30,
                                                          fontSize: 12,
                                                          label: 'Reject',
                                                          onPressed: () async {
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Bookings')
                                                                .doc(data
                                                                    .docs[index]
                                                                    .id)
                                                                .update({
                                                              'status':
                                                                  'Cancelled'
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
