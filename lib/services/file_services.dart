import "dart:io";

import "package:file_picker/file_picker.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:kcr_project_flutter/utils/snackbar_utils.dart";

class FileServices {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();

  bool fieldsNotEmpty = false;

  File? _selectedFile;
  String _selectedDirectory = "";

  void saveContent(context) async {
    final title = titleController.text;
    final description = descriptionController.text;
    final tags = tagsController.text;

    final textContent = """
      Title: $title
      Description: $description
      Tags: $tags
    """;

    try {
      if (_selectedFile == null) {
        await _selectedFile!.writeAsString(textContent);
        return;
      } else {
        final todayDate = getTodayDate();
        String metadataDirPath = _selectedDirectory;
        if (metadataDirPath.isNotEmpty) {
          final directory = await FilePicker.platform.getDirectoryPath();
          _selectedDirectory = metadataDirPath = directory!;
        }
        final filePath = "$metadataDirPath/$todayDate - $title - Metadata.txt";
        final newfile = File(filePath);
        await newfile.writeAsString(textContent);
      }
      SnackBarUtils.showSnackBar(context, Icons.check_circle, 'File is saved');
    } catch (e) {
      SnackBarUtils.showSnackBar(context, Icons.error, 'File is not saved');
    }
  }

  static String getTodayDate() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    final formattedDate = formatter.format(now);
    return formattedDate;
  }
}
