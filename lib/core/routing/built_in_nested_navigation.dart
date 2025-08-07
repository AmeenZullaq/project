/*
🔄 What is Nested Navigation in Flutter?
Nested navigation means having multiple independent navigation stacks inside your app — usually one inside another — so that each part of your app can navigate separately.

📦 Real-World Example:
Imagine a bottom navigation bar app with three tabs:

🏠 Home

🔍 Search

⚙️ Settings

Each tab should maintain its own navigation history. For example:

You open Home, tap into Details, then switch to Search

When you go back to Home, it should still show the Details screen, not reset to the main Home

That’s where nested navigation comes in — each tab has its own Navigator.

✅ When Should You Use Nested Navigation?
Use it when:

You have BottomNavigationBar, TabBar, or a Drawer with sections that need independent navigation stacks

You want to preserve state/history within each section

You need modal or inner page flows inside a screen (e.g., onboarding flow inside a settings screen)

 
 
 | Feature                | Normal Navigation      | Nested Navigation            |
| ---------------------- | ---------------------- | ---------------------------- |
| Single Stack           | ✅                      | ❌ (multiple stacks)          |
| Keeps screen history   | ❌ Resets on tab switch | ✅ Each tab maintains history |
| Useful for complex UIs | ❌ Not ideal            | ✅ Recommended                |
| Performance            | ✅ Lightweight          | Slightly heavier             |
 
 */

// *************** Nested Navigation with built in navigator ***************

import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  TabsScreenState createState() => TabsScreenState();
}

class TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0;

  final _libraryKey = GlobalKey<NavigatorState>();
  final _playlistKey = GlobalKey<NavigatorState>();
  final _searchKey = GlobalKey<NavigatorState>();
  final _settingsKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // LibraryScreen(),
          // PlaylistsScreen(),
          // SearchScreen(),
          // SettingsScreen(),
          _buildNavigator(_libraryKey, LibraryScreen()),
          _buildNavigator(_playlistKey, PlaylistsScreen()),
          _buildNavigator(_searchKey, SearchScreen()),
          _buildNavigator(_settingsKey, SettingsScreen()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => _onTap(index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Playlists',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildNavigator(GlobalKey<NavigatorState> key, Widget screen) {
    return Navigator(
      // here there is navigator for each tab, and each navigator has a navigation stack
      key:
          key, // even if we have not gave a key for each navigator, it will work well, because each navigator has a key by default
      onGenerateRoute: (route) => MaterialPageRoute(
        settings: route,
        builder: (context) => screen,
      ),
    );
  }

  void _onTap(int index) {
    if (_currentIndex == index) {
      // Popping to root of current tab
      switch (index) {
        //****************** that way 👇 will not work well so we use keys to pop to root of each tab ********************
        // case 0:
        //   Navigator.popUntil(context, (route) => route.isFirst); //  here we can not determine which tab we are in so we used keys
        //   break;
        // case 1:
        //   Navigator.popUntil(context, (route) => route.isFirst);
        //   break;
        // case 2:
        //   Navigator.popUntil(context, (route) => route.isFirst);
        //   break;
        // case 3:
        //   Navigator.popUntil(context, (route) => route.isFirst);
        //   break;

        // we only used keys for that 👇
        case 0:
          _libraryKey.currentState!.popUntil((route) => route.isFirst);
          break;
        case 1:
          _playlistKey.currentState!.popUntil((route) => route.isFirst);
          break;
        case 2:
          _searchKey.currentState!.popUntil((route) => route.isFirst);
          break;
        case 3:
          _settingsKey.currentState!.popUntil((route) => route.isFirst);
          break;
      }
    } else {
      if (mounted) {
        setState(() => _currentIndex = index);
      }
    }
  }
}

// ------------------ Screens & Subscreens ------------------

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Go to Library Details'),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => LibraryDetailsScreen()),
            );
          },
        ),
      ),
    );
  }
}

class LibraryDetailsScreen extends StatelessWidget {
  const LibraryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Library Details')),
      body: Center(child: Text('Details Page in Library Tab')),
    );
  }
}

class PlaylistsScreen extends StatelessWidget {
  const PlaylistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Go to Playlist Details'),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => PlaylistDetailsScreen()),
            );
          },
        ),
      ),
    );
  }
}

class PlaylistDetailsScreen extends StatelessWidget {
  const PlaylistDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Playlist Details')),
      body: Center(child: Text('Playlis Page in Playlists Tab')),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Go to Search Details'),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => SearchDetailsScreen()),
            );
          },
        ),
      ),
    );
  }
}

class SearchDetailsScreen extends StatelessWidget {
  const SearchDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Details')),
      body: Center(child: Text('Search Page in Search Tab')),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Go to Settings Details'),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => SettingsDetailsScreen()),
            );
          },
        ),
      ),
    );
  }
}

class SettingsDetailsScreen extends StatelessWidget {
  const SettingsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings Details')),
      body: Center(child: Text('Settings Page in Settings Tab')),
    );
  }
}
