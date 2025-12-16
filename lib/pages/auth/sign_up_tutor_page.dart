import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_constants.dart';
import 'package:flutter_application_1/models/register_tutor_data_model.dart';
import 'package:flutter_application_1/pages/profile/detail_pribadi_tutor_page.dart';
import 'package:flutter_application_1/pages/auth/otp_verification_page.dart';
import 'package:flutter_application_1/services/auth/post_email_register_service.dart';
import 'package:flutter_application_1/widgets/form_field_widget.dart';
import 'package:flutter_application_1/widgets/header_widget.dart';

class SignUpTutorPage extends StatefulWidget {
  const SignUpTutorPage({super.key});

  @override
  State<SignUpTutorPage> createState() => _SignUpTutorPageState();
}

class _SignUpTutorPageState extends State<SignUpTutorPage> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;

  void _submitForm() async {
    if (!_formkey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true; // Mulai loading
    });

    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    final String? errorMessage = await PostEmailRegisterService().emailRegister(
      email,
      password,
      confirmPassword,
    );

    RegisterTutorDataModel data = RegisterTutorDataModel(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    setState(() {
      _isLoading = false;
    });

    if (errorMessage == null) {
      // ✅ SUKSES
      _showSnackBar(context, 'Pendaftaran Berhasil!', AppColor.primary);

      // NAVIGASI HANYA JIKA TIDAK ADA ERROR
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OTPVerificationPage(tutorData: data)),
      );
    } else {
      _showSnackBar(context, errorMessage, Colors.red);
    }
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              LogoHeaderWidget(),
              // Header
              HeaderTextWidget(
                textHeader: "Daftar sebagai tutor",
                textSubHeader: "Sudah punya akun?",
                textLink: 'Masuk',
              ),
              // Email
              LabeledFormWrapper(
                label: "Email",
                child: BuildEmailField(controller: _emailController),
              ),

              LabeledFormWrapper(
                label: 'Kata Sandi',
                child: CustomPasswordField(
                  controller: _passwordController,
                  isObscure: _obscurePassword,
                  onToggleVisibility: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  labelText: 'Kata Sandi',
                ),
              ),

              LabeledFormWrapper(
                label: 'Konfirmasi Kata Sandi',
                child: CustomPasswordField(
                  controller: _confirmPasswordController,
                  isObscure: _obscureConfirmPassword,
                  onToggleVisibility: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                  labelText: 'Kata Sandi Konfirmasi',
                  comparisonValue: _passwordController.text,
                ),
              ),
              // Checkbox
              RememberMeCheckbox(
                rememberMe: _rememberMe,
                onChange: (bool? newValue) {
                  setState(() {
                    _rememberMe = newValue!;
                  });
                },
              ),

              // Tombol Sign in with Google
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Ganti dengan path logo Google Anda
                    Image.asset('assets/images/google_logo.png', height: 22),
                    const SizedBox(width: 12),
                    // --- PERUBAHAN: Teks "Sign in" ---
                    const Text(
                      'Sign in with Google', // Diubah dari 'Sign up'
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Tombol Sign in with Facebook
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.facebook,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Ganti dengan path logo Facebook Anda
                    Image.asset('assets/images/facebook_logo.png', height: 24),
                    const SizedBox(width: 12),
                    // --- PERUBAHAN: Teks "Sign in" ---
                    const Text(
                      'Sign in with Facebook', // Diubah dari 'Sign up'
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading 
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                      )
                    : const Text('Daftar', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose;
    _passwordController.dispose;
    _confirmPasswordController.dispose;
    super.dispose();
  }
}
