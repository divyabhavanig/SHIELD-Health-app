import 'package:flutter/material.dart';
import '../components/my_drawer_tile.dart';
import '../pages/about_us_page.dart';
import '../pages/settings_page.dart';
import '../pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // Define the logout method
  Future<void> _logout(BuildContext context) async {
    // Clear shared preferences (if any)
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigate to the LoginPage and remove all previous routes
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage(onTap: () {})),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // App logo
          Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: SizedBox(
                height: 100,
                width: 100,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage('lib/images/Designer.png'),
                          fit: BoxFit.fill)),
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          // Home list tile
          MyDrawerTile(
            text: "H O M E",
            icon: Icons.home,
            onTap: () => Navigator.pop(context),
          ),
          // Settings list tile
          MyDrawerTile(
            text: "S E T T I N G S",
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
          // About us list tile
          MyDrawerTile(
            text: "A B O U T  U S",
            icon: Icons.people,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutUsApp(),
                ),
              );
            },
          ),
          const Spacer(),
          // Logout list tile
          MyDrawerTile(
            text: "L O G O U T",
            icon: Icons.logout,
            onTap: () {
              _logout(context);
            },
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
