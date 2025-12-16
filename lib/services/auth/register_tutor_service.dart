import 'package:flutter_application_1/core/constants/app_constants.dart';
import 'package:flutter_application_1/models/register_tutor_data_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class RegisterTutorService {
  Future<String?> registerTutor(RegisterTutorDataModel tutorData) async {
    // Simulate a network call to register a tutor
    Uri uri = Uri.parse("${AppConfig.baseUrl}/register/tutor");

    try {
      Map<String, dynamic> dataPayload = tutorData.toJson();

      http.Response response = await http.post(
        uri,
        headers: <String, String>{'content-type': 'application/json'},
        body: jsonEncode(dataPayload),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Pendaftaran Tutor Berhasil! Data dari Server: ${response.body}');
        return null;
      } else {
        try {
          final errorData = jsonDecode(response.body);
          String errorMessage =
              errorData['message'] ??
              'Pendaftaran tutor gagal. Kode status: ${response.statusCode}';
          print(
            'Pendaftaran tutor gagal. Status: ${response.statusCode}. Error: $errorMessage',
          );
          return errorMessage;
        } catch (_) {
          return 'Pendaftaran tutor gagal dengan kode status ${response.statusCode}. Format respons tidak diketahui.';
        }
      }
    } on SocketException catch (e) {
      // Menangkap error 'Connection timed out' atau jaringan lain
      print('Kesalahan Jaringan: $e');
      return 'Gagal terhubung ke server. Pastikan server berjalan dan IP sudah benar. (Gunakan 10.0.2.2 untuk Emulator)';
    } catch (e) {
      print('Terjadi kesalahan tak terduga: $e');
      return 'Terjadi kesalahan tak terduga selama pendaftaran tutor.';
    }
  }
}
