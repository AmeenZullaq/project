/*

⚙️ Configuring Deep Linking in Flutter

🟢 Android Configration:

1. Open AndroidManifest.xml

2. Inside the <activity> tag, add an <intent-filter> to specify the deep link handling:

<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data
        android:scheme="my flutter name"
        android:host="example.com"           // website domain
        android:pathPrefix="/Products"
    />
</intent-filter>


🟢 IOS Configration:

1. Open Info.plist

2. Add the following keys to your Info.plist file :

<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>my flutter name</string>
        </array>
        <key>CFBundleURLName</key>
        <string></strigng>
        <key>CFBundleURLTypes</key>
    </dict>
</array>
*/

import 'package:flutter/material.dart';

class DeepLinksEx extends StatelessWidget {
  const DeepLinksEx({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('DeepLinksEx'),
            SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Tshirt(
                      category: 'Tshirt',
                      price: '1000',
                      imageUrl:
                          'https://images.vexels.com/media/users/3/142546/isolated/preview/2f6d0faa355125320122dc57e8b07084-tshirt-icon.png',
                    ),
                  ),
                );
              },
              child: Text(
                'Tshirt1',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Settings(),
                  ),
                );
              },
              child: Text(
                'settings',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Tshirt extends StatelessWidget {
  const Tshirt({
    super.key,
    required this.category,
    required this.price,
    required this.imageUrl,
  });
  final String category;
  final String price;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: Image.network(
                'https://images.vexels.com/media/users/3/142546/isolated/preview/2f6d0faa355125320122dc57e8b07084-tshirt-icon.png',
              ),
            ),
            Text(
              category,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              price,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Settings',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
