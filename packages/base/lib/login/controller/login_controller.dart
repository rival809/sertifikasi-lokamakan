import 'package:base/login/view/login_view.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class LoginController extends State<LoginView> {
  static late LoginController instance;
  late LoginView view;

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

  String username = '';
  String password = '';
  String pin = '';
  String? token;
  bool obscureText = true;
  bool isLoading = false;
  bool rememberMe = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Login dengan email dan password
  Future<void> doLogin() async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      final result = await AuthService.signInWithEmailAndPassword(
        email: username,
        password: password,
      );

      if (result.isSuccess) {
        // Login berhasil
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Login berhasil!'),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
        }

        // Navigate to home or dashboard
        // Ganti dengan navigation sesuai dengan routing aplikasi Anda
        newRouter.replace(RouterUtils.beranda);
      } else {
        // Login gagal
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result.errorMessage ?? 'Login gagal'),
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

  // Login dengan Google
  Future<void> doGoogleLogin() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Gunakan method yang memaksa pemilihan akun
      final result = await AuthService.signInWithGoogleForceSelection();

      if (result.isSuccess) {
        // Login berhasil
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Login dengan Google berhasil!'),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
        }

        // Navigate to home or dashboard
        newRouter.replace(RouterUtils.beranda);
      } else {
        // Login gagal
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result.errorMessage ?? 'Login dengan Google gagal'),
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

  // Reset password
  Future<void> doForgotPassword() async {
    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan masukkan email terlebih dahulu'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final result = await AuthService.sendPasswordResetEmail(username);

      if (result.isSuccess) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Email reset password telah dikirim!'),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(result.errorMessage ?? 'Gagal mengirim email reset'),
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
