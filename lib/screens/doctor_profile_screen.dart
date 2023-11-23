import 'package:flutter/material.dart';
import 'package:medzone/screens/book_screen.dart';
import 'package:medzone/utils/colors.dart';
import 'package:medzone/widgets/button_widget.dart';
import 'package:medzone/widgets/text_widget.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    TextWidget(
                      text: 'Dr. John Rivera',
                      fontSize: 16,
                      fontFamily: 'Bold',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: SizedBox(
                    height: 150,
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/doc1.png',
                          height: 100,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              text: 'Dr. John Rivera',
                              fontSize: 14,
                              fontFamily: 'Bold',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextWidget(
                              text: 'Neurologist',
                              fontSize: 12,
                              fontFamily: 'Regular',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextWidget(
                              text: 'October 25, 2023 at 5:30pm',
                              fontSize: 12,
                              fontFamily: 'Medium',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              text: 'Starts in 7 days',
                              fontSize: 12,
                              fontFamily: 'Medium',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primary.withOpacity(0.1),
                          ),
                          child: Icon(
                            Icons.star,
                            color: primary,
                          ),
                        ),
                        const SizedBox(
                          height: 2.5,
                        ),
                        TextWidget(
                          text: '4.5',
                          fontSize: 14,
                          fontFamily: 'Bold',
                        ),
                        const SizedBox(
                          height: 2.5,
                        ),
                        TextWidget(
                          text: 'Ratings',
                          fontSize: 10,
                          fontFamily: 'Regular',
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primary.withOpacity(0.1),
                          ),
                          child: Icon(
                            Icons.rate_review,
                            color: primary,
                          ),
                        ),
                        const SizedBox(
                          height: 2.5,
                        ),
                        TextWidget(
                          text: '50',
                          fontSize: 14,
                          fontFamily: 'Bold',
                        ),
                        const SizedBox(
                          height: 2.5,
                        ),
                        TextWidget(
                          text: 'Reviews',
                          fontSize: 10,
                          fontFamily: 'Regular',
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextWidget(
                  text: 'About Me',
                  fontSize: 18,
                  fontFamily: 'Bold',
                ),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                  align: TextAlign.start,
                  text:
                      'Ea do magna velit est ex. Ad ut magna ea aliqua consectetur proident qui do exercitation fugiat. Laborum nisi consequat reprehenderit aliqua. Incididunt sint eu ut eiusmod labore Lorem nisi anim sit non proident labore.',
                  fontSize: 12,
                  fontFamily: 'Regular',
                ),
                const SizedBox(
                  height: 10,
                ),
                TextWidget(
                  text: 'Working Time',
                  fontSize: 18,
                  fontFamily: 'Bold',
                ),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                  align: TextAlign.start,
                  text: 'Monday - Friday, 08:00AM - 05:00PM',
                  fontSize: 12,
                  fontFamily: 'Regular',
                ),
                const SizedBox(
                  height: 10,
                ),
                TextWidget(
                  text: 'Reviews',
                  fontSize: 18,
                  fontFamily: 'Bold',
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 200,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i = 0; i < 5; i++)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/profile.png',
                                    height: 45,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  TextWidget(
                                    text: 'John Doe',
                                    fontSize: 14,
                                    fontFamily: 'Bold',
                                  ),
                                  const Expanded(
                                    child: SizedBox(
                                      width: 20,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: primary.withOpacity(0.1),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: primary,
                                              ),
                                              TextWidget(
                                                text: '4.5',
                                                fontSize: 12,
                                                fontFamily: 'Bold',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextWidget(
                                align: TextAlign.start,
                                text:
                                    'Ea do magna velit est ex. Ad ut magna ea aliqua consectetur proident qui do exercitation fugiat. Laborum nisi consequat reprehenderit aliqua. Incididunt sint eu ut eiusmod labore Lorem nisi anim sit non proident labore.',
                                fontSize: 12,
                                fontFamily: 'Regular',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: TextWidget(
                                  align: TextAlign.end,
                                  text: '3 days ago',
                                  fontSize: 12,
                                  fontFamily: 'Bold',
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 0.5,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: ButtonWidget(
                    radius: 100,
                    label: 'Book an Appointment',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const BookScreen()));
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
