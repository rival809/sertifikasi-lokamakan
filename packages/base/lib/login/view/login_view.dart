import 'package:base/login/controller/login_controller.dart';
import 'package:base/register/view/register_view.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  Widget build(context, LoginController controller) {
    controller.view = this;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey,
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        border: Border.all(
                          width: 1.0,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Shield Icon
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.security,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 32,
                              ),
                            ),
                            const SizedBox(height: 24.0),
                            // Login Title
                            Text(
                              "Masuk Akun",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                            ),
                            const SizedBox(height: 8.0),
                            // Subtitle
                            Text(
                              "Silakan masuk untuk melanjutkan",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                            const SizedBox(height: 32.0),
                            // Email Input Field
                            BaseForm(
                              autoFocus: true,
                              hintText: "Masukkan Email",
                              prefixIcon: const Icon(Icons.email_outlined),
                              onChanged: (value) {
                                controller.username = value;
                                controller.update();
                              },
                              validator: Validatorless.multiple([
                                Validatorless.required(
                                    "Email tidak boleh kosong"),
                                Validatorless.email("Format email tidak valid"),
                              ]),
                            ),
                            const SizedBox(height: 16.0),
                            // Password Input Field
                            BaseForm(
                              hintText: "Masukkan Kata Sandi",
                              prefixIcon: const Icon(Icons.lock_open),
                              suffixIcon: controller.obscureText
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                              obsecure: controller.obscureText,
                              onChanged: (value) {
                                controller.password = value;
                                controller.update();
                              },
                              onEditComplete: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.doLogin();
                                }
                              },
                              onTapSuffix: () {
                                controller.obscureText =
                                    !controller.obscureText;
                                controller.update();
                              },
                              validator: Validatorless.multiple([
                                Validatorless.required(
                                    "Kata sandi tidak boleh kosong"),
                                Validatorless.min(
                                    6, "Kata sandi minimal 6 karakter"),
                              ]),
                            ),
                            const SizedBox(height: 16.0),
                            // Remember me and Forgot Password Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: controller.rememberMe,
                                      onChanged: (value) {
                                        controller.rememberMe = value ?? false;
                                        controller.update();
                                      },
                                    ),
                                    const Text("Ingat Saya"),
                                  ],
                                ),
                                TextButton(
                                  onPressed: controller.isLoading
                                      ? null
                                      : () {
                                          controller.doForgotPassword();
                                        },
                                  child: Text(
                                    "Lupa Kata Sandi?",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24.0),
                            // Login Button
                            BasePrimaryButton(
                              text: controller.isLoading
                                  ? "Sedang Masuk..."
                                  : "Masuk",
                              onPressed: controller.isLoading
                                  ? null
                                  : () {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        controller.doLogin();
                                      }
                                    },
                            ),
                            const SizedBox(height: 24.0),
                            // Or login with text
                            Text(
                              "Atau masuk dengan",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            // Social Login Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Google
                                IconButton(
                                  icon: const FaIcon(FontAwesomeIcons.google),
                                  onPressed: controller.isLoading
                                      ? null
                                      : () {
                                          controller.doGoogleLogin();
                                        },
                                ),
                              ],
                            ),
                            const SizedBox(height: 24.0),
                            // Sign Up Text
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Belum punya akun? ",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Navigate to sign up
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterView(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Daftar Sekarang",
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<LoginView> createState() => LoginController();
}
