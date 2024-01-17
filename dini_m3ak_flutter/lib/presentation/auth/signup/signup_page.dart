// ignore_for_file: use_build_context_synchronously

import 'package:dini_maak/presentation/auth/login/login_page.dart';
import 'package:dini_maak/presentation/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/my_button.dart';
import '../../../shared/widgets/my_textfield.dart';

class SignupPage extends StatefulWidget {
  static String signupPage = "/signup";
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  late final AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.fullNameController = TextEditingController();
    authProvider.emailController = TextEditingController();
    authProvider.phoneNumberController = TextEditingController();
    authProvider.passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    authProvider.fullNameController.dispose();
    authProvider.passwordController.dispose();
    authProvider.emailController.dispose();
    authProvider.phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 50,
                horizontal: 20,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Create Account",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                      ),
                    ),
                    const Gap(10),
                    Consumer<AuthProvider>(
                      builder: (_, data, __) {
                        return InkWell(
                          onTap: () async {
                            await authProvider.pickImage();
                          },
                          child: data.selectedProfileImage == null
                              ? const Icon(
                                  Iconsax.user,
                                  size: 100,
                                )
                              : Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image:
                                          FileImage(data.selectedProfileImage!),
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                    const Gap(10),
                    const Text(
                      "Select your picture",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Gap(10),
                    MyTextField(
                      controller: authProvider.fullNameController,
                      hintText: "Full name",
                      prefix: const Icon(
                        Iconsax.user,
                      ),
                    ),
                    const Gap(10),
                    MyTextField(
                      hintText: "Email",
                      controller: authProvider.emailController,
                      prefix: const Icon(
                        Iconsax.receipt,
                      ),
                    ),
                    const Gap(15),
                    MyTextField(
                      controller: authProvider.phoneNumberController,
                      hintText: "Phone  number",
                      prefix: const Icon(
                        Iconsax.call,
                      ),
                    ),
                    const Gap(15),
                    MyTextField(
                      controller: authProvider.passwordController,
                      hintText: "Password",
                      obscureText: true,
                      suffix: const Icon(Iconsax.eye_slash),
                      prefix: const Icon(
                        Iconsax.lock,
                      ),
                    ),
                    const Gap(15),
                    Consumer<AuthProvider>(
                      builder: (_, data, __) => MyButton(
                        isLoading: data.isRegistring,
                        color: Colors.blue.shade700,
                        text: "Register",
                        onClick: () async {
                          if (await data.registerUser()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  "User Registred Successfully",
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  "Error while regestring the user please try again later",
                                ),
                              ),
                            );
                          }
                        },
                        textColor: Colors.white,
                      ),
                    ),
                    const Gap(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Do you have an account?"),
                        const Gap(2),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, LoginPage.logininPage);
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    ();
  }
}
