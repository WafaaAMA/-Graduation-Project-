import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_center/Presentation/cubit/auth_cubit_cubit.dart';

class PickImage extends StatelessWidget {
  const PickImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<AuthCubit, AuthCubitState>(
          builder: (context, state) {
            return context.read<AuthCubit>().profileImage == null
                ? const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage("assets/profile.png"),
                  )
                : CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(File(context.read<AuthCubit>().profileImage!.path)),
                  );
          },
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: IconButton(
            onPressed: () {
              ImagePicker().pickImage(source: ImageSource.gallery).then((val) {
                if (val != null) {
                  context.read<AuthCubit>().uploadImage(val);
                }
              });
            },
            icon: const Icon(Icons.add_a_photo),
          ),
        ),
      ],
    );
  }
}