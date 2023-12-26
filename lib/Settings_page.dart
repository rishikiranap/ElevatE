import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'LikedQuotesPage.dart';
import 'main.dart';
import 'global.dart';
import 'app_settings.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkModeEnabled = false;
  bool areNotificationsEnabled = false;
  int numberOfQuotes = 6;

  @override
  Widget build(BuildContext context) {
    var appSettings = Provider.of<AppSettings>(context);
    bool isDarkModeEnabled = appSettings.isDarkModeEnabled;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Settings'),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/img.png', // Replace with the correct path to your dummy logo
                width: 65,
                height: 65,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text('Experience Mode'),
              value: isDarkModeEnabled,
              onChanged: (value) {
                setState(() {
                  isDarkModeEnabled = value;
                  Provider.of<AppSettings>(context, listen: false)
                      .toggleTheme();
                });
                // Add logic to change the theme based on the switch state
                // You can use a theme provider or directly update the theme here
              },
            ),
            SwitchListTile(
              title: Text('Notifications'),
              value: areNotificationsEnabled,
              onChanged: (value) {
                setState(() {
                  areNotificationsEnabled = value;
                });
                // Add logic to enable/disable notifications based on the switch state
              },
            ),
            ListTile(
              title: Text('Number of Quotes to Display'),
              subtitle: Text('Current: ${appSettings.numberOfQuotes}'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Add logic to show a dialog or navigate to a page for editing the number of quotes
                  // For simplicity, a dialog is used here
                  _showNumberOfQuotesDialog(context, appSettings);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(label: "home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Liked"),
          BottomNavigationBarItem(
              label: "settings", icon: Icon(Icons.settings)),
        ],
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FirstPage(quotes: globalQuotes)),
            );
            print(globalQuotes);
          }
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LikedQuotesPage()),
            );
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          }
        },
      ),
    );
  }

  void _showNumberOfQuotesDialog(
      BuildContext context, AppSettings appSettings) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Number of Quotes'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Enter the number of quotes to display:'),
              SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  // Validate and update the number of quotes
                  if (value.isNotEmpty) {
                    appSettings.updateNumberOfQuotes(int.parse(value));
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add logic to save the new number of quotes
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
