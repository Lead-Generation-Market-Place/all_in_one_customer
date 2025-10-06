import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/core/auth/auth_manager.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign In")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child:Center(child: TextButton(onPressed: () => _showLogoutConfirmation(context), child: Text('Log Out'),),)
          // Card(child: ListTile(
          //   onTap: _showLogoutConfirmation(context),
          //   leading: Icon(Icons.logout),
          //   title: Text('Log Out'),),)
            
          
        
      ),
    );
  }
}

 void  _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sign Out'),
        content: Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _performLogout(context);
            },
            child: Text('Sign Out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _performLogout(BuildContext context) {
    final authManager = Provider.of<AuthManager>(context, listen: false);
    authManager.logout();
  }


