import "package:flutter/material.dart";
import "package:kcr_project_flutter/services/file_services.dart";
import "package:kcr_project_flutter/utils/app_styles.dart";
import "package:kcr_project_flutter/widgets/custom_textfield.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FileServices fileServices = FileServices();

  @override
  void dispose() {
    removeListener();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addListener();
  }

  void addListener() {
    List<TextEditingController> controllers = [
      fileServices.titleController,
      fileServices.descriptionController,
      fileServices.tagsController
    ];
    for (TextEditingController controller in controllers) {
      controller.addListener(_onFieldChanged);
    }
  }

  void removeListener() {
    List<TextEditingController> controllers = [
      fileServices.titleController,
      fileServices.descriptionController,
      fileServices.tagsController
    ];
    for (TextEditingController controller in controllers) {
      controller.removeListener(_onFieldChanged);
    }
  }

  void _onFieldChanged() {
    setState(() {
      fileServices.fieldsNotEmpty =
          fileServices.titleController.text.isNotEmpty &&
              fileServices.descriptionController.text.isNotEmpty &&
              fileServices.tagsController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.dark,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _mainButton(() => null, 'new file'),
                  _mainButton(null, "data"), // Disabled button
                  Row(
                    children: [
                      _actionButton(Icons.file_upload, () => null),
                      const SizedBox(width: 8),
                      _actionButton(Icons.folder, () => null),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              CustomTextField(
                maxLength: 100,
                maxLines: 3,
                hintText: 'Enter Video Title',
                controller: fileServices.titleController,
              ),
              const SizedBox(height: 40),
              CustomTextField(
                maxLength: 5000,
                maxLines: 6,
                hintText: 'Enter Video Description',
                controller: fileServices.descriptionController,
              ),
              const SizedBox(height: 40),
              CustomTextField(
                maxLength: 500,
                maxLines: 4,
                hintText: 'Enter Video Tags',
                controller: fileServices.tagsController,
              ),
              //const SizedBox(height: 20),
              Row(
                children: [
                  _mainButton(
                      fileServices.fieldsNotEmpty
                          ? () => fileServices.saveContent(context)
                          : null,
                      "Save Button"),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ));
  }

  ElevatedButton _mainButton(Function()? onPressed, String data) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _buttonStyle(),
      child: Text(data),
    );
  }

  IconButton _actionButton(IconData icon, Function()? onPressed) {
    return IconButton(
      //splashRadius: 20,
      onPressed: onPressed,
      //splashColor: AppTheme.accent,
      icon: Icon(icon, color: AppTheme.medium),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      // default system button style
      backgroundColor: AppTheme.accent,
      foregroundColor: AppTheme.dark,
      disabledBackgroundColor: AppTheme.disabledBackgroundColor,
      disabledForegroundColor: AppTheme.disabledForegroundColor,
    );
  }
}
