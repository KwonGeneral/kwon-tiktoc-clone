import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/feed/view/feed_page.dart';
import '../../presentation/main/main_shell.dart';
import 'route_paths.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: RoutePaths.feed,
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: RoutePaths.feed,
            builder: (context, state) => const FeedPage(),
          ),
          GoRoute(
            path: RoutePaths.discover,
            builder: (context, state) => const _PlaceholderPage(title: '탐색'),
          ),
          GoRoute(
            path: RoutePaths.notifications,
            builder: (context, state) =>
                const _PlaceholderPage(title: '알림'),
          ),
          GoRoute(
            path: RoutePaths.profile,
            builder: (context, state) =>
                const _PlaceholderPage(title: '프로필'),
          ),
        ],
      ),
    ],
  );
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
