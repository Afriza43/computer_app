import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.blue, // You can customize the background color
            child: Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'assets/profile_image.jpg'), // Add your image asset here
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'John Doe', // Replace with the user's name
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'john.doe@example.com', // Replace with the user's email
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 16),
          // Add other user information or customization as needed
        ],
      ),
    );
  }
}
