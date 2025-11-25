import 'package:first_wtf_app/model/user_detail.dart';
import 'package:first_wtf_app/pages/notifications_page.dart';
import 'package:first_wtf_app/provider/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildProfilePics(),
          _buildDetails(),
          SizedBox(height: 16),

          _buildAccountSection(),
          SizedBox(height: 16),

          _buildSupportSection(),
          SizedBox(height: 56),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade100,
              foregroundColor: Colors.red.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              userProvider.logout();

              Navigator.pushReplacementNamed(context, "/login");
            },
            icon: Icon(Icons.logout),
            label: Text("Logout"),
          ),
        ],
      ),
    );
  }

  Column _buildSupportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Support",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        ListTile(
          title: Text("About us", style: TextStyle(fontSize: 16)),
          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 16),
        ),
        Divider(),
        ListTile(
          title: Text("Contact us", style: TextStyle(fontSize: 16)),
          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 16),
        ),
      ],
    );
  }

  Column _buildAccountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Account",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        ListTile(
          title: Text("Personal Information", style: TextStyle(fontSize: 16)),
          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 16),
        ),
        Divider(),
        ListTile(
          title: Text("Payment Mwthods", style: TextStyle(fontSize: 16)),
          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 16),
        ),
        Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return NotificationsPage();
                },
              ),
            );
          },
          title: Text("Notifications", style: TextStyle(fontSize: 16)),
          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 16),
        ),
      ],
    );
  }

  Widget _buildProfilePics() {
    UserDetail? user = Provider.of<UserNotifier>(context).loggedInUser;

    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle),
      clipBehavior: Clip.hardEdge,
      child: user!.profilePicture.isEmpty
          ? Icon(Icons.person_2, size: 100)
          : Image.network(user!.profilePicture, width: 100, height: 100),
    );
  }

  Widget _buildDetails() {
    UserDetail? user = Provider.of<UserNotifier>(context).loggedInUser;

    if (user == null) return Text("User Details not set");

    return Column(
      children: [
        Text(
          user.name,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),

        IconButton(
              icon: Icon(Icons.edit, size: 18, color: Colors.blue),
              onPressed: () => _showEditBottomSheet(context, user),
            ),

        Text(
          user.email,
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
        ),
      ],
    );
  }

  void _showEditBottomSheet(BuildContext context, var currentUser) {
    // 1. Create Controllers and pre-fill them with existing data
    final nameController = TextEditingController(text: currentUser.name);
    final phoneController = TextEditingController(text: currentUser.phoneNumber);
    final addressController = TextEditingController(text: currentUser.address);
    final occupationController = TextEditingController(text: currentUser.occupation);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // This allows the sheet to go full height if needed
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          // This padding ensures the keyboard pushes the sheet up
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 20),
                Text("Edit Profile",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                
                // Name Field
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),

                // Phone Field
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),

                // Address Field
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: "Address",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),

                 // Occupation Field
                TextField(
                  controller: occupationController,
                  decoration: InputDecoration(
                    labelText: "Occupation",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, 
                      foregroundColor: Colors.white
                    ),
                   onPressed: (){},
                    child: Text("Save Changes"),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
