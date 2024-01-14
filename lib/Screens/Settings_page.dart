import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'liked_quotes_page.dart';
import '../Utils/global.dart';
import '../Models/app_settings.dart';
import 'first_page.dart';
import '../Widgets/navbar_widget.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool areNotificationsEnabled = false;
  int numberOfQuotes = 6;
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    var appSettings = Provider.of<AppSettings>(context);
    bool isDarkModeEnabled = appSettings.isDarkModeEnabled;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Settings'),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/img.png',
                // Replace with the correct path to your dummy logo
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
              title: const Text('Experience Mode'),
              value: isDarkModeEnabled,
              onChanged: (value) {
                setState(() {
                  isDarkModeEnabled = value;
                  Provider.of<AppSettings>(context, listen: false)
                      .toggleTheme();
                });
              },
            ),
            ListTile(
              title: const Text('Number of Quotes to Display'),
              subtitle: Text('Current: ${appSettings.numberOfQuotes}'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showNumberOfQuotesDialog(context, appSettings);
                },
              ),
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                _showAboutDialog(context);
              },
            ),
            // New ListTile for Ethical and Privacy Concerns
            ListTile(
              title: const Text('Ethical and Privacy Concerns'),
              onTap: () {
                _showEthicalPrivacyDialog(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
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

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          title: const Center(
            child: Text('About the App'),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/img.png',
                // Replace with the correct path to your app logo
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 16),
              const Text('ElevatE V1.0'),
              // Add more details about your app
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showNumberOfQuotesDialog(
      BuildContext context, AppSettings appSettings) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Number of Quotes'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter the number of quotes to display:'),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
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
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showEthicalPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ethical and Privacy Concerns'),
          content: const SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 12.0),
                Text(
                  'We prioritize your privacy and are committed to the ethical use of data. Below are key aspects related to privacy and ethics in our application:',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                ListTile(
                  title: Text(
                    '1. Data Collection:',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'We collect minimal data necessary for the functionality of the app. This may include user preferences and interactions within the app.',
                  ),
                ),
                SizedBox(height: 8.0),
                ListTile(
                  title: Text(
                    '2. User Input:',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Any information provided by users, such as mood selections or custom settings, is stored securely on your device. We do not transmit this data to external servers without your explicit consent. However, the mood selection you choose is sent to an external API for generating motivational quotes.',
                  ),
                ),
                SizedBox(height: 8.0),
                ListTile(
                  title: Text(
                    '3. Data Security:',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Your data is stored securely and is inaccessible to unauthorized parties. We use industry-standards to protect your information.',
                  ),
                ),
                SizedBox(height: 8.0),
                ListTile(
                  title: Text(
                    '4. Third-Party Services:',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'The app may use third-party services for certain features. Your input data is used carefully and with utmost security, and privacy are ensured.',
                  ),
                ),
                SizedBox(height: 8.0),
                ListTile(
                  title: Text(
                    '5. Updates and Notifications:',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Periodic updates may be released to enhance app features. You will be notified about updates, and your data will not be used for any purpose other than improving your experience.',
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'If you have any questions or concerns regarding privacy and ethics, please contact our support team at support@elevate.com.',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
