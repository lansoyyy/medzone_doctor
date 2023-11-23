import 'package:flutter/material.dart';
import 'package:medzone/screens/doctor_profile_screen.dart';
import 'package:medzone/utils/colors.dart';
import 'package:medzone/widgets/text_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final searchController = TextEditingController();
  String nameSearched = '';

  List<String> selectedStatus = [
    'All',
    'General',
    'Nutritionist',
    'Dentist',
    'Neurologist',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'Hello Doctor!',
                          fontSize: 18,
                          fontFamily: 'Bold',
                        ),
                        TextWidget(
                          text: 'Keep taking care of your health',
                          fontSize: 10,
                          fontFamily: 'Regular',
                        ),
                      ],
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_sharp,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(100)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Regular',
                          fontSize: 14),
                      onChanged: (value) {
                        setState(() {
                          nameSearched = value;
                        });
                      },
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          hintText: 'Search',
                          hintStyle: TextStyle(fontFamily: 'QRegular'),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          )),
                      controller: searchController,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextWidget(
                  text: 'Popular doctors',
                  fontSize: 14,
                  fontFamily: 'Bold',
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: selectedStatus.map((String status) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FilterChip(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          showCheckmark: false,
                          backgroundColor: const Color(0xFFC6C6C6),
                          disabledColor: Colors.grey,
                          selectedColor: primary,
                          label: TextWidget(
                            text: status,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          selected: selectedStatus.contains(status),
                          onSelected: (bool selected) {
                            setState(
                              () {
                                if (selected) {
                                  selectedStatus
                                      .add(status); // Update the temporary list
                                } else {
                                  // selectedStatus
                                  //     .remove(status); // Update the temporary list
                                }
                              },
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < 10; i++)
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const DoctorProfileScreen()));
                            },
                            child: Container(
                              height: 175,
                              width: 125,
                              decoration: BoxDecoration(
                                color: primary.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/doc1.png',
                                    width: 75,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextWidget(
                                    text: '☆ 5.0',
                                    fontSize: 10,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextWidget(
                                    text: 'Dr. John Rivera',
                                    fontSize: 12,
                                    fontFamily: 'Bold',
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextWidget(
                                    text: 'Neurologist',
                                    fontSize: 12,
                                    fontFamily: 'Medium',
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextWidget(
                  text: 'Upcoming Appointments',
                  fontSize: 14,
                  fontFamily: 'Bold',
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Container(
                          height: 150,
                          width: 125,
                          decoration: BoxDecoration(
                            color: primary.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(15),
                          ),
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
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
