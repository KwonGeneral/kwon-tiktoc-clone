import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_strings.dart';
import '../theme/app_colors.dart';
import '../../presentation/feed/view/feed_page.dart';
import '../../presentation/friends/view/friends_page.dart';
import '../../presentation/main/main_shell.dart';
import '../../presentation/notifications/view/notifications_page.dart';
import '../../presentation/profile/view/profile_page.dart';
import 'route_paths.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: RoutePaths.feed,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.feed,
                builder: (context, state) => const FeedPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.friends,
                builder: (context, state) => const FriendsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.discover,
                builder: (context, state) => const _CreatePlaceholder(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.notifications,
                builder: (context, state) => const NotificationsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.profile,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class _CreatePlaceholder extends StatelessWidget {
  const _CreatePlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          AppStrings.placeholderCreate,
          style: TextStyle(color: AppColors.whiteSecondary, fontSize: 16),
        ),
      ),
    );
  }
}
