import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:get/get.dart';
import 'package:otp/sign_up_controller.dart';

import 'otp-page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final controller =Get.put(SignUpController());
  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(

      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        print(credential);
        // authentication successful, do something
      },
      verificationFailed: (FirebaseAuthException e) {
        // authentication failed, do something
        print(e);
      },
      codeSent: (String verificationId, int? resendToken) async {
        // code sent to phone number, save verificationId for later use
        String smsCode = ''; // get sms code from user
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode,
        );
        Get.to(OtpPage(), arguments: [verificationId]);
        await auth.signInWithCredential(credential);
        // authentication successful, do something
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Country selectedCountry = Country(
    phoneCode: "225",
    countryCode: "CI",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "Côte d'Ivoire",
    example: "Côte d'Ivoire",
    displayName: "Côte d'Ivoire",
    displayNameNoCountryCode: "CI",
    e164Key: "",
  );

  void _userLogin() async {
    String mobile = controller.number.text;
    if (mobile == "") {
      Get.snackbar(
        "Veuillez fournir un numéro de telephone!",
        "Echec",
        colorText: Colors.white,
      );
    } else {
      signInWithPhoneNumber("+${selectedCountry.phoneCode}$mobile");
    }
  }



  _buildSocialLogo(file) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          file,
          height: 38.5,
        ),
      ],
    );
  }

  final ButtonStyle style = ElevatedButton.styleFrom(
      minimumSize: const Size(188, 48),
      backgroundColor: const Color(0xFF051B8B),
      elevation: 6,
      textStyle: const TextStyle(fontSize: 16),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          )));

  Widget buildText(String text) => Center(
    child: Text(
      text,
      style: const TextStyle(fontSize: 24, color: Colors.white),
    ),
  );

  void signFacebook() {
    // signInWithFacebook();
  }

  void signGoogle() {
    // signInWithGoogle();
  }

  void signApple() {
    // signInWithGoogle();
  }


  @override
  Widget build(BuildContext context) {
    controller.number.selection = TextSelection.fromPosition(
      TextPosition(
        offset: controller.number.text.length,
      ),
    );
    return Scaffold(

      //backgroundColor: const Color(0xff0F2B2F),
      // backgroundColor: Color(0xff215D5F),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              const SizedBox(height: 200),
              buildText('Log In'),
              const SizedBox(height: 50),
              TextFormField(
                controller: controller.firstName,
                decoration: InputDecoration(
                  hintText: "Nom"
                ),
              ),
              TextFormField(
                controller: controller.lastName,
                decoration: InputDecoration(
                    hintText: "Prenom"
                ),
              ),
              TextFormField(
                controller: controller.email,
                decoration: InputDecoration(
                    hintText: "Email"
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.white,
                  controller: controller.number,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  onChanged: (value) {
                    setState(() {
                      controller.number.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    //fillColor: const Color(0xff2C474A),
                    filled: true,
                    hintText: "numéro",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.black38)),
                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.white, width: 2.0)),
                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.black38, width: 2.0)),
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                              context: context,
                              countryListTheme: const CountryListThemeData(
                                bottomSheetHeight: 550,
                              ),
                              onSelect: (value) {
                                setState(() {
                                  selectedCountry = value;
                                });
                              });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    suffixIcon: controller.number.text.length > 9
                        ? Container(
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: const Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 20,
                      ),
                    )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                  style: style,
                  onPressed: _userLogin,
                  child: const Text(
                    "Obtenir le code",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )),
              const SizedBox(height: 80),
              const Text(
                "Ou continuer avec  ",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      signFacebook();
                    },
                    child: _buildSocialLogo('assets/facebook.png'),
                  ),
                  const SizedBox(width: 40),
                  GestureDetector(
                    onTap: () {
                      signApple();
                    },
                    child: _buildSocialLogo('assets/apple.png'),
                  ),
                  const SizedBox(width: 40),
                  GestureDetector(
                    onTap: () {
                      signGoogle();
                    },
                    child: _buildSocialLogo('assets/google.png'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
