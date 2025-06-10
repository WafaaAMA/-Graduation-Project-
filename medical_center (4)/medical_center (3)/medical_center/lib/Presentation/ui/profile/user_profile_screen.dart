import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/Core/api/database/cachehelper.dart';
import 'package:medical_center/Presentation/cubit/auth_cubit_cubit.dart';
import 'package:medical_center/Presentation/ui/profile/edit_profile_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF199A8E),
        elevation: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.edit, color: Colors.white),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const EditProfileScreen()),
          //     );
          //   },
          //   tooltip: 'Edit Profile',
          // ),
        ],
      ),
      body: Center( 
        child: BlocConsumer<AuthCubit, AuthCubitState>(
          listener: (context, state) {
            if (state is ProfilePictureUploaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Profile picture updated'),
                  backgroundColor: const Color(0xFF199A8E),
                ),
              );
              context.read<AuthCubit>().getUserData();
            }
            if (state is ProfilePictureDeleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Profile picture deleted'),
                  backgroundColor: Colors.redAccent,
                ),
              );
              context.read<AuthCubit>().getUserData();
            }
            if (state is AuthError || state is GetUserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state is AuthError ? state.message : (state as GetUserError).message,
                  ),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is GetUserLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF199A8E),
                ),
              );
            } else if (state is GetUserSuccess) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // User Information Card
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoRow(Icons.person, 'Name', state.user.name),
                              const Divider(),
                              _buildInfoRow(Icons.email, 'Email', state.user.email),
                              const Divider(),
                              _buildInfoRow(Icons.phone, 'Phone', state.user.phone),
                              const Divider(),
                              _buildInfoRow(
                                Icons.wc,
                                'Gender',
                                state.user.gender == 1 ? 'Male' : 'Female',
                              ),
                              const Divider(),
                              _buildInfoRow(Icons.cake, 'Age', state.user.age.toString()),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // زر Sign Out تم إلغاؤه
                    ],
                  ),
                ),
              );
            } else if (state is GetUserError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.redAccent,
                      size: 60,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Failed to load user data: ${state.message}',
                      style: const TextStyle(fontSize: 16, color: Colors.redAccent),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<AuthCubit>().getUserData();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF199A8E),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Colors.grey,
                      size: 60,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'No user data found',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<AuthCubit>().getUserData();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Load Data'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF199A8E),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  // Helper method to build info rows
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF199A8E), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}