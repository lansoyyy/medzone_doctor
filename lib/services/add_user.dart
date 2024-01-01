import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addUser(email, fname, mname, lname, nname, suffix, bday, sex, gender,
    aboutme, type, number) async {
  final docUser = FirebaseFirestore.instance
      .collection('Doctors')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final json = {
    'email': email,
    'fname': fname,
    'mname': mname,
    'lname': lname,
    'nname': nname,
    'suffix': suffix,
    'bday': bday,
    'sex': sex,
    'gender': gender,
    'profilePicture': 'https://cdn-icons-png.flaticon.com/256/149/149071.png',
    'status': 'Active',
    'userId': FirebaseAuth.instance.currentUser!.uid,
    'reviews': [],
    'stars': 0,
    'aboutme': aboutme,
    'type': type,
    'number': number
  };

  await docUser.set(json);
}
