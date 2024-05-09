import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/resources/auth_method.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/text_feild_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );
    // print(res);
    if (res != 'success') {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              SvgPicture.asset(
                '../../assets/ig_logo.svg',
                height: 64,
                colorFilter: const ColorFilter.mode(
                    Color.fromARGB(255, 255, 255, 255), BlendMode.srcIn),
              ),
              const SizedBox(
                height: 64,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'data:image/png;base64,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'),
                        ),
                  Positioned(
                    left: 80,
                    bottom: -10,
                    child: IconButton(
                      onPressed: () {
                        selectImage();
                      },
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              TextFeildInput(
                textEditingController: _usernameController,
                hintText: "Enter Your Username",
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFeildInput(
                textEditingController: _bioController,
                hintText: "Enter Your Bio",
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFeildInput(
                textEditingController: _emailController,
                hintText: "Enter Your Email",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFeildInput(
                textEditingController: _passwordController,
                hintText: "Enter Your Password",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: signUpUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    color: blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text('Sign Up'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text('Already Have An Acount?'),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      ' Sign In.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
