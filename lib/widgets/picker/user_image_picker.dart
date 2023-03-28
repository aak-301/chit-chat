import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.imagPicked});

  final Function(File pickedImage) imagPicked;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  @override
  bool selectFromGallery = false;
  File? _pickedImage;

  Future<void> _modalBottomSheetMenu() async {
    await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        context: context,
        builder: (builder) {
          return Container(
              height: 120.0,
              color: Colors.transparent,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.folder),
                    title: const Text('Select from gallery'),
                    onTap: () {
                      setState(() {
                        selectFromGallery = true;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.camera_alt_outlined),
                    title: const Text('Take Picture'),
                    onTap: () {
                      setState(() {
                        selectFromGallery = false;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
        });
  }

  Future<void> _pickImage() async {
    await _modalBottomSheetMenu();
    XFile? image;
    final ImagePicker _picker = ImagePicker();
    if (selectFromGallery) {
      image = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 40, maxWidth: 150);
    } else {
      image = await _picker.pickImage(
          source: ImageSource.camera, imageQuality: 40, maxWidth: 150);
    }
    setState(() {
      _pickedImage = File(image!.path);
    });
    widget.imagPicked(_pickedImage!);
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage == null ? null : FileImage(_pickedImage!),
          radius: 40,
        ),
        TextButton.icon(
          style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(
              TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: const Text('Add Image'),
        ),
      ],
    );
  }
}
