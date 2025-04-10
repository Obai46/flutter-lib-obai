import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_colors.dart';
import '../../../controller/authentication/register_controller.dart';
import '../../../core/class/handilind_data_view.dart';
import '../../../core/function/valid_input.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/logo_widget.dart';
import '../../widgets/my_butten.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RegisterController());
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: GetBuilder<RegisterController>(builder: (controller) {
            return Form(
              key: controller.formState,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const LogoWidget(),
                  const SizedBox(height: 30),
                  const Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    validator: (val) {
                      return validInput(val!, "username", 100, 5);
                    },
                    keyboardType: TextInputType.name,
                    controller: controller.name,
                    hintText: 'Enter Your Name',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    validator: (val) {
                      return validInput(val!, "city", 100, 5);
                    },
                    keyboardType: TextInputType.name,
                    controller: controller.city,
                    hintText: 'Enter Your City',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 20),
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
                  Obx(
                    () {
                      return CustomTextField(
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
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  MyButton(
                    textColor: AppColors.signInButton,
                    color: AppColors.gradientStart,
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: AppColors.gradientStart,
                        context: context,
                        builder: (context) => SizedBox(
                          height: 200,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.galleryImage();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20),
                                  child: const Text(
                                    "Choose Image From Gallery",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: AppColors.textWhite70),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              InkWell(
                                onTap: () {
                                  controller.cameraImage();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20),
                                  child: const Text(
                                    "Choose Image From Camer",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: AppColors.textWhite70),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    title: 'Add Image',
                  ),
                  HandilingDatatView(
                    statusRequest: controller.statusRequest,
                    widget: MyButton(
                      color: AppColors.signInButton,
                      title: 'Register',
                      textColor: AppColors.gradientEnd,
                      onPressed: () async {
                        if (controller.myfile == null) {
                          return await Get.defaultDialog(
                            title: '',
                          );
                        } else {
                          controller.register();
                        }
                      },
                      icon: Icons.person_add,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
