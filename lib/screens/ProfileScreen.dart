import 'package:antriksh/screens/Devices.dart';
import 'package:antriksh/screens/Faqscreen.dart';
import 'package:antriksh/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int _selectedIndex = 0;

  void _handleNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Add your navigation logic here
    print("Selected Index: $index");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 247, 252, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'Account',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    SectionHeader(title: 'PROFILE', actionText: 'Edit Profile!'),
                    AccountTile(
                      icon: Icons.person,
                      title: 'Profile',
                      children: [
                        ListTile(title: Text('Profile Details Here')),
                      ],
                    ),
                    SectionHeader(title: 'Devices'),
                    ListTile(
                      leading: Icon(Icons.devices),
                      title: Text('Devices'),
                      trailing: Icon(Icons.arrow_forward), // Add arrow icon
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Devices()),
                        );
                      },
                    ),
                    SectionHeader(title: 'ABOUT'),
                    AccountTile(
                      icon: Icons.contact_mail,
                      title: 'Contact Us',
                      children: [
                        ContactInfo(),
                      ],
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      leading: Icon(Icons.help_outline),
                      title: Text('FAQs'),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FAQScreen()),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {},
                    ),
                    SizedBox(height: 20),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      leading: Icon(Icons.delete, color: Colors.red),
                      title: Text(
                        'Delete Account',
                        style: TextStyle(color: Colors.red),
                      ),
                      trailing: Icon(Icons.arrow_forward, color: Colors.red),
                      onTap: () {
                        // Add delete functionality here
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;

  const SectionHeader({required this.title, this.actionText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          if (actionText != null)
            Text(
              actionText!,
              style: TextStyle(color: Colors.blue),
            ),
        ],
      ),
    );
  }
}

class AccountTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> children;

  const AccountTile({
    required this.icon,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(icon),
      title: Text(title),
      tilePadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      children: children,
      collapsedShape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.transparent),
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.transparent),
      ),
    );
  }
}

class ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          tileColor: Colors.white,
          title: Text('Email'),
          subtitle: Text(
            'App_support@SP4ameya.com',
            style: TextStyle(color: Colors.red),
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          tileColor: Colors.white,
          title: Text('Phone Number'),
          subtitle: Text(
            '+91 99163 87717',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
