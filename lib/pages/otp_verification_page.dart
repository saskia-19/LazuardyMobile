import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import ini untuk FilteringTextInputFormatter
import 'package:flutter_application_1/models/register_tutor_data_model.dart';

// Ganti dengan halaman tujuan Anda setelah verifikasi berhasil
import 'package:flutter_application_1/pages/detail_pribadi_siswa_page.dart';

class OTPVerificationPage extends StatefulWidget {
  final RegisterTutorDataModel? tutorData;
  final String? email;

  const OTPVerificationPage({super.key, this.tutorData, this.email});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  // --- Kebutuhan untuk 4 digit OTP ---
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  late Timer _timer;
  int _start = 59; // Timer dimulai dari 59 detik

  // Warna utama yang diambil dari desain
  final Color primaryColor = const Color(0xFF3B9CA7);
  final Color textColor = const Color(0xFF6B7280);

  @override
  void initState() {
    super.initState();
    _startTimer();
    _setupOTPListeners();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  // Fungsi untuk memformat waktu menjadi mm:ss
  String get _formattedTime {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // --- Implementasi Auto-Focus (Peningkatan User Experience) ---
  void _setupOTPListeners() {
    for (int i = 0; i < _otpControllers.length; i++) {
      _otpControllers[i].addListener(() {
        // Pindah ke field berikutnya jika sudah terisi 1 karakter dan bukan field terakhir
        if (_otpControllers[i].text.length == 1 && i < 3) {
          FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
        }
        // Pindah ke field sebelumnya jika dihapus (karakter menjadi 0) dan bukan field pertama
        else if (_otpControllers[i].text.isEmpty && i > 0) {
          FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
        }
      });

      // Tambahkan listener untuk key events pada field (khusus penanganan backspace)
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) {
          RawKeyboard.instance.addListener((event) {
            if (event is RawKeyDownEvent &&
                event.logicalKey == LogicalKeyboardKey.backspace &&
                _otpControllers[i].text.isEmpty &&
                i > 0) {
              // Jika backspace ditekan dan field kosong, pindah ke field sebelumnya
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
              // Agar karakter di field sebelumnya juga ikut terhapus saat pindah
              _otpControllers[i - 1].clear();
            }
          });
        }
      });
    }
  }
  // -----------------------------------------------------------

  void _verifyOTP() {
    final otp = _otpControllers.map((controller) => controller.text).join();
    if (otp.length == 4) {
      print('Verifying OTP: $otp');
      // Jika verifikasi berhasil, navigasi ke halaman selanjutnya
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DetailPribadiPage()),
      );
    } else {
      // Tampilkan pesan error jika OTP belum lengkap
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Kode OTP harus 4 digit.')));
    }
  }

  void _resendOTP() {
    // Logika untuk mengirim ulang OTP
    print('Resending OTP...');
    setState(() {
      _start = 59; // Reset timer
    });
    // Kosongkan field
    for (var controller in _otpControllers) {
      controller.clear();
    }
    // Fokuskan kembali ke field pertama
    FocusScope.of(context).requestFocus(_focusNodes[0]);
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    // Menggunakan MediaQuery untuk mendapatkan tinggi layar dan membagi ruang
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Spasi di atas judul (dinaikkan ke atas)
              SizedBox(height: screenHeight * 0.05),

              // Teks Judul Utama
              const Text(
                'Verifikasi Kode OTP',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 12),

              // Teks Deskripsi
              Text(
                'Masukkan kode OTP yang telah kami kirim ke email Anda untuk melanjutkan',
                style: TextStyle(fontSize: 16, color: textColor),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 40),

              // --- OTP Input Fields (Menggunakan Row untuk 4 kotak) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 65, // Ukuran kotak disesuaikan
                    child: TextFormField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      // Hanya menerima input angka
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 1,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),

              // Teks Timer
              Center(
                child: Text(
                  'Kirim ulang kode dalam $_formattedTime',
                  style: TextStyle(color: textColor, fontSize: 16),
                ),
              ),
              const SizedBox(height: 50),

              // --- Tombol Verifikasi ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _verifyOTP,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Verifikasi',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // --- Tombol Kirim Lagi ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // Tombol aktif jika timer = 0
                  onPressed: _start == 0 ? _resendOTP : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    // Mengatur warna tombol "Kirim Lagi" (Sama dengan Verifikasi, namun disabled saat timer berjalan)
                    disabledBackgroundColor: primaryColor.withOpacity(0.5),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Kirim Lagi',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // Menambahkan spasi di bawah
              SizedBox(height: screenHeight * 0.1),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    for (final controller in _otpControllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
