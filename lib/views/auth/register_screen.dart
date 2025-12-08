import 'package:e_learning_application/core/utils/validators.dart';
import 'package:e_learning_application/models/user_model.dart';
import 'package:e_learning_application/routes/app_routes.dart';
import 'package:e_learning_application/views/onboarding/widgets/common/custom_button.dart';
import 'package:e_learning_application/views/onboarding/widgets/common/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _onConfirmPasswordController = TextEditingController();

  UserRole? _selectedRole;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _onConfirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Get.height * 0.25,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(100),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 50,
                    left: 20,
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Start your Learning Journey',
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        // full name textfield
                        CustomTextfield(
                          label: "Full Name",
                          prefixIcon: Icons.person_outline,
                          controller: _fullNameController,
                          validator: Formvalidator.validateFullName,
                        ),
                        const SizedBox(height: 20),
                        CustomTextfield(
                          label: "Email",
                          prefixIcon: Icons.email_outlined,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: Formvalidator.validateEmail,
                        ),
                        const SizedBox(height: 20),
                        CustomTextfield(
                          label: "Password",
                          prefixIcon: Icons.lock_outline,
                          controller: _passwordController,
                          validator: Formvalidator.validatePassword,
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        CustomTextfield(
                          label: "Confirm Password",
                          prefixIcon: Icons.lock_outline,
                          controller: _onConfirmPasswordController,
                          validator: (value) =>
                              Formvalidator.validateConfirmPassword(
                                value,
                                _passwordController.text,
                              ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  DropdownButtonFormField<UserRole>(
                    decoration: InputDecoration(
                      labelText: 'Role',
                      prefixIcon: const Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    initialValue: _selectedRole,
                    items: UserRole.values.map<DropdownMenuItem<UserRole>>((
                      UserRole role,
                    ) {
                      return DropdownMenuItem(
                        value: role,
                        child: Text(
                          role.toString().split('.').last.capitalize!,
                        ),
                      );
                    }).toList(),
                    onChanged: (UserRole? value) {
                      setState(() {
                        _selectedRole = value;
                      });
                    },
                  ),

                  const SizedBox(height: 30),

                  // register button
                  CustomButton(text: 'Register', onPressed: _handleRegister),

                  const SizedBox(height: 20),

                  // login link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an Account?',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleRegister() {
    if (_formkey.currentState!.validate() && _selectedRole != null) {
      // handle registration logic
      if (_selectedRole == UserRole.teacher) {
        Get.offAllNamed(AppRoutes.teacherHome);
      } else {
        Get.offAllNamed(AppRoutes.main);
      }
    } else if (_selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a role'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
