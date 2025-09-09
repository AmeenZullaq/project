
// =============================================================================
// EXAMPLE 2: UNIVERSAL/APP LINKS (https://myapp.com) 
// =============================================================================

/*
UNIVERSAL/APP LINKS EXAMPLE

This example demonstrates handling HTTPS-based universal links like "https://myapp.com/product/123"

WHAT THIS EXAMPLE DOES:
1. Handles universal links (https://myapp.com)
2. Processes different paths and parameters
3. Navigates to appropriate screens based on URL structure   
4. Provides testing interface with simulation buttons

URL PATTERNS SUPPORTED:
- https://myapp.com/product?id=123
- https://myapp.com/profile?userId=456
- https://myapp.com/settings

DEPENDENCIES NEEDED:
app_links: ^3.4.3

CONFIGURATION REQUIRED:

ANDROID (android/app/src/main/AndroidManifest.xml):
Add inside <activity> tag:
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="https" android:host="myapp.com" />
</intent-filter>

Also add to verify domain ownership:
Create file: android/app/src/main/res/values/strings.xml
<resources>
    <string name="asset_statements" translatable="false">[{
        \"relation\": [\"delegate_permission/common.handle_all_urls\"],
        \"target\": {
            \"namespace\": \"android_app\",
            \"package_name\": \"com.your.package\",
            \"sha256_cert_fingerprints\": [\"YOUR_SHA256_FINGERPRINT\"]
        }
    }]</string>
</resources>

iOS (ios/Runner/Info.plist):
Add before </dict>:
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>myapp.universallink</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>https</string>
        </array>
    </dict>
</array>

<key>com.apple.developer.associated-domains</key>
<array>
    <string>applinks:myapp.com</string>
</array>

DOMAIN CONFIGURATION:
You need to host a file at: https://myapp.com/.well-known/apple-app-site-association
{
    "applinks": {
        "apps": [],
        "details": [
            {
                "appID": "TEAMID.com.your.package",
                "paths": ["*"]
            }
        ]
    }
}

TESTING:
Android: adb shell am start -W -a android.intent.action.VIEW -d "https://myapp.com/product?id=123" com.your.package
iOS: xcrun simctl openurl booted "https://myapp.com/product?id=123"
*/

// Uncomment this section to use the Universal Links example instead of Custom Scheme

/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:app_links/app_links.dart';

void main() {
  runApp(UniversalLinksApp());
}

class UniversalLinksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Universal Links Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: UniversalLinksHomeScreen(),
      routes: {
        '/home': (context) => UniversalLinksHomeScreen(),
        '/product': (context) => UniversalLinksProductScreen(),
        '/profile': (context) => UniversalLinksProfileScreen(),
        '/settings': (context) => UniversalLinksSettingsScreen(),
      },
    );
  }
}

class UniversalLinksHomeScreen extends StatefulWidget {
  @override
  _UniversalLinksHomeScreenState createState() => _UniversalLinksHomeScreenState();
}

class _UniversalLinksHomeScreenState extends State<UniversalLinksHomeScreen> {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  String _lastLink = 'No universal link received';

  @override
  void initState() {
    super.initState();
    _initUniversalLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initUniversalLinks() async {
    _appLinks = AppLinks();

    // Handle app launch from deep link (when app is closed)
    final appLink = await _appLinks.getInitialAppLink();
    if (appLink != null) {
      _handleUniversalLink(appLink);
    }

    // Handle deep links when app is already running
    _linkSubscription = _appLinks.uriLinkStream.listen(
      (uri) {
        _handleUniversalLink(uri);
      },
      onError: (err) {
        print('Universal link error: $err');
      },
    );
  }

  void _handleUniversalLink(Uri uri) {
    setState(() {
      _lastLink = uri.toString();
    });

    print('Received universal link: $uri');

    // Only handle https://myapp.com links
    if (uri.scheme == 'https' && uri.host == 'myapp.com') {
      _navigateBasedOnPath(uri.path, uri.queryParameters);
    }
  }

  void _navigateBasedOnPath(String path, Map<String, String> params) {
    switch (path) {
      case '/product':
        final productId = params['id'] ?? '1';
        Navigator.pushNamed(
          context,
          '/product',
          arguments: {'id': productId},
        );
        break;
      case '/profile':
        final userId = params['userId'] ?? 'default';
        Navigator.pushNamed(
          context,
          '/profile',
          arguments: {'userId': userId},
        );
        break;
      case '/settings':
        Navigator.pushNamed(context, '/settings');
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unknown universal link path: $path')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universal Links'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.green[50],
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Universal Links Example (https://myapp.com)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Last Universal Link:',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      _lastLink,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Test Universal Links:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildTestButton(
              'Product Page',
              'https://myapp.com/product?id=789',
              () => _simulateLink('https://myapp.com/product?id=789'),
            ),
            _buildTestButton(
              'Profile Page',
              'https://myapp.com/profile?userId=101',
              () => _simulateLink('https://myapp.com/profile?userId=101'),
            ),
            _buildTestButton(
              'Settings Page',
              'https://myapp.com/settings',
              () => _simulateLink('https://myapp.com/settings'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestButton(String title, String link, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12),
        ),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(link, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  void _simulateLink(String link) {
    _handleUniversalLink(Uri.parse(link));
  }
}

class UniversalLinksProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final productId = args?['id'] ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(
        title: Text('Product (Universal Link)'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag, size: 80, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'Product ID: $productId',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Opened via Universal Link (https://myapp.com)',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class UniversalLinksProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final userId = args?['userId'] ?? 'Guest';

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile (Universal Link)'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.purple,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'User ID: $userId',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Opened via Universal Link (https://myapp.com)',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class UniversalLinksSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings (Universal Link)'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings, size: 80, color: Colors.orange),
            SizedBox(height: 20),
            Text(
              'Settings Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Opened via Universal Link (https://myapp.com)',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
*/

/*
SUMMARY:

TO USE EXAMPLE 1 (Custom Scheme):
1. Uncomment nothing - the custom scheme example is active by default
2. Add uni_links: ^0.5.1 to pubspec.yaml
3. Configure Android and iOS as shown in comments above
4. Test with: myapp://product?id=123

TO USE EXAMPLE 2 (Universal Links):
1. Comment out the entire first example (lines with CustomScheme classes)
2. Uncomment the entire second example (lines with UniversalLinks classes)
3. Add app_links: ^3.4.3 to pubspec.yaml
4. Configure Android and iOS as shown in comments above
5. Set up domain verification files
6. Test with: https://myapp.com/product?id=123

Each example is completely independent and demonstrates a different approach to deep linking in Flutter.
*/
