# 🚀 Setup Guide - Lazuardi Mobile App

## 📋 Daftar Isi
1. [Jalankan Backend (Laravel)](#jalankan-backend-laravel)
2. [Jalankan Frontend (Flutter)](#jalankan-frontend-flutter)
3. [Test Koneksi API](#test-koneksi-api)
4. [Error Troubleshooting](#error-troubleshooting)

---

## 🔧 Jalankan Backend (Laravel)

### Prerequisites
- PHP 8.0+
- Composer
- MySQL/MariaDB (atau database lain)

### Langkah-Langkah

#### 1. Setup Database
```bash
# Edit file .env
# Set DB_CONNECTION, DB_HOST, DB_PORT, DB_DATABASE, DB_USERNAME, DB_PASSWORD

# Jalankan migration
php artisan migrate
```

#### 2. Buat Endpoint API untuk Form Data
Buat file di `routes/api.php`:

```php
<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::middleware('api')->group(function () {
    // Endpoint untuk ambil data form (gender, agama, bank)
    Route::get('/form-data', function () {
        return response()->json([
            'gender' => ['Laki-laki', 'Perempuan'],
            'religion' => ['Islam', 'Kristen Protestan', 'Kristen Katolik', 'Hindu', 'Buddha', 'Konghucu'],
            'bank' => ['BCA', 'BRI', 'Mandiri', 'BTN', 'CIMB Niaga', 'Maybank']
        ]);
    });

    // Endpoint untuk submit data tutor
    Route::post('/tutor/register', function (Request $request) {
        // Validasi
        $validated = $request->validate([
            'nama' => 'required|string',
            'jenisKelamin' => 'required|in:Laki-laki,Perempuan',
            'agama' => 'required|string',
            'whatsapp' => 'required|string',
            'bank' => 'required|string',
            'rekening' => 'required|string',
            'fotoProfile' => 'nullable|image|max:2048'
        ]);

        // Proses data (simpan ke database, dll)
        // ...

        return response()->json([
            'success' => true,
            'message' => 'Data tutor berhasil disimpan',
            'data' => $validated
        ]);
    });
});
```

#### 3. Tambah CORS Middleware (Jika belum ada)
Edit `config/cors.php` atau tambah middleware di `app/Http/Middleware/HandleCors.php`:

```php
<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class HandleCors
{
    public function handle(Request $request, Closure $next)
    {
        return $next($request)
            ->header('Access-Control-Allow-Origin', '*')
            ->header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS')
            ->header('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    }
}
```

#### 4. Jalankan Laravel Server
```bash
# Buka terminal di folder Laravel project
php artisan serve

# Output: Laravel development server started: http://127.0.0.1:8000
```

---

## 📱 Jalankan Frontend (Flutter)

### Prerequisites
- Flutter SDK 3.9.2+
- Android SDK / iOS SDK

### Langkah-Langkah

#### 1. Install Dependencies
```bash
flutter pub get
```

#### 2. Jalankan di Emulator/Device

**Pilih 1:**
```bash
# Lihat device/emulator yang tersedia
flutter devices

# Run di device tertentu
flutter run -d <device_id>

# Atau auto-pilih device pertama
flutter run
```

#### 3. Edit Base URL (Jika Perlu)
File: `lib/core/constants/app_constants.dart`

```dart
class AppConfig {
  // Untuk Android Emulator (menggunakan IP 10.0.2.2)
  static const String baseUrlEmulatorAndroid = 'http://10.0.2.2:8000/api';
  
  // Untuk Device Real (ganti dengan IP laptop Anda)
  // Cari IP di terminal: ipconfig (Windows) / ifconfig (Mac/Linux)
  static const String baseUrlAndroidAsli = 'http://192.168.x.x:8000/api';
}
```

---

## 🧪 Test Koneksi API

### Cara 1: Gunakan Test Service (Recommended)
1. Edit file `lib/main.dart` atau buat debug page
2. Import dan gunakan:

```dart
import 'package:flutter_application_1/services/api_test_service.dart';

// Jalankan test
void testAPI() async {
  ApiTestService.printDebugInfo();
  
  var result = await ApiTestService.testConnection();
  print(result);
  
  if (result['success']) {
    print('✅ API Connected!');
  } else {
    print('❌ API Connection Failed');
    print('Error: ${result['message']}');
  }
}
```

### Cara 2: Manual dengan Terminal
```bash
# Test dari terminal
curl -X GET "http://localhost:8000/api/form-data"

# Jika di emulator, test dari laptop dulu
curl -X GET "http://127.0.0.1:8000/api/form-data"
```

### Cara 3: Gunakan Postman/Insomnia
1. Import API ke Postman
2. Test endpoint:
   - **GET** `http://localhost:8000/api/form-data`
   - **POST** `http://localhost:8000/api/tutor/register`

---

## ❌ Error Troubleshooting

### 1. **"Connection Refused" / "Unable to connect to backend"**
- ✅ Cek Laravel server running: `php artisan serve`
- ✅ Port 8000 tidak ter-block firewall
- ✅ Gunakan IP 10.0.2.2 untuk emulator Android, bukan localhost

### 2. **"Timeout - Backend tidak merespons"**
- ✅ Backend server mungkin crashed, restart: `php artisan serve`
- ✅ Network/internet connection bermasalah
- ✅ Route `/api/form-data` belum dibuat di Laravel

### 3. **"Status Code 404"**
- ✅ Cek route di `routes/api.php` sudah benar
- ✅ URL endpoint harus: `http://10.0.2.2:8000/api/form-data`

### 4. **CORS Error di Browser**
- ✅ Tambah middleware CORS di Laravel
- ✅ Edit `config/cors.php` untuk allow semua origin (development only!)

### 5. **Status Code 500 (Internal Server Error)**
- ✅ Check Laravel error log: `storage/logs/laravel.log`
- ✅ Mungkin ada error di controller atau model
- ✅ Debug dengan `dd()` function di Laravel

### 6. **Data Form tidak muncul di UI**
- ✅ Cek response JSON format di Postman
- ✅ Pastikan response sesuai dengan FormDataModel
- ✅ Check error di Flutter console

---

## 📝 Format Response yang Diharapkan

```json
[
  {
    "gender": ["Laki-laki", "Perempuan"],
    "religion": ["Islam", "Kristen Protestan", "Kristen Katolik", "Hindu", "Buddha", "Konghucu"],
    "bank": ["BCA", "BRI", "Mandiri", "BTN", "CIMB Niaga", "Maybank"]
  }
]
```

---

## 🎯 Checklist

- [ ] Laravel backend running di port 8000
- [ ] Database sudah di-migrate
- [ ] Route `/api/form-data` sudah ada
- [ ] CORS middleware sudah dikonfigurasi
- [ ] Base URL sudah benar di Flutter (10.0.2.2 untuk emulator)
- [ ] Flutter emulator/device sudah running
- [ ] Test koneksi berhasil

---

## 💡 Tips

1. **Gunakan Hot Reload**: Saat edit Flutter code, press `r` di terminal
2. **Check Network Tab**: Di Flutter DevTools → Network tab
3. **Print Debug**: Gunakan `print()` untuk debugging di console
4. **Use Postman**: Test API di Postman dulu sebelum di Flutter

---

## 📞 Need Help?

Jika masih error, cek:
1. Laravel error log: `storage/logs/laravel.log`
2. Flutter console output
3. Network tab di Browser DevTools
4. Pastikan Laravel dan Flutter run di terminal yang berbeda
