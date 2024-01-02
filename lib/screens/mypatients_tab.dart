import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medzone/widgets/text_widget.dart';

class MyPatients extends StatelessWidget {
  const MyPatients({super.key});

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
                      text: 'Patients',
                      fontSize: 24,
                      fontFamily: 'Bold',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Bookings')
                        .where('doctorid',
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .where('status', isEqualTo: 'Completed')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return const Center(child: Text('Error'));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Colors.black,
                          )),
                        );
                      }

                      final data = snapshot.requireData;
                      return SizedBox(
                        height: 500,
                        child: ListView.builder(
                          itemCount: data.docs.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: SizedBox(
                                height: 150,
                                width: 400,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                          text: data.docs[index]['myname'],
                                          fontSize: 14,
                                          fontFamily: 'Bold',
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        TextWidget(
                                          text: 'Messaging',
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
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
