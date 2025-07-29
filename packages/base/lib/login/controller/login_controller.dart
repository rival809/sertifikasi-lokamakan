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
            const SnackBar(
              content: Text('Login berhasil!'),
              backgroundColor: Colors.green,
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
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Terjadi kesalahan: ${e.toString()}'),
            backgroundColor: Colors.red,
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
      final result = await AuthService.signInWithGoogle();

      if (result.isSuccess) {
        // Login berhasil
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login dengan Google berhasil!'),
              backgroundColor: Colors.green,
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
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Terjadi kesalahan: ${e.toString()}'),
            backgroundColor: Colors.red,
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
            const SnackBar(
              content: Text('Email reset password telah dikirim!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(result.errorMessage ?? 'Gagal mengirim email reset'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Terjadi kesalahan: ${e.toString()}'),
            backgroundColor: Colors.red,
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
