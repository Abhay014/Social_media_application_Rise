import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rise_flutter/resources/auth_methods.dart';
import 'package:rise_flutter/responsive/mobileScreenLayout.dart';
import 'package:rise_flutter/responsive/responsive_layout_screen.dart';
import 'package:rise_flutter/responsive/webScreenLayout.dart';
import 'package:rise_flutter/screens/login_screen.dart';
import 'package:rise_flutter/utils/colors.dart';
import 'package:rise_flutter/utils/utils.dart';

import '../widgets.dart/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signupUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signupUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);
    setState(() {
      _isLoading = false;
    });

    if (res != "success") {
      showSnackBar(res, context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            //svg image
            Flexible(child: Container(), flex: 1),
            // SvgPicture.asset(
            //   "assests/rise_logo.svg",
            //   //color: primaryColor,
            //   height: 64,
            // ),
            const SizedBox(
              height: 64,
            ),
//circular widgt to accept andshow our selected files
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64, backgroundImage: MemoryImage(_image!))
                    : const CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1557754897-ca12c5049d83?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
                      ),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                      //color: primaryColor,
                    ))
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            //text field input for username
            TextFieldInput(
              textEditingController: _usernameController,
              hintext: 'Enter Start-up name',
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 24,
            ),

            //email
            TextFieldInput(
              textEditingController: _emailController,
              hintext: 'Enter your email',
              textInputType: TextInputType.emailAddress,
            ),

            const SizedBox(
              height: 24,
            ),
            //pass
            TextFieldInput(
              textEditingController: _passwordController,
              hintext: 'Enter your password',
              textInputType: TextInputType.text,
              isPass: true,
            ),
            const SizedBox(
              height: 24,
            ),

            ///enter bio
            TextFieldInput(
              textEditingController: _bioController,
              hintext: 'describe your start-up',
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 24,
            ),

            // button
            InkWell(
              onTap: signupUser,
              child: Container(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text("Log in"),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  color: blueColor,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Flexible(child: Container(), flex: 8),

            // go to signup
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text("Do not have an account"),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: Container(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
