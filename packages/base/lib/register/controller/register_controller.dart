import 'package:base/register/view/register_view.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class RegisterController extends State<RegisterView> {
  static late RegisterController instance;
  late RegisterView view;

  @override
  void initState() {
    super.initState();
    instance = this;
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
  }

  void onReady() {}

  @override
  void dispose() {
    super.dispose();
  }

  String fullName = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool obscureTextPassword = true;
  bool obscureTextConfirmPassword = true;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Register dengan email dan password
  Future<void> doRegister() async {
    if (!formKey.currentState!.validate()) return;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Konfirmasi password tidak sama'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final result = await AuthService.signUpWithEmailAndPassword(
        email: email,
        password: password,
        displayName: fullName,
        additionalData: {
          'registrationMethod': 'email',
          'registrationDate': DateTime.now().toIso8601String(),
        },
      );

      if (result.isSuccess) {
        // Register berhasil
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Registrasi berhasil!'),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
        }

        // Reload session data untuk memastikan displayName terupdate
        await SessionService.reloadUserData();

        // Navigate to home or dashboard after successful registration
        // You can add navigation logic here
        // context.go('/home');
      } else {
        // Register gagal
        // Jika error reCAPTCHA, berikan opsi Google Sign-In
        bool isRecaptchaError =
            result.errorMessage?.contains('konfigurasi keamanan') == true ||
                result.errorMessage?.contains('CONFIGURATION_NOT_FOUND') ==
                    true;

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result.errorMessage ?? 'Registrasi gagal'),
              backgroundColor: Theme.of(context).colorScheme.error,
              duration: const Duration(seconds: 5),
              action: isRecaptchaError
                  ? SnackBarAction(
                      label: 'Google Sign-In',
                      textColor: Colors.white,
                      onPressed: () {
                        doGoogleRegister();
                      },
                    )
                  : null,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Terjadi kesalahan: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Register dengan Google
  Future<void> doGoogleRegister() async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await AuthService.signInWithGoogle(
        additionalData: {
          'registrationMethod': 'google',
          'registrationDate': DateTime.now().toIso8601String(),
        },
      );

      if (result.isSuccess) {
        // Register dengan Google berhasil
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Registrasi dengan Google berhasil!'),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
        }

        // Reload session data untuk memastikan data user terupdate
        await SessionService.reloadUserData();

        // Navigate to home or dashboard
        // context.go('/home');
      } else {
        // Register gagal
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(result.errorMessage ?? 'Registrasi dengan Google gagal'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Terjadi kesalahan: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
