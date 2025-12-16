import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = "http://10.0.2.2:8000/api";
  // ↑ kalau pakai emulator Android.
  // Kalau HP asli: ganti dengan IP lokal laptop kamu (misal 192.168.1.xxx)

  /// Login ke Laravel API
  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        // Simpan token di local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        debugPrint('Login sukses! Token: $token');
        return true;
      } else {
        debugPrint('Login gagal: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Error login: $e');
      return false;
    }
  }

  /// Register akun baru
  Future<bool> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': password,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      debugPrint('Error register: $e');
      return false;
    }
  }

  /// Logout dari Laravel
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null) {
        await http.post(
          Uri.parse('$baseUrl/logout'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
        await prefs.remove('token');
      }
      debugPrint('Logout sukses');
    } catch (e) {
      debugPrint('Error logout: $e');
    }
  }

  /// Cek apakah user masih login
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') != null;
  }
}
