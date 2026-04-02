import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/camera/view/camera_page.dart';
import '../../presentation/feed/view/feed_page.dart';
import '../../presentation/friends/view/friends_page.dart';
import '../../presentation/main/main_shell.dart';
import '../../presentation/notifications/view/notifications_page.dart';
import '../../presentation/profile/view/profile_page.dart';
import '../../presentation/user_profile/view/user_profile_page.dart';
import 'route_paths.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: RoutePaths.feed,
    routes: [
      // 유저 프로필 (ShellRoute 밖 — 하단 네비 없음)
      GoRoute(
        path: RoutePaths.userProfile,
        builder: (context, state) {
          final userId = state.pathParameters['userId']!;
          return UserProfilePage(userId: userId);
        },
      ),
      // 카메라 (ShellRoute 밖 — 전체 화면)
      GoRoute(
        path: RoutePaths.camera,
        builder: (context, state) => const CameraPage(),
      ),
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
                builder: (context, state) => const SizedBox.shrink(),
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
