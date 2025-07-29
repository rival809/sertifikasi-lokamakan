import 'package:base/register/controller/register_controller.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  Widget build(context, RegisterController controller) {
    controller.view = this;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey,
              child: SingleChildScrollView(
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
                            Text(
                              "Daftar Akun",
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
                              "Buat akun baru untuk melanjutkan",
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
                            // Full Name Input Field
                            BaseForm(
                              autoFocus: true,
                              hintText: "Masukkan Nama Lengkap",
                              prefixIcon: const Icon(Icons.person_outlined),
                              onChanged: (value) {
                                controller.fullName = value;
                                controller.update();
                              },
                              validator: Validatorless.multiple([
                                Validatorless.required(
                                    "Nama lengkap tidak boleh kosong"),
                                Validatorless.min(2, "Nama minimal 2 karakter"),
                              ]),
                            ),
                            const SizedBox(height: 16.0),
                            // Email Input Field
                            BaseForm(
                              hintText: "Masukkan Email",
                              prefixIcon: const Icon(Icons.email_outlined),
                              onChanged: (value) {
                                controller.email = value;
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
                              suffixIcon: controller.obscureTextPassword
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                              obsecure: controller.obscureTextPassword,
                              onChanged: (value) {
                                controller.password = value;
                                controller.update();
                              },
                              onTapSuffix: () {
                                controller.obscureTextPassword =
                                    !controller.obscureTextPassword;
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
                            // Confirm Password Input Field
                            BaseForm(
                              hintText: "Konfirmasi Kata Sandi",
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: controller.obscureTextConfirmPassword
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                              obsecure: controller.obscureTextConfirmPassword,
                              onChanged: (value) {
                                controller.confirmPassword = value;
                                controller.update();
                              },
                              onEditComplete: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.doRegister();
                                }
                              },
                              onTapSuffix: () {
                                controller.obscureTextConfirmPassword =
                                    !controller.obscureTextConfirmPassword;
                                controller.update();
                              },
                              validator: Validatorless.multiple([
                                Validatorless.required(
                                    "Konfirmasi kata sandi tidak boleh kosong"),
                                Validatorless.min(
                                    6, "Kata sandi minimal 6 karakter"),
                              ]),
                            ),
                            const SizedBox(height: 24.0),
                            // Register Button
                            BasePrimaryButton(
                              text: controller.isLoading
                                  ? "Sedang Mendaftar..."
                                  : "Daftar",
                              onPressed: controller.isLoading
                                  ? null
                                  : () {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        controller.doRegister();
                                      }
                                    },
                            ),
                            const SizedBox(height: 24.0),
                            // Or register with text
                            Text(
                              "Atau daftar dengan",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            // Social Register Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Google
                                IconButton(
                                  icon: const FaIcon(FontAwesomeIcons.google),
                                  onPressed: controller.isLoading
                                      ? null
                                      : () {
                                          controller.doGoogleRegister();
                                        },
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            // Sign In Text
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Sudah punya akun? ",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Kembali ke login
                                  },
                                  child: Text(
                                    "Masuk Sekarang",
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
  State<RegisterView> createState() => RegisterController();
}
