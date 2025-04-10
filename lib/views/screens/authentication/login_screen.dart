import 'package:cfy/core/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/authentication/login_controller.dart';
import '../../../core/class/handilind_data_view.dart';
import '../../../core/function/valid_input.dart';
import '../../widgets/logo_widget.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/my_butten.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: GetX<LoginController>(
              builder: (controller) {
                return Form(
                  key: controller.formState,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const LogoWidget(),
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          'Sign in to continue',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[400]),
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomTextField(
                        validator: (val) {
                          return validInput(val!, "email", 100, 5);
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: controller.email,
                        hintText: 'Enter your Email',
                        icon: Icons.email,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        validator: (val) {
                          return validInput(val!, "password", 100, 5);
                        },
                        keyboardType: TextInputType.visiblePassword,
                        controller: controller.password,
                        hintText: 'Enter your Password',
                        icon: Icons.lock,
                        onTap: () => controller.showPassword(),
                        icons: controller.isShowPassword.value == true
                            ? const Icon(Icons.visibility_off_outlined)
                            : const Icon(Icons.visibility_outlined),
                        obscureText: controller.isShowPassword.value,
                      ),
                      const SizedBox(height: 30),
                      HandilingDatatView(
                        statusRequest: controller.statusRequest.value,
                        widget: MyButton(
                          color: AppColors.signInButton.withOpacity(0.8),
                          title: 'Log In',
                          onPressed: () {
                            controller.logIn();
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
