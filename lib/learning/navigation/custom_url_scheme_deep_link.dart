// =============================================================================
// EXAMPLE 1: CUSTOM URL SCHEME DEEP LINKS (myapp://)
// =============================================================================

/*
CUSTOM URL SCHEME EXAMPLE

This example demonstrates handling custom URL schemes like "myapp://product/123"

WHAT THIS EXAMPLE DOES:
1. Handles custom URL schemes (myapp://)
2. Processes different paths and parameters
3. Navigates to appropriate screens based on URL structure
4. Provides testing interface with simulation buttons

URL PATTERNS SUPPORTED:
- myapp://product?id=123
- myapp://profile?userId=456
- myapp://settings

DEPENDENCIES NEEDED:
uni_links: ^0.5.1

CONFIGURATION REQUIRED:

ANDROID (android/app/src/main/AndroidManifest.xml):
Add inside <activity> tag:
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="myapp" />
</intent-filter>

iOS (ios/Runner/Info.plist):
Add before </dict>:
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>myapp.deeplink</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>myapp</string>
        </array>
    </dict>
</array>

TESTING:
Android: adb shell am start -W -a android.intent.action.VIEW -d "myapp://product?id=123" com.your.package
iOS: xcrun simctl openurl booted "myapp://product?id=123"
// */

import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:app_links/app_links.dart';

void main() {
  runApp(CustomSchemeDeepLinkApp());
}

class CustomSchemeDeepLinkApp extends StatelessWidget {
  const CustomSchemeDeepLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Scheme Deep Link Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CustomSchemeHomeScreen(),
      routes: {
        '/home': (context) => CustomSchemeHomeScreen(),
        '/product': (context) => CustomSchemeProductScreen(),
        '/profile': (context) => CustomSchemeProfileScreen(),
        '/settings': (context) => CustomSchemeSettingsScreen(),
      },
    );
  }
}

class CustomSchemeHomeScreen extends StatefulWidget {
  const CustomSchemeHomeScreen({super.key});

  @override
  CustomSchemeHomeScreenState createState() => CustomSchemeHomeScreenState();
}

class CustomSchemeHomeScreenState extends State<CustomSchemeHomeScreen> {
  StreamSubscription<Uri>? _linkSubscription;
  String _lastLink = 'No custom scheme link received';

  @override
  void initState() {
    super.initState();
    _initCustomSchemeLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initCustomSchemeLinks() async {
    try {
      final appLinks = AppLinks();

      // Handle app launch from deep link (when app is closed)
      // getInitialLink(): gives you the deep link that the user tapped on which launched (opened) the app.
      // if the app is alread opened, getInitialLink() will return null
      // we use appLinks.getInitialLink() because when app is closed and then user tap n a link
      //and app opened the appLinks.uriLinkStream.listen does not work because flutter is inisialize
      //so we use getInitialLink and pass initialLink to _handleCustomSchemeLink
      final initialLink = await appLinks.getInitialLink();
      if (initialLink != null) {
        _handleCustomSchemeLink(initialLink);
      }
    } catch (e) {
      log('Failed to initialize custom scheme links: $e');
    }
  }

  void _handleCustomSchemeLink(Uri uri) {
    setState(() {
      _lastLink = uri.toString();
    });

    log('Received custom scheme link: $uri');

    // Only handle myapp:// scheme
    if (uri.scheme == 'myapp') {
      _navigateBasedOnPath(uri.host, uri.queryParameters);
    }
  }

  void _navigateBasedOnPath(String path, Map<String, String> params) {
    switch (path) {
      case 'product':
        final productId = params['id'] ?? '1';
        Navigator.pushNamed(
          context,
          '/product',
          arguments: {'id': productId},
        );
        break;
      case 'profile':
        final userId = params['userId'] ?? 'default';
        Navigator.pushNamed(
          context,
          '/profile',
          arguments: {'userId': userId},
        );
        break;
      case 'settings':
        Navigator.pushNamed(context, '/settings');
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unknown custom scheme path: $path')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Scheme Deep Links'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.blue[50],
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Custom Scheme Example (myapp://)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Last Custom Scheme Link:',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      _lastLink,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Test Custom Scheme Links:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildTestButton(
              'Product Page',
              'myapp://product?id=123',
              () => _simulateLink('myapp://product?id=123'),
            ),
            _buildTestButton(
              'Profile Page',
              'myapp://profile?userId=456',
              () => _simulateLink('myapp://profile?userId=456'),
            ),
            _buildTestButton(
              'Settings Page',
              'myapp://settings',
              () => _simulateLink('myapp://settings'),
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
          backgroundColor: Colors.blue,
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
    _handleCustomSchemeLink(Uri.parse(link));
  }
}

class CustomSchemeProductScreen extends StatelessWidget {
  const CustomSchemeProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final productId = args?['id'] ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(
        title: Text('Product (Custom Scheme)'),
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
              'Opened via Custom Scheme (myapp://)',
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

class CustomSchemeProfileScreen extends StatelessWidget {
  const CustomSchemeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final userId = args?['userId'] ?? 'Guest';

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile (Custom Scheme)'),
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
              'Opened via Custom Scheme (myapp://)',
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

class CustomSchemeSettingsScreen extends StatelessWidget {
  const CustomSchemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings (Custom Scheme)'),
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
              'Opened via Custom Scheme (myapp://)',
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
