import 'dart:io';
import 'package:flutter/services.dart';

import '../../shared/extension.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sanjaya/shared/theme.dart';
import 'package:sanjaya/ui/pages/address.dart';
import 'package:sanjaya/ui/widgets/custom_button.dart';
import 'package:sanjaya/ui/widgets/custom_form_field.dart';
import 'package:sanjaya/ui/widgets/header.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends HookWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackgroundColor,
      body: ListView(
        children: [
          const Header(
            title: "Sign Up",
            subTitle: "Register and eat",
            back: true,
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
              vertical: 26,
            ),
            color: Colors.white,
            child: HookBuilder(builder: (_) {
              File? file;

              final image = useState(file);
              final _formkey = useState(GlobalKey<FormState>());
              final nameController = useTextEditingController();
              final emailController = useTextEditingController();
              final passwordController = useTextEditingController();

              Future<void> openCamera() async {
                final pickedImage =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (pickedImage != null) {
                  image.value = File(pickedImage.path);
                }
              }

              Future<void> openGallery() async {
                final pickedImage =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  image.value = File(pickedImage.path);
                }
              }

              return Column(
                children: [
                  DottedBorder(
                    borderType: BorderType.Circle,
                    color: cSecondaryColor,
                    dashPattern: const [16, 11],
                    child: Center(
                      child: Container(
                        height: 110,
                        width: 110,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: image.value != null
                            ? GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: ((builder) => Container(
                                          height: 100,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                          child: Column(
                                            children: [
                                              const Text(
                                                'Choose Profile Photo',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(
                                                        Icons.camera),
                                                    onPressed: () {},
                                                    tooltip: 'Camera',
                                                  ),
                                                  IconButton(
                                                    icon:
                                                        const Icon(Icons.image),
                                                    onPressed: () {},
                                                    tooltip: 'Gallery',
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )),
                                  );
                                },
                                child: ClipOval(
                                  child: Image.file(
                                    image.value!,
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: ((builder) => Container(
                                          height: 100,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Choose Profile Photo',
                                                style: tBlackText.copyWith(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextButton(
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.camera,
                                                          color: cBlackColor,
                                                        ),
                                                        const SizedBox(
                                                            width: 6),
                                                        Text(
                                                          "Camera",
                                                          style: tBlackText
                                                              .copyWith(
                                                            fontSize: 13,
                                                            fontWeight: medium,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    onPressed: () {
                                                      openCamera();
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  const SizedBox(width: 24),
                                                  TextButton(
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.image,
                                                          color: cBlackColor,
                                                        ),
                                                        const SizedBox(
                                                            width: 6),
                                                        Text(
                                                          "Gallery",
                                                          style: tBlackText
                                                              .copyWith(
                                                            fontSize: 13,
                                                            fontWeight: medium,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    onPressed: () {
                                                      openGallery();
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )),
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundColor: cGreyColor,
                                  child: Center(
                                    child: Text(
                                      "Add\nPhoto",
                                      textAlign: TextAlign.center,
                                      style: tGreyText.copyWith(
                                        fontWeight: light,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: Form(
                      key: _formkey.value,
                      child: Column(
                        children: [
                          CustomFormField(
                            label: "Full Name",
                            hint: "Type your full name",
                            bottomMargin: 16,
                            controller: nameController,
                            validator: (val) {
                              if (!val!.isValidName) {
                                return 'Enter valid name';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r"[a-zA-Z]+|\s"),
                              )
                            ],
                          ),
                          CustomFormField(
                              label: "Email Address",
                              hint: "Type your email address",
                              bottomMargin: 16,
                              controller: emailController,
                              validator: (val) {
                                if (!val!.isValidEmail) {
                                  return 'Enter valid email';
                                }
                                return null;
                              }),
                          CustomFormField(
                            label: "Password",
                            hint: "Type your password",
                            bottomMargin: 24,
                            isObscure: true,
                            controller: passwordController,
                            validator: (val) {
                              if (!val!.isValidPassword) {
                                return 'Uppercase & Lowercase, number, min 8 digit';
                              }
                              return null;
                            },
                          ),
                          CustomButton(
                            title: "Continue",
                            eventFunc: () {
                              if (_formkey.value.currentState!.validate()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Address(
                                        file: image.value,
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
