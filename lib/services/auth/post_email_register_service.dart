import 'dart:convert';
import 'dart:io';

import 'package:flutter_application_1/core/constants/app_constants.dart';
import 'package:http/http.dart' as http;

class PostEmailRegisterService {
  Future<String?> emailRegister(
    String email,
    String password,
    String confirmPassword,
  ) async {
    Uri uri = Uri.parse('${AppConfig.baseUrl}/register');

    try {
      Map<String, dynamic> dataPayload = {
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      };
      http.Response response = await http.post(
        uri,
        headers: <String, String>{'content-type': 'application/json'},
        body: jsonEncode(dataPayload),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Registrasi Berhasil! Data dari Server: ${response.body}');
        return null;
      } else {
        try {
          final errorData = jsonDecode(response.body);
          String errorMessage =
              errorData['message'] ??
              'Pendaftaran gagal. Kode status: ${response.statusCode}';
          print(
            'Pendaftaran gagal. Status: ${response.statusCode}. Error: $errorMessage',
          );
          return errorMessage;
        } catch (_) {
          return 'Pendaftaran gagal dengan kode status ${response.statusCode}. Format respons tidak diketahui.';
        }
      }
    } on SocketException catch (e) {
      // Menangkap error 'Connection timed out' atau jaringan lain
      print('Kesalahan Jaringan: $e');
      return 'Gagal terhubung ke server. Pastikan server berjalan dan IP sudah benar. (Gunakan 10.0.2.2 untuk Emulator)';
    } catch (e) {
      print('Terjadi kesalahan tak terduga: $e');
      return 'Terjadi kesalahan tak terduga selama pendaftaran.';
    }
  }
}
