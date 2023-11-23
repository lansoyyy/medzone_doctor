import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medzone/screens/auth/login_screen.dart';
import 'package:medzone/utils/colors.dart';
import 'package:medzone/widgets/button_widget.dart';
import 'package:medzone/widgets/text_widget.dart';
import 'package:medzone/widgets/textfield_widget.dart';

class SignupScreen3 extends StatefulWidget {
  var firstnameController = TextEditingController();
  var middlenameController = TextEditingController();
  var lastnameController = TextEditingController();
  var nicknameController = TextEditingController();
  var suffixController = TextEditingController();
  var dateController = TextEditingController();

  String selectedSex = 'Male';
  String selectedGender = 'Male';

  SignupScreen3(
      {super.key,
      required this.firstnameController,
      required this.middlenameController,
      required this.lastnameController,
      required this.nicknameController,
      required this.suffixController,
      required this.dateController,
      required this.selectedSex,
      required this.selectedGender});

  @override
  State<SignupScreen3> createState() => _SignupScreen3State();
}

class _SignupScreen3State extends State<SignupScreen3> {
  final List<String> sexList = ['Male', 'Female', 'Other'];
  final List<String> genderList = ['Male', 'Female', 'Non-binary', 'Other'];

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
                      text: 'Review Personal Information',
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
                    isEnabled: false,
                    label: 'First Name',
                    hintColor: Colors.black,
                    controller: widget.firstnameController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: TextFieldWidget(
                    isEnabled: false,
                    label: 'Middle Name',
                    hintColor: Colors.black,
                    controller: widget.middlenameController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: TextFieldWidget(
                    isEnabled: false,
                    label: 'Last Name',
                    hintColor: Colors.black,
                    controller: widget.lastnameController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: TextFieldWidget(
                    isEnabled: false,
                    label: 'Nickname',
                    hintColor: Colors.black,
                    controller: widget.nicknameController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: TextFieldWidget(
                    isEnabled: false,
                    label: 'Suffix (Jr., I, II, III, Sr.)',
                    hintColor: Colors.black,
                    controller: widget.suffixController,
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
                              hintText: widget.dateController.text,
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

                            controller: widget.dateController,
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
                          value: widget.selectedSex,
                          onChanged: (newValue) {
                            setState(() {
                              widget.selectedSex = newValue!;
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
                          value: widget.selectedGender,
                          onChanged: (newValue) {
                            setState(() {
                              widget.selectedGender = newValue!;
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
                    label: 'Go back and edit',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ButtonWidget(
                    label: 'Signup',
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
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
        widget.dateController.text = formattedDate;
      });
    } else {
      return null;
    }
  }
}
