import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/core/constants/app_constants.dart';
import 'package:flutter_application_1/models/selected_file.dart';
import 'package:http/retry.dart';
import 'package:image_picker/image_picker.dart';

Color _kLabelColor = Colors.grey.shade800;

InputDecoration buildInputDecoration({
  String? hintText,
  Widget? prefixIcon,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    hintText: hintText,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),

    // Border Default / Enabled
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColor.fieldBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColor.fieldBorder),
    ),
    // Focused Border (Saat diklik)
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColor.primary, width: 2),
    ),
    // Error Border
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.red, width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.red, width: 2),
    ),
  );
}

class CustomTextSectionHeader extends StatelessWidget {
  final String title;

  const CustomTextSectionHeader({super.key, this.title = "JUDUL"});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class BuildEmailField extends StatelessWidget {
  final TextEditingController controller;

  const BuildEmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: buildInputDecoration(
        hintText: 'Email Anda',
        prefixIcon: const Icon(
          Icons.email_outlined,
          color: AppColor.inactiveTextField,
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email tidak boleh kosong';
        }
        if (!value.contains('@')) {
          return 'Email tidak valid';
        }
        return null;
      },
    );
  }
}

class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool isObscure;
  final VoidCallback onToggleVisibility;
  final String labelText;
  final String? comparisonValue;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.isObscure,
    required this.onToggleVisibility,
    required this.labelText,
    this.comparisonValue,
  });

  @override
  Widget build(BuildContext context) {
    final Icon visibilityIcon = Icon(
      isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
      color: AppColor.inactiveTextField,
    );

    return TextFormField(
      controller: controller,
      obscureText: isObscure,

      decoration: buildInputDecoration(
        hintText: 'Masukkan $labelText',
        prefixIcon: Icon(
          Icons.lock_outlined,
          color: AppColor.inactiveTextField,
        ),
        suffixIcon: IconButton(
          onPressed: onToggleVisibility,
          icon: visibilityIcon,
        ),
      ),

      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$labelText harus diisi';
        }

        if (comparisonValue != null && value != comparisonValue) {
          return 'Kata sandi tidak sama dengan yang di atas.';
        }

        if (comparisonValue == null && value.length < 8) {
          return '$labelText minimal 8 karakter';
        }

        return null;
      },
    );
  }
}

// 2. Custom TextFormField
class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final String? initialValue;
  final String labelText;
  final int maxLines;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.initialValue,
    this.labelText = 'Kolom ini',
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      initialValue: initialValue,
      decoration: buildInputDecoration(suffixIcon: suffixIcon),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$labelText tidak boleh kosong';
        }
        return null;
      },
    );
  }
}

class CustomNumberFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool allowDecimal;
  final int? maxLength;

  const CustomNumberFormField({
    super.key,
    required this.controller,
    this.labelText = 'Angka',
    this.allowDecimal = false,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final TextInputFormatter numberFormatter = allowDecimal
        ? FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
        : FilteringTextInputFormatter.digitsOnly;

    final TextInputType keyboard = allowDecimal
        ? TextInputType.numberWithOptions(decimal: true)
        : TextInputType.number;

    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      maxLength: maxLength,
      decoration: buildInputDecoration().copyWith(counterText: ''),
      inputFormatters: [
        numberFormatter,
        if (maxLength != null) LengthLimitingTextInputFormatter(maxLength!),
      ],
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$labelText tidak boleh kosong';
        }
        if (double.tryParse(value) == null) {
          return '$labelText harus berupa angka yang valid.';
        }
        return null;
      },
    );
  }
}

class CustomDropdownFormField extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String labelText;

  const CustomDropdownFormField({
    super.key,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    this.labelText = 'Pilihan',
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: buildInputDecoration(),
      isExpanded: true,
      hint: Text(hint, style: const TextStyle(color: Colors.grey)),
      value: value,
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null) {
          return 'Silakan pilih $labelText';
        }
        return null;
      },
    );
  }
}

// 4. Custom Phone Number Field
class CustomPhoneNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const CustomPhoneNumberField({
    super.key,
    required this.controller,
    this.labelText = 'Nomor telepon',
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      decoration: buildInputDecoration(
        prefixIcon: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '+62',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.grey),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$labelText tidak boleh kosong';
        }
        if (value.trim().length < 9) {
          return '$labelText terlalu pendek';
        }
        return null;
      },
    );
  }
}

// 5. Custom Image Picker Field
class CustomImagePickerField extends StatelessWidget {
  final Function(XFile) onImagePicked;
  final String? currentFileName;

  const CustomImagePickerField({
    super.key,
    required this.onImagePicked,
    this.currentFileName,
  });

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      onImagePicked(pickedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.fieldBorder,
          ), // Menggunakan konstanta file
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.photo_camera_outlined, color: Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                currentFileName ?? 'Pilih foto...',
                style: TextStyle(
                  color: currentFileName == null ? Colors.grey : Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RememberMeCheckbox extends StatelessWidget {
  final bool rememberMe;
  // Gunakan ValueChanged<bool?> untuk type safety pada Checkbox
  final ValueChanged<bool?> onChange;

  const RememberMeCheckbox({
    super.key,
    required this.rememberMe,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChange(!rememberMe);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                value: rememberMe,
                onChanged: onChange,
                activeColor: AppColor.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                side: BorderSide(color: AppColor.inactiveTextField, width: 2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "Ingat saya",
              style: TextStyle(fontSize: 14, color: AppColor.inactiveTextField),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTagInputField extends StatefulWidget {
  final String labelText;
  final ValueChanged<List<String>> onChanged;
  final String hintText;

  const CustomTagInputField({
    super.key,
    required this.labelText,
    required this.onChanged,
    this.hintText = 'Ketik lalu tekan Enter atau Koma',
  });

  @override
  State<CustomTagInputField> createState() => _CustomTagInputFieldState();
}

class _CustomTagInputFieldState extends State<CustomTagInputField> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _tags = [];
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _textController.addListener(_handleTextChange);
  }

  // Menangani perubahan teks, khusus untuk memicu penambahan tag saat koma (,) diketik
  void _handleTextChange() {
    String text = _textController.text;
    if (text.endsWith(',')) {
      String tagText = text.substring(0, text.length - 1);
      _addTag(tagText);
    }
  }

  void _addTag(String text) {
    final trimmedText = text.trim();
    if (trimmedText.isNotEmpty && !_tags.contains(trimmedText)) {
      setState(() {
        _tags.add(trimmedText);
        widget.onChanged(_tags); // Panggil callback
        _textController.clear();
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
      widget.onChanged(_tags); // Panggil callback
    });
  }

  @override
  void dispose() {
    _textController.removeListener(_handleTextChange);
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Tampilan Chips dan Input Teks digabungkan dalam Wrap
    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _focusNode.hasFocus
                ? AppColor.primary
                : AppColor.fieldBorder,
            width: _focusNode.hasFocus ? 2 : 1,
          ),
        ),
        child: Wrap(
          spacing: 8.0, // Jarak horizontal antar chips
          runSpacing: 4.0, // Jarak vertikal antar baris chips
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            // Chips yang sudah ditambahkan
            ..._tags.map((tag) {
              return Chip(
                label: Text(tag),
                backgroundColor: AppColor.primary.withOpacity(0.1),
                labelStyle: const TextStyle(
                  color: AppColor.primary,
                  fontSize: 14,
                ),
                deleteIcon: const Icon(
                  Icons.close,
                  size: 16,
                  color: AppColor.primary,
                ),
                onDeleted: () => _removeTag(tag),
                padding: const EdgeInsets.all(4.0),
              );
            }).toList(),

            // Input Teks untuk Menambahkan Tag
            IntrinsicWidth(
              child: TextField(
                controller: _textController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: _tags.isEmpty ? widget.hintText : '',
                  hintStyle: const TextStyle(fontSize: 14),
                  // Menghilangkan semua dekorasi bawaan TextField
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
                style: const TextStyle(fontSize: 14),
                // Menggunakan RawKeyboardListener jika ingin mendukung Backspace untuk menghapus tag terakhir
                onSubmitted: (value) {
                  _addTag(value);
                },
                keyboardType: TextInputType.text,
                minLines: 1,
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 6. WRAPPER UNTUK LABEL DAN SPACING (Yang dipindahkan dari screen utama)
class LabeledFormWrapper extends StatelessWidget {
  final String label;
  final Widget child;
  final double verticalSpacing;

  const LabeledFormWrapper({
    super.key,
    required this.label,
    required this.child,
    this.verticalSpacing = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _kLabelColor,
            ),
          ),
        ),
        child,
        SizedBox(height: verticalSpacing), // Spasi antar field
      ],
    );
  }
}

class CustomFilePickerField extends StatefulWidget {
  final ValueChanged<List<PlatformFile>> onFilesPicked;
  final List<String> allowedExtensions;
  final String labelText;
  final int maxFiles;

  const CustomFilePickerField({
    super.key,
    required this.onFilesPicked,
    this.allowedExtensions = const ['pdf', 'doc', 'docx', 'jpg', 'png'],
    required this.labelText,
    required this.maxFiles,
  });

  @override
  State<CustomFilePickerField> createState() => _CustomFilePickerFieldState();
}

class _CustomFilePickerFieldState extends State<CustomFilePickerField> {
  List<PlatformFile> _selectedFiles = [];

  // Fungsi utilitas untuk format ukuran file
  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes bytes';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  // Fungsi untuk memicu pemilihan file (Sekarang bisa multiple)
  Future<void> _pickFiles() async {
    try {
      // Logika dinamis: allowMultiple diatur ke false jika maxFiles adalah 1
      final bool allowMulti = widget.maxFiles > 1;

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: widget.allowedExtensions,
        allowMultiple: allowMulti,
      );

      if (result != null) {
        List<PlatformFile> newFiles = result.files;
        List<PlatformFile> allFiles = [];

        if (allowMulti) {
          // Mode Multi-Select: Gabungkan dengan file yang sudah ada
          allFiles = [..._selectedFiles, ...newFiles];
        } else {
          // Mode Single-Select (maxFiles=1): Ganti file lama dengan yang baru
          allFiles = newFiles;
        }

        // Hapus duplikat berdasarkan nama file dan batasi jumlah file
        Map<String, PlatformFile> uniqueFiles = {};
        for (var file in allFiles) {
          // Menggunakan nama file sebagai kunci unik
          uniqueFiles[file.name] = file;
        }

        List<PlatformFile> finalFiles = uniqueFiles.values.toList();

        if (finalFiles.length > widget.maxFiles) {
          // Beri pesan peringatan jika melebihi batas
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Maksimal ${widget.maxFiles} file yang diizinkan.'),
            ),
          );
          finalFiles = finalFiles.sublist(0, widget.maxFiles);
        }

        setState(() {
          _selectedFiles = finalFiles;
        });

        widget.onFilesPicked(_selectedFiles);
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  void _removeFile(PlatformFile fileToRemove) {
    setState(() {
      _selectedFiles.removeWhere((file) => file.name == fileToRemove.name);
    });
    widget.onFilesPicked(_selectedFiles);
  }

  @override
  Widget build(BuildContext context) {
    final bool hasFiles = _selectedFiles.isNotEmpty;
    final int filesCount = _selectedFiles.length;
    final bool isSingleFileMode = widget.maxFiles == 1;
    final String buttonText;

    if (isSingleFileMode) {
      buttonText = hasFiles
          ? 'Ganti ${widget.labelText} (${_selectedFiles.first.name})'
          : 'Pilih 1 ${widget.labelText}';
    } else {
      buttonText = filesCount < widget.maxFiles
          ? 'Pilih hingga ${widget.maxFiles - filesCount} ${widget.labelText} lainnya'
          : 'Batas ${widget.maxFiles} file tercapai';
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.fieldBorder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Tombol Utama untuk Memilih File
          GestureDetector(
            onTap: filesCount < widget.maxFiles || isSingleFileMode
                ? _pickFiles
                : null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                // Warna abu-abu jika batas sudah tercapai dan bukan mode single file
                color: filesCount < widget.maxFiles || isSingleFileMode
                    ? null
                    : AppColor.fieldBorder.withOpacity(0.3),
                borderRadius: filesCount > 0 && !isSingleFileMode
                    ? const BorderRadius.vertical(top: Radius.circular(8))
                    : BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    color: filesCount < widget.maxFiles || isSingleFileMode
                        ? AppColor.primary
                        : Colors.grey,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        color: filesCount < widget.maxFiles || isSingleFileMode
                            ? AppColor.primary
                            : Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
          ),

          // 2. Daftar File yang Sudah Dipilih (Hanya ditampilkan jika mode multi-file,
          // atau jika mode single-file tapi ada file yang terpilih)
          if (hasFiles && !isSingleFileMode)
            ..._selectedFiles.map(
              (file) => Column(
                children: [
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColor.fieldBorder,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.insert_drive_file_outlined,
                          color: AppColor.inactiveTextField,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                file.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                _formatFileSize(file.size ?? 0),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            size: 20,
                            color: Colors.red,
                          ),
                          onPressed: () => _removeFile(file),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // 2B. Tampilan File untuk Mode Single File (maxFiles=1)
          if (hasFiles && isSingleFileMode)
            Column(
              children: [
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColor.fieldBorder,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.insert_drive_file_outlined,
                        color: AppColor.inactiveTextField,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _selectedFiles.first.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              _formatFileSize(_selectedFiles.first.size ?? 0),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          size: 20,
                          color: Colors.red,
                        ),
                        onPressed: () => _removeFile(_selectedFiles.first),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class CustomSubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomSubmitButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}

class CustomScheduleField extends StatefulWidget {
  final bool isSelected;
  final VoidCallbackAction onTap;

  const CustomScheduleField({
    super.key,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  State<CustomScheduleField> createState() => _CustomScheduleFieldState();
}

class _CustomScheduleFieldState extends State<CustomScheduleField> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}