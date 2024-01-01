import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medzone/screens/auth/signup_screen3.dart';
import 'package:medzone/utils/colors.dart';
import 'package:medzone/widgets/button_widget.dart';
import 'package:medzone/widgets/text_widget.dart';
import 'package:medzone/widgets/textfield_widget.dart';

class SignupScreen2 extends StatefulWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  SignupScreen2({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<SignupScreen2> createState() => _SignupScreen2State();
}

class _SignupScreen2State extends State<SignupScreen2> {
  final firstnameController = TextEditingController();
  final middlenameController = TextEditingController();
  final lastnameController = TextEditingController();
  final dateController = TextEditingController();
  final nicknameController = TextEditingController();
  final suffixController = TextEditingController();
  var aboutmeController = TextEditingController();

  final numberController = TextEditingController();

  String selectedSex = 'Male';
  String selectedGender = 'Male';

  final List<String> sexList = ['Male', 'Female', 'Other'];
  final List<String> genderList = ['Male', 'Female', 'Non-binary', 'Other'];

  String type = 'General';

  final List<String> types = [
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
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    TextWidget(
                      text: 'Personal Information',
                      fontSize: 16,
                      fontFamily: 'Bold',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/profile.png',
                    width: 100,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: TextFieldWidget(
                    label: 'First Name',
                    hintColor: Colors.black,
                    controller: firstnameController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: TextFieldWidget(
                    label: 'Middle Name',
                    hintColor: Colors.black,
                    controller: middlenameController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: TextFieldWidget(
                    label: 'Last Name',
                    hintColor: Colors.black,
                    controller: lastnameController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: TextFieldWidget(
                    label: 'Nickname',
                    hintColor: Colors.black,
                    controller: nicknameController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: TextFieldWidget(
                    label: 'Mobile Number',
                    hintColor: Colors.black,
                    controller: numberController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: TextFieldWidget(
                    label: 'About Me',
                    hintColor: Colors.black,
                    controller: aboutmeController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: TextFieldWidget(
                    label: 'Suffix (Jr., I, II, III, Sr.)',
                    hintColor: Colors.black,
                    controller: suffixController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'Specialty:',
                          fontSize: 14,
                        ),
                        DropdownButton<String>(
                          value: type,
                          onChanged: (newValue) {
                            setState(() {
                              type = newValue!;
                            });
                          },
                          items:
                              types.map<DropdownMenuItem<String>>((String sex) {
                            return DropdownMenuItem<String>(
                              value: sex,
                              child: Text(sex),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Birthday',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Bold',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Bold',
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          dateFromPicker(context);
                        },
                        child: SizedBox(
                          width: 325,
                          height: 50,
                          child: TextFormField(
                            enabled: false,
                            style: TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: primary,
                            ),

                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.calendar_month_outlined,
                                color: primary,
                              ),
                              hintStyle: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              hintText: dateController.text,
                              border: InputBorder.none,
                              disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              errorStyle: const TextStyle(
                                  fontFamily: 'Bold', fontSize: 12),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),

                            controller: dateController,
                            // Pass the validator to the TextFormField
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Sex Dropdown
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'Sex',
                          fontSize: 14,
                        ),
                        DropdownButton<String>(
                          value: selectedSex,
                          onChanged: (newValue) {
                            setState(() {
                              selectedSex = newValue!;
                            });
                          },
                          items: sexList
                              .map<DropdownMenuItem<String>>((String sex) {
                            return DropdownMenuItem<String>(
                              value: sex,
                              child: Text(sex),
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                    // Spacer to create space between the dropdowns
                    const SizedBox(width: 16),

                    // Gender Dropdown
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'Gender',
                          fontSize: 14,
                        ),
                        DropdownButton<String>(
                          value: selectedGender,
                          onChanged: (newValue) {
                            setState(() {
                              selectedGender = newValue!;
                            });
                          },
                          items: genderList
                              .map<DropdownMenuItem<String>>((String gender) {
                            return DropdownMenuItem<String>(
                              value: gender,
                              child: Text(gender),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ButtonWidget(
                    label: 'Next',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignupScreen3(
                              numberController: numberController,
                              type: type,
                              aboutmeController: aboutmeController,
                              emailController: widget.emailController,
                              passwordController: widget.passwordController,
                              firstnameController: firstnameController,
                              middlenameController: middlenameController,
                              lastnameController: lastnameController,
                              nicknameController: nicknameController,
                              suffixController: suffixController,
                              dateController: dateController,
                              selectedSex: selectedSex,
                              selectedGender: selectedGender)));
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void dateFromPicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: primary,
                onPrimary: Colors.white,
                onSurface: Colors.grey,
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      setState(() {
        dateController.text = formattedDate;
      });
    } else {
      return null;
    }
  }
}
