import 'dart:io';

import 'package:aiquaboost/constants.dart';
import 'package:aiquaboost/data/user_data_managing.dart';
import 'package:aiquaboost/domain/user_info_data.dart';
import 'package:aiquaboost/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import './components/componentes_welcome_title.dart';
import './components/users_logistics.dart';

class UpdateProfile extends StatefulWidget {
  static const id = 'update_profile';
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  bool isUploadedImage = false;
  bool _clickedUserPhotoUpload = false;
  XFile? _userImage;

  Map<String, TextEditingController> userPersonalInfoController = {
    'full_name': TextEditingController(),
    'email': TextEditingController(),
    'phone_number': TextEditingController(),
    'preference': TextEditingController(),
    'role': TextEditingController(),
    'age': TextEditingController(),
  };
  Map<String, TextEditingController> academicController = {
    'institute': TextEditingController(),
    'degree_or_exam': TextEditingController(),
    'grade_or_marks': TextEditingController(),
    'passing_year': TextEditingController(),
  };
  Map<String, TextEditingController> experienceController = {
    'designation': TextEditingController(),
    'institute': TextEditingController(),
    'location': TextEditingController(),
    'joining_date': TextEditingController(),
    'last_date_of_this_office': TextEditingController(),
  };
  Map<String, TextEditingController> addressController = {
    'house': TextEditingController(),
    'road': TextEditingController(),
    'village_or_town': TextEditingController(),
    'upzilla_or_thana': TextEditingController(),
    'district': TextEditingController(),
    'division': TextEditingController(),
  };

  var userInputsList = {
    'full_name': '',
    'email': '',
    'phone_number': '',
    'preference': '',
    'role': '',
    'age': '',
    'user_profile_photo': '',
  };
  var storedInputsList = {
    'full_name': '',
    'email': '',
    'phone_number': '',
    'preference': '',
    'role': '',
    'age': '',
    'user_profile_photo': '',
  };
  Map<String, dynamic> addressMap = {};
  Map<String, dynamic> academicMap = {};
  Map<String, dynamic> experienceMap = {};
  List<Map<String, String>> userAddressLists = [];

  List<Map<String, String>> userAcademicLists = [];

  List<Map<String, String>> userExperienceLists = [];

  @override
  void initState() {
    storedInputsList['full_name'] = Profile.userInfoData!.full_name;
    storedInputsList['email'] = Profile.userInfoData!.email;
    storedInputsList['phone_number'] =
        '+88' + Profile.userInfoData!.phone_number;
    storedInputsList['role'] = Profile.userInfoData!.role;
    storedInputsList['age'] = Profile.userInfoData!.age;
    storedInputsList['preference'] = Profile.userInfoData!.preference;
    storedInputsList['user_profile_photo'] =
        Profile.userInfoData!.user_profile_photo;
    userAcademicLists = Profile.userAcademicData!;
    userExperienceLists = Profile.userExperienceData!;
    userAddressLists = Profile.userAddressData!;

    print(userAcademicLists);
    print(userExperienceLists);
    print(userAddressLists);
    super.initState();
  }

  Widget addressWidget({
    required int addressNumber,
    required String house,
    required String road,
    required String village,
    required String upzilla,
    required String district,
    required String division,
  }) {
    return Row(
      children: <Widget>[
        Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    print('deleting: ${addressNumber}');
                  },
                  icon: Icon(Icons.delete_forever),
                  color: Colors.red,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.check),
                  color: Colors.green,
                ),
              ],
            )
          ],
        ),
        sizedBoxH10,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "House:  ",
                    style: TextStyle(
                      fontSize: 18,
                      color: kPrimaryBlueColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${house}",
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 19,
                        color: kPrimaryBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Road:  ",
                    style: TextStyle(
                      fontSize: 18,
                      color: kPrimaryBlueColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      " ${road}",
                      style: TextStyle(
                        fontSize: 19,
                        color: kPrimaryBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Village:  ",
                    style: TextStyle(
                      fontSize: 18,
                      color: kPrimaryBlueColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      " ${village}",
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 19,
                        color: kPrimaryBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Upzilla:  ",
                    style: TextStyle(
                      fontSize: 18,
                      color: kPrimaryBlueColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      " ${upzilla}",
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 19,
                        color: kPrimaryBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "District:  ",
                    style: TextStyle(
                      fontSize: 18,
                      color: kPrimaryBlueColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      " ${district}",
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 19,
                        color: kPrimaryBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Division:  ",
                    style: TextStyle(
                      fontSize: 18,
                      color: kPrimaryBlueColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      " ${division}",
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 19,
                        color: kPrimaryBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 150,
                height: 3,
                color: kPrimaryBlueColor,
              ),
              sizedBoxH20,
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> addressWidgetList = [];

  Widget addressComponent({required List addressLists}) {
    addressWidgetList.clear();
    if (addressLists.length == 0) {
      return Column();
    } else {
      for (int i = 0; i < addressLists.length; i++) {
        print(addressLists[i]['house']);
        addressWidgetList.add(addressWidget(
          addressNumber: i,
          house: addressLists[i]['house'],
          road: addressLists[i]['road'],
          village: addressLists[i]['village_or_town'],
          upzilla: addressLists[i]['upzilla_or_thana'],
          district: addressLists[i]['district'],
          division: addressLists[i]['division'],
        ));
      }
      return Column(
        children: addressWidgetList,
      );
    }
  }

  Widget academicWidget({
    required int academicNumber,
    required String institute,
    required String degree_or_exam,
    required String grade_or_mark,
    required String passing_year,
  }) {
    return Row(
      children: <Widget>[
        Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    print('deleting: ${academicNumber}');
                  },
                  icon: Icon(Icons.delete_forever),
                  color: Colors.red,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.check),
                  color: Colors.green,
                ),
              ],
            )
          ],
        ),
        sizedBoxH10,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Institute:  ",
                    style: TextStyle(
                      fontSize: 18,
                      color: kPrimaryBlueColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${institute}",
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 19,
                        color: kPrimaryBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Degree/Exam:  ",
                    style: TextStyle(
                      fontSize: 18,
                      color: kPrimaryBlueColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      " ${degree_or_exam}",
                      style: TextStyle(
                        fontSize: 19,
                        color: kPrimaryBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Grade/Mark:",
                    style: TextStyle(
                      fontSize: 18,
                      color: kPrimaryBlueColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      " ${grade_or_mark}",
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 19,
                        color: kPrimaryBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Passing year:",
                    style: TextStyle(
                      fontSize: 18,
                      color: kPrimaryBlueColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      " ${passing_year}",
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 19,
                        color: kPrimaryBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 150,
                height: 3,
                color: kPrimaryBlueColor,
              ),
              sizedBoxH20,
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> academicWidgetList = [];
  Widget academicComponent({required List academicLists}) {
    academicWidgetList.clear();
    if (academicLists.length == 0) {
      return Column();
    } else {
      for (int i = 0; i < academicLists.length; i++) {
        print(academicLists[i]['institute']);
        academicWidgetList.add(
          academicWidget(
            academicNumber: i,
            institute: academicLists[i]['institute'],
            degree_or_exam: academicLists[i]['degree_or_exam'],
            grade_or_mark: academicLists[i]['grade_or_marks'],
            passing_year: academicLists[i]['passing_year'],
          ),
        );
      }
      return Column(
        children: academicWidgetList,
      );
    }
  }

  Widget experienceWidget({
    required int experienceNumber,
    required String designation,
    required String institute,
    required String location,
    required String joining_date,
    required String last_date_of_this_office,
  }) {
    return Row(
      children: <Widget>[
        Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    print('deleting: ${experienceNumber}');
                  },
                  icon: Icon(Icons.delete_forever),
                  color: Colors.red,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.check),
                  color: Colors.green,
                ),
              ],
            )
          ],
        ),
        sizedBoxH10,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Designation:  ',
                    style: TextStyle(
                      fontSize: 18,
                      color: kPrimaryBlueColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${designation} ",
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 19,
                        color: kPrimaryBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Institute:  ",
                    style: TextStyle(
                      fontSize: 18,
                      color: kPrimaryBlueColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      " ${institute}",
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 19,
                        color: kPrimaryBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Location:  ",
                    style: TextStyle(
                      fontSize: 18,
                      color: kPrimaryBlueColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      " ${location}",
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 19,
                        color: kPrimaryBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Joining Date:  ",
                    style: TextStyle(
                      fontSize: 18,
                      color: kPrimaryBlueColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      " ${joining_date}",
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 19,
                        color: kPrimaryBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Last Date Of This Office:  ",
                    style: TextStyle(
                      fontSize: 18,
                      color: kPrimaryBlueColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      " ${last_date_of_this_office}",
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 19,
                        color: kPrimaryBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 150,
                height: 3,
                color: kPrimaryBlueColor,
              )
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> experienceWidgetLists = [];
  Widget experienceComponent({required List experienceLists}) {
    experienceWidgetLists.clear();
    if (experienceLists.length != 0) {
      for (int i = 0; i < experienceLists.length; i++) {
        print(experienceLists[i]['institute']);
        experienceWidgetLists.add(
          experienceWidget(
              experienceNumber: i,
              designation: experienceLists[i]['designation'],
              institute: experienceLists[i]['institute'],
              location: experienceLists[i]['location'],
              joining_date: experienceLists[i]['joining_date'],
              last_date_of_this_office: experienceLists[i]
                  ['last_date_of_this_office']),
        );
      }
      return Column(
        children: experienceWidgetLists,
      );
    } else {
      return Column();
    }
  }

  void clearTextEditingController(
      {int? personal, int? address, int? academic, int? experience}) {
    if (personal == 1) {
      userPersonalInfoController['full_name']!.clear();
      userPersonalInfoController['email']!.clear();
      userPersonalInfoController['phone_number']!.clear();
      userPersonalInfoController['preference']!.clear();
      userPersonalInfoController['role']!.clear();
      userPersonalInfoController['age']!.clear();
    }
    if (address == 1) {
      addressController['house']!.clear();
      addressController['road']!.clear();
      addressController['village_or_town']!.clear();
      addressController['upzilla_or_thana']!.clear();
      addressController['district']!.clear();
      addressController['division']!.clear();
    }

    if (academic == 1) {
      academicController['institute']!.clear();
      academicController['grade_or_marks']!.clear();
      academicController['degree_or_exam']!.clear();
      academicController['passing_year']!.clear();
    }
    if (experience == 1) {
      experienceController['designation']!.clear();
      experienceController['institute']!.clear();
      experienceController['location']!.clear();
      experienceController['joining_date']!.clear();
      experienceController['last_date_of_this_office']!.clear();
    }
  }

  Widget inputWithIcon({
    required String hintText,
    required IconData iconData,
    required VoidCallback onPressedAction,
    required String fieldName,
    required bool textFieldOrNot,
    required String AddressOrExpOrAcademic,
  }) {
    TextEditingController controller = TextEditingController();
    if (AddressOrExpOrAcademic == 'person') {
      controller = userPersonalInfoController[fieldName]!;
    } else if (AddressOrExpOrAcademic == 'AD') {
      controller = addressController[fieldName]!;
    } else if (AddressOrExpOrAcademic == 'EX') {
      controller = experienceController[fieldName]!;
    } else if (AddressOrExpOrAcademic == 'AC') {
      controller = academicController[fieldName]!;
    }
    return Padding(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
        ),
        child: TextField(
          style: const TextStyle(fontSize: 18, fontFamily: 'Arial'),
          controller: controller,
          decoration: InputDecoration(
              prefixIcon: Icon(iconData), hintText: "${hintText}"),
          onChanged: (value) {
            if (AddressOrExpOrAcademic == 'person') {
              userInputsList[fieldName] = value;
            } else if (AddressOrExpOrAcademic == 'AD') {
              addressMap[fieldName] = value;
            } else if (AddressOrExpOrAcademic == 'EX') {
              experienceMap[fieldName] = value;
            } else if (AddressOrExpOrAcademic == 'AC') {
              academicMap[fieldName] = value;
            }
          },
          onTap: () {},
        ));
  }

  final ImagePicker picker = ImagePicker();
  Future getImage(ImageSource media) async {
    var image = await picker.pickImage(source: media);
    setState(() {
      if (image != null) {
        _clickedUserPhotoUpload = true;
        _userImage = image;
        isUploadedImage = true;
        userInputsList['user_profile_photo'] = _userImage!.path;
      }
    });
  }

  void imagePickingAlertBox() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromRGBO(2, 62, 138, 1),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            title: const Text(
              "Please choose a media",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                      print("Why it failed? ");
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(2, 62, 138, 1),
          leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
          title: appBarTitle(title: 'Update Profile'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              sizedBoxH50,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(250, 250),
                    maximumSize: Size(250, 250),
                    backgroundColor: Color.fromRGBO(239, 239, 239, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ) // Set the background color
                    ),
                onPressed: () {
                  imagePickingAlertBox();
                },
                child: _clickedUserPhotoUpload
                    ? Image.file(
                        File(_userImage!.path),
                        fit: BoxFit.contain,
                      )
                    : const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.add,
                              size: 50,
                              weight: 900,
                              color: Color.fromRGBO(2, 62, 138, 1),
                            ),
                            Text(
                              "Add Your\nPhoto", // Use \n to break the text into 2 lines
                              softWrap: true,
                              textAlign:
                                  TextAlign.center, // Center-align the text
                              style: TextStyle(
                                color: Color.fromRGBO(2, 62, 138, 1),
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              sizedBoxH20,
              inputWithIcon(
                fieldName: 'full_name',
                hintText: 'Full Name',
                iconData: Icons.person,
                onPressedAction: () {},
                textFieldOrNot: true,
                AddressOrExpOrAcademic: 'person',
              ),
              sizedBoxH20,
              inputWithIcon(
                fieldName: 'email',
                hintText: 'Email',
                iconData: Icons.email_outlined,
                onPressedAction: () {},
                textFieldOrNot: true,
                AddressOrExpOrAcademic: 'person',
              ),
              sizedBoxH20,
              inputWithIcon(
                fieldName: 'phone_number',
                hintText: 'Phone Number',
                iconData: Icons.call_outlined,
                onPressedAction: () {},
                textFieldOrNot: true,
                AddressOrExpOrAcademic: 'person',
              ),
              sizedBoxH20,
              inputWithIcon(
                fieldName: 'age',
                hintText: 'Age',
                iconData: Icons.date_range,
                onPressedAction: () {},
                textFieldOrNot: true,
                AddressOrExpOrAcademic: 'person',
              ),
              sizedBoxH20,
              inputWithIcon(
                fieldName: 'preference',
                hintText: 'Preference',
                iconData: Icons.language_outlined,
                onPressedAction: () {},
                textFieldOrNot: true,
                AddressOrExpOrAcademic: 'person',
              ),
              sizedBoxH20,
              inputWithIcon(
                fieldName: 'role',
                hintText: 'Role',
                iconData: Icons.person_2_outlined,
                onPressedAction: () {},
                textFieldOrNot: true,
                AddressOrExpOrAcademic: 'person',
              ),
              sizedBoxH10,
              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 51, 204, 255), width: 1),
                      borderRadius: BorderRadius.circular(5),
                      shape: BoxShape.rectangle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        sizedBoxH30,
                        academicComponent(academicLists: userAcademicLists),
                        inputWithIcon(
                          hintText: 'Institute',
                          iconData: Icons.school,
                          onPressedAction: () {},
                          fieldName: 'institute',
                          textFieldOrNot: true,
                          AddressOrExpOrAcademic: 'AC',
                        ),
                        inputWithIcon(
                          hintText: 'Degree/Exam',
                          iconData: Icons.school_outlined,
                          onPressedAction: () {},
                          fieldName: 'degree_or_exam',
                          textFieldOrNot: true,
                          AddressOrExpOrAcademic: 'AC',
                        ),
                        inputWithIcon(
                          hintText: 'Grade/Mark',
                          iconData: Icons.holiday_village_outlined,
                          onPressedAction: () {},
                          fieldName: 'grade_or_marks',
                          textFieldOrNot: true,
                          AddressOrExpOrAcademic: 'AC',
                        ),
                        inputWithIcon(
                          hintText: 'Passing year',
                          iconData: Icons.add,
                          onPressedAction: () {},
                          fieldName: 'passing_year',
                          textFieldOrNot: true,
                          AddressOrExpOrAcademic: 'AC',
                        ),
                        sizedBoxH20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                academicMap.clear();

                                clearTextEditingController(
                                    personal: 0,
                                    address: 0,
                                    academic: 1,
                                    experience: 0);
                              },
                              child: const Column(
                                children: [
                                  Text(
                                    "Discard",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.red),
                                  ),
                                  Icon(
                                    Icons.cancel_outlined,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            MaterialButton(
                              onPressed: () {
                                Map<String, String> copiedAcademic =
                                    Map.from(academicMap);
                                // Add the copied map to the userExperienceLists
                                setState(() {
                                  userAcademicLists.add(copiedAcademic);
                                });
                                academicMap.clear();

                                clearTextEditingController(
                                    personal: 0,
                                    address: 0,
                                    academic: 1,
                                    experience: 0);
                              },
                              child: const Column(
                                children: [
                                  Text(
                                    "Save",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.green),
                                  ),
                                  Icon(
                                    Icons.check,
                                    size: 30,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 50,
                    top: 12,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                      color: Colors.white,
                      child: const Text(
                        'Academic',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              sizedBoxH10,
              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 51, 204, 255), width: 1),
                      borderRadius: BorderRadius.circular(5),
                      shape: BoxShape.rectangle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        sizedBoxH30,
                        experienceComponent(
                            experienceLists: userExperienceLists),
                        inputWithIcon(
                          hintText: 'Designation',
                          iconData: Icons.account_box_outlined,
                          onPressedAction: () {},
                          fieldName: 'designation',
                          textFieldOrNot: true,
                          AddressOrExpOrAcademic: 'EX',
                        ),
                        inputWithIcon(
                          hintText: 'Institute',
                          iconData: Icons.home_outlined,
                          onPressedAction: () {},
                          fieldName: 'institute',
                          textFieldOrNot: true,
                          AddressOrExpOrAcademic: 'EX',
                        ),
                        inputWithIcon(
                          hintText: 'Location',
                          iconData: Icons.location_city,
                          onPressedAction: () {},
                          fieldName: 'location',
                          textFieldOrNot: true,
                          AddressOrExpOrAcademic: 'EX',
                        ),
                        inputWithIcon(
                          hintText: 'Joining Date',
                          iconData: Icons.date_range,
                          onPressedAction: () {},
                          fieldName: 'joining_date',
                          textFieldOrNot: true,
                          AddressOrExpOrAcademic: 'EX',
                        ),
                        inputWithIcon(
                          hintText: 'Last Date Of This Office',
                          iconData: Icons.date_range,
                          onPressedAction: () {},
                          fieldName: 'last_date_of_this_office',
                          textFieldOrNot: true,
                          AddressOrExpOrAcademic: 'EX',
                        ),
                        sizedBoxH20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                experienceMap.clear();
                                clearTextEditingController(
                                    personal: 0,
                                    address: 0,
                                    academic: 0,
                                    experience: 1);
                              },
                              child: const Column(
                                children: [
                                  Text(
                                    "Discard",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.red),
                                  ),
                                  Icon(
                                    Icons.cancel_outlined,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            MaterialButton(
                              onPressed: () {
                                Map<String, String> copiedExperienceMap =
                                    Map.from(experienceMap);
                                setState(() {
                                  userExperienceLists.add(copiedExperienceMap);
                                });
                                experienceMap.clear();
                                clearTextEditingController(
                                    personal: 0,
                                    address: 0,
                                    academic: 0,
                                    experience: 1);
                              },
                              child: const Column(
                                children: [
                                  Text(
                                    "Save",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.green),
                                  ),
                                  Icon(
                                    Icons.check,
                                    size: 30,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 50,
                    top: 12,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                      color: Colors.white,
                      child: const Text(
                        'Experience',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              sizedBoxH10,
              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 51, 204, 255), width: 1),
                      borderRadius: BorderRadius.circular(5),
                      shape: BoxShape.rectangle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        sizedBoxH30,
                        addressComponent(addressLists: userAddressLists),
                        sizedBoxH30,
                        inputWithIcon(
                          hintText: 'House',
                          iconData: Icons.home_outlined,
                          onPressedAction: () {},
                          fieldName: 'house',
                          textFieldOrNot: true,
                          AddressOrExpOrAcademic: 'AD',
                        ),
                        inputWithIcon(
                          hintText: 'Road',
                          iconData: Icons.add_road,
                          onPressedAction: () {},
                          fieldName: 'road',
                          textFieldOrNot: true,
                          AddressOrExpOrAcademic: 'AD',
                        ),
                        inputWithIcon(
                          hintText: 'Village/Town',
                          iconData: Icons.holiday_village_outlined,
                          onPressedAction: () {},
                          fieldName: 'village_or_town',
                          textFieldOrNot: true,
                          AddressOrExpOrAcademic: 'AD',
                        ),
                        inputWithIcon(
                          hintText: 'Upzilla/Thana',
                          iconData: Icons.add,
                          onPressedAction: () {},
                          fieldName: 'upzilla_or_thana',
                          textFieldOrNot: true,
                          AddressOrExpOrAcademic: 'AD',
                        ),
                        inputWithIcon(
                          hintText: 'District',
                          iconData: Icons.add,
                          onPressedAction: () {},
                          fieldName: 'district',
                          textFieldOrNot: true,
                          AddressOrExpOrAcademic: 'AD',
                        ),
                        inputWithIcon(
                          hintText: 'Division',
                          iconData: Icons.add,
                          onPressedAction: () {},
                          fieldName: 'division',
                          textFieldOrNot: true,
                          AddressOrExpOrAcademic: 'AD',
                        ),
                        sizedBoxH20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                addressMap.clear();

                                clearTextEditingController(
                                    personal: 0,
                                    address: 1,
                                    academic: 0,
                                    experience: 0);
                              },
                              child: const Column(
                                children: [
                                  Text(
                                    "Discard",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.red),
                                  ),
                                  Icon(
                                    Icons.cancel_outlined,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            MaterialButton(
                              onPressed: () {
                                Map<String, String> copiedAddressMap =
                                    Map.from(addressMap);
                                setState(() {
                                  userAddressLists.add(copiedAddressMap);
                                });
                                addressMap.clear();

                                clearTextEditingController(
                                    personal: 0,
                                    address: 1,
                                    academic: 0,
                                    experience: 0);
                              },
                              child: const Column(
                                children: [
                                  Text(
                                    "Save",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.green),
                                  ),
                                  Icon(
                                    Icons.check,
                                    size: 30,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 50,
                    top: 12,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                      color: Colors.white,
                      child: const Text(
                        'Address',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              sizedBoxH50,
              Container(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                margin: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      Color(0xFF0074b1),
                      Color(0xFF0066a9),
                      Color(0xFF024d8e),
                      Color(0xFF02438e),
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    userInputsList = (userInfoChangeOrNot(
                      userInputsList: userInputsList,
                      storedInputsList: storedInputsList,
                    ));
                    UserDataUploading userDataUploading = UserDataUploading();
                    userDataUploading.uploadUserData(
                        UserInfoData(
                          userID: Profile.userInfoData!.userID,
                          full_name: userInputsList['full_name']!,
                          email: userInputsList['email']!,
                          phone_number: userInputsList['phone_number']!,
                          preference: userInputsList['preference']!,
                          role: userInputsList['role']!,
                          age: userInputsList['age']!,
                          user_profile_photo:
                              userInputsList['user_profile_photo']!,
                        ),
                        isUploadedImage);
                    bool Done = await usersDataProcessing(
                        userAcademicLists: userAcademicLists,
                        userAddressLists: userAddressLists,
                        userExperienceLists: userExperienceLists);

                    if (Done) {
                      Navigator.pop(context);
                    }
                    clearTextEditingController(
                        personal: 1, address: 1, academic: 1, experience: 1);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text(
                    "Update Profile",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
