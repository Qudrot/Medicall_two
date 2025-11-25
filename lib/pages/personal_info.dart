import 'package:first_wtf_app/widgets/custom_textfield.dart';
import 'package:first_wtf_app/widgets/password_textfield.dart';
import 'package:flutter/material.dart';

void _showPersonalInfoSheet(BuildContext context, var currentUser) {
    // Controllers pre-filled with current data
    final nameController = TextEditingController(text: currentUser.name);
    final emailController = TextEditingController(text: currentUser.email);
    final passwordController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. Drag Handle
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(height: 20),
                
                const Text("Personal Information",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                
                const SizedBox(height: 20),

                // 2. Profile Picture
                Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade300, width: 2),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: currentUser.profilePicture.isNotEmpty
                              ? NetworkImage(currentUser.profilePicture)
                              : const AssetImage("assets/profile_pics.jpg") as ImageProvider, 
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // 3. Name Field (Using your CustomTextField)
                CustomTextField(
                  label: "Full Name",
                  textEditingController: nameController,
                ),
                
                const SizedBox(height: 16),

                // 4. Email Field (Using your CustomTextField)
                CustomTextField(
                  label: "Email Address",
                  textEditingController: emailController,
                ),
                
                const SizedBox(height: 16),

                // 5. Password Field (Using your PasswordTextfield)
                // This will now have the working eye icon!
                PasswordTextfield(
                  label: "New Password",
                  textEditingController: passwordController,
                ),
                
                const SizedBox(height: 24),

                // 6. Update Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                      )
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Update Information", style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }