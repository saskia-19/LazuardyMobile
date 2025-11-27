// Mengasumsikan file ini berada di lokasi yang sama dengan file asli dan OTPVerificationPage tersedia.
// Walaupun namanya 'SignInSiswaPage', kontennya disesuaikan untuk halaman 'Daftar' (Sign Up) sesuai desain.
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/otp_verification_page.dart';
import 'package:flutter_application_1/pages/login_page.dart';

class SignInSiswaPage extends StatefulWidget {
  const SignInSiswaPage({super.key});

  @override
  State<SignInSiswaPage> createState() => _SignInSiswaPageState();
}

class _SignInSiswaPageState extends State<SignInSiswaPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _rememberMe = false; // State untuk checkbox "Ingat saya"

  // Warna Teal yang mendekati desain (0xFF3897A3 adalah warna teal yang bersih)
  final Color primaryTeal = const Color(0xFF3897A3);
  final Color facebookBlue = const Color(0xFF1877F2); // Warna standar Facebook

  @override
  Widget build(BuildContext context) {
    const Color facebookColor = Color(0xFF1877F2);

    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang putih
      // --- PERUBAHAN: Menambahkan AppBar untuk tombol kembali ---
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      // --------------------------------------------------------
      body: SingleChildScrollView(
        // Padding vertikal dihilangkan dari sini, diatur oleh Column
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Spasi kecil setelah AppBar
              const SizedBox(height: 16),
              // Logo (diasumsikan path asset benar)
              Image.asset('assets/images/logo_lazuardi_noText.png', height: 80),
              const SizedBox(height: 16), // Spasi setelah logo
              // --- PERUBAHAN: Judul Utama: Daftar sebagai siswa ---
              const Text(
                'Daftar sebagai siswa', // Diubah dari 'pelajar'
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF263238),
                ),
              ),
              const SizedBox(height: 8),

              // Sub-judul: Sudah punya akun? Masuk
              Row(
                children: [
                  const Text(
                    'Sudah punya akun?',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        // Gunakan replacement agar tidak menumpuk
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Masuk',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryTeal,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // --- FORM FIELDS ---

              // 1. Email Field
              _buildLabel('Email'),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email Anda',
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryTeal, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email harus diisi';
                  }
                  if (!value.contains('@')) {
                    return 'Email tidak valid';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // 2. Password Field
              _buildLabelWithHelper(
                'Kata Sandi',
                'Kata sandi minimal 8 karakter',
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Kata sandi Anda',
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons
                                .visibility_off_outlined // Sesuai desain
                          : Icons.visibility_outlined, // Sesuai desain
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryTeal, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kata sandi harus diisi';
                  }
                  if (value.length < 8) {
                    return 'Kata sandi minimal 8 karakter';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // 3. Confirm Password Field
              _buildLabel('Konfirmasi Kata Sandi'),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  hintText: 'Konfirmasi Kata sandi Anda',
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons
                                .visibility_off_outlined // Sesuai desain
                          : Icons.visibility_outlined, // Sesuai desain
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryTeal, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Konfirmasi kata sandi harus diisi';
                  }
                  if (value != _passwordController.text) {
                    return 'Kata sandi tidak sama';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 8),

              // Checkbox "Ingat saya"
              Row(
                children: [
                  SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: Checkbox(
                      value: _rememberMe,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _rememberMe = newValue!;
                        });
                      },
                      activeColor: primaryTeal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      // Mengatur warna border
                      side: BorderSide(color: Colors.grey.shade400, width: 2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Ingat saya',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Sign Up Button ("Daftar")
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Proses sign up dan navigasi ke OTP verification
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OTPVerificationPage(email: _emailController.text),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryTeal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Daftar',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Divider "atau"
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'atau',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ),

              const SizedBox(height: 24),

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
                  backgroundColor: facebookColor,
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
              const SizedBox(height: 24), // Spasi di akhir
            ],
          ),
        ),
      ),
    );
  }

  // Widget pembantu untuk label field (di atas field)
  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF263238),
        ),
      ),
    );
  }

  // Widget pembantu untuk label dengan helper text (kata sandi)
  Widget _buildLabelWithHelper(String label, String helperText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF263238),
            ),
          ),
          Text(
            helperText,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
